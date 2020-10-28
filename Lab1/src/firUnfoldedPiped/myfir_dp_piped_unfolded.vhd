
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_signed.all;
------------------------------------------------------------------------

entity MYFIR_DP_UNFOLDED is
  port (
    CLK          : in    std_logic;
    RST_N        : in    std_logic;
    DIN          : in    signed(10 downto 0);
    LOAD_BUFF    : in    std_logic;
    LOAD_STATE   : in    std_logic;
    BUFF_ON      : in    std_logic;
    LOAD_OUT     : in    std_logic;
    LOAD_RES     : in    std_logic;
    TC_ACK_IN    : in    std_logic;
    EN_CNT_MUX   : in    std_logic;
    EN_CNT_IN    : in    std_logic;
    H0           : in    signed(10 downto 0);
    H1           : in    signed(10 downto 0);
    H2           : in    signed(10 downto 0);
    H3           : in    signed(10 downto 0);
    H4           : in    signed(10 downto 0);
    H5           : in    signed(10 downto 0);
    H6           : in    signed(10 downto 0);
    H7           : in    signed(10 downto 0);
    H8           : in    signed(10 downto 0);
    STATE0_DEBUG : out   signed (10 downto 0); -- DEBUG SIGNALS
    STATE1_DEBUG : out   signed (10 downto 0); -- DEBUG SIGNALS
    STATE2_DEBUG : out   signed (10 downto 0); -- DEBUG SIGNALS
    TC_CNT_IN    : out   std_logic;
    TC_CNT_MUX   : out   std_logic;
    DOUT         : out   signed(10 downto 0)
  );
end entity MYFIR_DP_UNFOLDED;
------------------------------------------------------------------------

architecture BEH of MYFIR_DP_UNFOLDED is

  ------------------------------------------------------------------------

  component REG is
    port (
      REG_IN  : in    signed(10 downto 0);
      REG_OUT : out   signed(10 downto 0);
      CLK     : in    std_logic
      RST_N   : in    std_logic
      LOAD    : in    std_logic
    );
  end component;

  component MUX3X11TO1X11 is
    port (
      IN_MUX0 : in    signed (10 downto 0);
      IN_MUX1 : in    signed (10 downto 0);
      IN_MUX2 : in    signed (10 downto 0);
      OUT_MUX : out   signed (10 downto 0);
      SEL_MUX : unsigned (1 downto 0)
    );
  end component;

  component N_COUNTER is
    generic (
      N      : integer := 6;
      MODULE : integer := 42
    );
    port (
      CLK        : in    std_logic;
      EN         : in    std_logic;
      RST_N      : in    std_logic;
      RST0_RST1N : in    std_logic;
      CNT_END    : out   std_logic;
      CNT_OUT    : buffer unsigned(N - 1 downto 0)
    );
  end component;

  component CNT_MOD is
    generic (
      N      : positive := 2;
      MODULE : integer := 3
    );
    port (
      CLK     : in    std_logic;
      RSTN    : in    std_logic;
      EN_CNT  : in    std_logic;
      TC_ACK  : in    std_logic;
      TC      : out   std_logic;
      CNT_OUT : out   unsigned (N - 1 downto 0)
    );
  end component cnt_mod;

  ------------------------------------------------------------------------

  type vector is array (8 downto 0) of signed(10 downto 0);

  type state_vector_type is array (10 downto 0) of signed(10 downto 0);

  type out_vect_type is array (2 downto 0) of signed(10 downto 0);

  type tmp_vect_type is array (2 downto 0) of signed(21 downto 0);

  type tmp_vect_type_pipe_mult is array (8 downto 0) of signed(21 downto 0);

  type tmp_vect_type_pipe1 is array (8 downto 0) of signed(10 downto 0);

  type tmp_vect_type_pipe2 is array (4 downto 0) of signed(10 downto 0);

  type tmp_vect_type_pipe3 is array (2 downto 0) of signed(10 downto 0);

  type tmp_vect_type_pipe4 is array (1 downto 0) of signed(10 downto 0);

  signal state0_pipe1_in         : tmp_vect_type_pipe1; -- pipe 1st stage reg inputs
  signal state1_pipe1_in         : tmp_vect_type_pipe1; -- pipe 1st stage reg inputs
  signal state2_pipe1_in         : tmp_vect_type_pipe1; -- pipe 1st stage reg inputs
  signal state0_pipe1_out        : tmp_vect_type_pipe1; -- pipe 1st stage reg outputs
  signal state1_pipe1_out        : tmp_vect_type_pipe1; -- pipe 1st stage reg outputs
  signal state2_pipe1_out        : tmp_vect_type_pipe1; -- pipe 1st stage reg outputs

  signal state0_pipe2_in         : tmp_vect_type_pipe2; -- pipe 1st stage reg inputs
  signal state1_pipe2_in         : tmp_vect_type_pipe2; -- pipe 1st stage reg inputs
  signal state2_pipe2_in         : tmp_vect_type_pipe2; -- pipe 1st stage reg inputs
  signal state0_pipe2_out        : tmp_vect_type_pipe2; -- pipe 2nd stage reg outputs
  signal state1_pipe2_out        : tmp_vect_type_pipe2; -- pipe 2nd stage reg outputs
  signal state2_pipe2_out        : tmp_vect_type_pipe2; -- pipe 2nd stage reg outputs

  signal state0_pipe3_in         : tmp_vect_type_pipe3; -- pipe 1st stage reg inputs
  signal state1_pipe3_in         : tmp_vect_type_pipe3; -- pipe 1st stage reg inputs
  signal state2_pipe3_in         : tmp_vect_type_pipe3; -- pipe 1st stage reg inputs
  signal state0_pipe3_out        : tmp_vect_type_pipe3; -- pipe 3rd stage reg outputs
  signal state1_pipe3_out        : tmp_vect_type_pipe3; -- pipe 3rd stage reg outputs
  signal state2_pipe3_out        : tmp_vect_type_pipe3; -- pipe 3rd stage reg outputs

  signal state0_pipe4_in         : tmp_vect_type_pipe4; -- pipe 1st stage reg inputs
  signal state1_pipe4_in         : tmp_vect_type_pipe4; -- pipe 1st stage reg inputs
  signal state2_pipe4_in         : tmp_vect_type_pipe4; -- pipe 1st stage reg inputs
  signal state0_pipe4_out        : tmp_vect_type_pipe4; -- pipe 4th stage reg outputs
  signal state1_pipe4_out        : tmp_vect_type_pipe4; -- pipe 4th stage reg outputs
  signal state2_pipe4_out        : tmp_vect_type_pipe4; -- pipe 4th stage reg outputs

  signal coeff                   : vector;
  signal state_vector            : state_vector_type;
  signal out_vect,    out_mux_in : out_vect_type;
  signal out_cnt_mux, cnt_out    : unsigned (1 downto 0);
  --signal reg_out : vector2;
  signal ff_out                  : signed(7 downto 0);
  signal reg_out0                : signed(10 downto 0);
  signal out_mux_out             : signed(10 downto 0);
  signal input_buff_out1         : signed(10 downto 0);
  signal input_buff_out2         : signed(10 downto 0);
  signal var                     : signed(21 downto 0);
  signal load_state0             : std_logic;
  signal load_state1             : std_logic;
  signal load_state2             : std_logic;
  signal vdd                     : std_logic;
  signal gnd                     : std_logic;
  ------------------------------------------------------------------------

begin

  vdd <= '1';
  gnd <= '0';

  coeff(0) <= H0;
  coeff(1) <= H1;
  coeff(2) <= H2;
  coeff(3) <= H3;
  coeff(4) <= H4;
  coeff(5) <= H5;
  coeff(6) <= H6;
  coeff(7) <= H7;
  coeff(8) <= H8;

  STATE0_DEBUG <= state_vector(2);
  STATE1_DEBUG <= state_vector(1);
  STATE2_DEBUG <= state_vector(0);

  STATE_VECT0_GEN : for i in 0 to 2 generate

    STATE_0_IN : if (i = 0) generate

      STATE_0 : REG
        port map (input_buff_out2, state_vector(3 * i + 2), clk, rst_N, load_state0);

    end generate STATE_0_IN;

    STATE_0 : if(i > 0) generate

      STATE_0 : REG
        port map (state_vector(3 * i - 1), state_vector(3 * i + 2), clk, rst_n, load_state0);

    end generate STATE_0;

  end generate STATE_VECT0_GEN;

  STATE_VECT1_GEN : for i in 0 to 3 generate

    STATE_1_IN : if (i = 0) generate

      STATE_1 : REG
        port map (input_buff_out2, state_vector(3 * i + 1), clk, rst_N, load_state1);

    end generate STATE_1_IN;

    STATE_1 : if(i > 0) generate

      STATE_1 : REG
        port map (state_vector(3 * i - 2), state_vector(3 * i + 1), clk, rst_n, load_state1);

    end generate STATE_1;

  end generate STATE_VECT1_GEN;

  STATE_VECT2_GEN : for i in 0 to 3 generate

    STATE_2_IN : if (i = 0) generate

      STATE_2 : REG
        port map (input_buff_out2, state_vector(3 * i), clk, rst_N, load_state2);

    end generate STATE_2_IN;

    STATE_2 : if(i > 0) generate

      STATE_2 : REG
        port map (state_vector(3 * i - 3), state_vector(3 * i), clk, rst_n, load_state2);

    end generate STATE_2;

  end generate STATE_VECT2_GEN;

  INPUT_BUFFER1 : REG
    port map (DIN, input_buff_out1, clk, rst_n, BUFF_ON);

  INPUT_BUFFER2 : REG
    port map (input_buff_out1, input_buff_out2, clk, rst_n, LOAD_BUFF);

  CNT_IN : CNT_MOD
    generic map (2, 3
    )
    port map (clk, rst_n, EN_CNT_IN, TC_ACK_IN, TC_CNT_IN, cnt_out;
  )

      OUTPUT_BUFFER : REG
        port map (out_mux_out, DOUT, clk, rst_N, load_out);

      OUT_MUX : MUX3X11TO1X11
        port map (out_mux_in(0), out_mux_in(1), out_mux_in(2), out_mux_out, out_cnt_mux);

      MUX_CNT : N_COUNTER
        generic map (2, 3
        )
        port map (clk, en_cnt_mux, rst_n, vdd, tc_cnt_mux, out_cnt_mux;
  )

          CNT_DECODE_PROCESS : process (cnt_out, LOAD_STATE) is
          begin

            case cnt_out is

              when "01" =>
                load_state0 <= '1' and LOAD_STATE;
                load_state1 <= '0' and LOAD_STATE;
                load_state2 <= '0' and LOAD_STATE;

              when "10" =>
                load_state0 <= '0' and LOAD_STATE;
                load_state1 <= '1' and LOAD_STATE;
                load_state2 <= '0' and LOAD_STATE;

              when "11" =>
                load_state0 <= '0' and LOAD_STATE;
                load_state1 <= '0' and LOAD_STATE;
                load_state2 <= '1' and LOAD_STATE;

              when others =>
                load_state0 <= '0' and LOAD_STATE;
                load_state1 <= '0' and LOAD_STATE;
                load_state2 <= '0' and LOAD_STATE;

            end case;

          end process CNT_DECODE_PROCESS;

          -----------------------------------------------------------------------------------------
          -- PIPE ARCHITECTURE --

          -- 1st PIPE --
          PIPE1_EVALUATION_PROCESS : process (state_vector, coeff) is

            variable tmp0 : tmp_vect_type_pipe_mult;
            variable tmp1 : tmp_vect_type_pipe_mult;
            variable tmp2 : tmp_vect_type_pipe_mult;

          begin

            tmp0 := (others => (others => 0));
            tmp1 := (others => (others => 0));
            tmp2 := (others => (others => 0));

            -- partial results : multiplications --
            for i in 0 to 8 loop
              tmp0(i) := (coeff(i) * state_vector(i + 2));
              tmp1(i) := (coeff(i) * state_vector(i + 1));
              tmp2(i) := (coeff(i) * state_vector(i));
            end loop;
            state0_pipe1_in <= tmp0(20 downto 10);
            state1_pipe1_in <= tmp1(20 downto 10);
            state2_pipe1_in <= tmp2(20 downto 10);

          end process PIPE1_EVALUATION_PROCESS;

          -- pipe1 state 0 reg generate -- N.B.] ENABLE WITH LOAD_RES

          PIPE1_STATE0_GEN : for i in 0 to 8 generate

            PIPE1_STATE0 : REG
              port map (state0_pipe1_in(i), state0_pipe1_out(i), clk, rst_n, load_res1);

          end generate PIPE1_STATE0_GEN;

          -- pipe1 state 1 reg generate -- N.B.] ENABLE WITH LOAD_RES

          PIPE1_STATE1_GEN : for i in 0 to 8 generate

            PIPE1_STATE0 : REG
              port map (state1_pipe1_in(i), state1_pipe1_out(i), clk, rst_n, load_res1);

          end generate PIPE1_STATE0_GEN;

          -- pipe1 state 2 reg generate -- N.B.] ENABLE WITH LOAD_RES

          PIPE1_STATE2_GEN : for i in 0 to 8 generate

            PIPE1_STATE0 : REG
              port map (state2_pipe1_in(i), state2_pipe1_out(i), clk, rst_n, load_res1);

          end generate PIPE1_STATE0_GEN;

          -----------------------------------------------------------------------------------------------------
          -- 2nd PIPE --
          PIPE2_EVALUATION_PROCESS : process (state_vector, coeff) is

            variable tmp0 : tmp_vect_type_pipe2;
            variable tmp1 : tmp_vect_type_pipe2;
            variable tmp2 : tmp_vect_type_pipe2;
            variable k    : integer := 0;

          begin

            tmp0 := (others => (others => 0));
            tmp1 := (others => (others => 0));
            tmp2 := (others => (others => 0));

            -- partial results : sum --
            for i in 0 to 7 loop
              tmp0(k) := (state0_pipe1_out(i) + state0_pipe1_out(i + 1);
              tmp1(k) := (state1_pipe1_out(i) + state1_pipe1_out(i + 1);
              tmp2(k) := (state2_pipe1_out(i) + state2_pipe1_out(i + 1);
        i = i + 2;
        k = k + 1;
            end loop;
            tmp0(4)   := (state0_pipe1_out(8);
            tmp1(4)   := (state1_pipe1_out(8);
            tmp2(4)   := (state2_pipe1_out(8);
            state0_pipe2_in <= tmp0;
            state1_pipe2_in <= tmp1;
            state2_pipe2_in <= tmp2;

          end process PIPE2_EVALUATION_PROCESS;

          -- pipe2 state 0 reg generate -- N.B.] ENABLE WITH LOAD_RES2

          PIPE2_STATE0_GEN : for i in 0 to 4 generate

            PIPE2_STATE0 : REG
              port map (state0_pipe2_in(i), state0_pipe2_out(i), clk, rst_n, load_res2);

          end generate PIPE2_STATE0_GEN;

          -- pipe2 state 1 reg generate -- N.B.] ENABLE WITH LOAD_RES2

          PIPE2_STATE1_GEN : for i in 0 to 4 generate

            PIPE2_STATE0 : REG
              port map (state1_pipe2_in(i), state1_pipe2_out(i), clk, rst_n, load_res2);

          end generate PIPE2_STATE0_GEN;

          -- pipe2 state 2 reg generate -- N.B.] ENABLE WITH LOAD_RES2

          PIPE2_STATE2_GEN : for i in 0 to 4 generate

            PIPE2_STATE0 : REG
              port map (state2_pipe2_in(i), state2_pipe2_out(i), clk, rst_n, load_res2);

          end generate PIPE2_STATE0_GEN;

          ------------------------------------------------------------------------
          -- 3rd PIPE --

          PIPE3_EVALUATION_PROCESS : process (state_vector, coeff) is

            variable tmp0 : tmp_vect_type_pipe3;
            variable tmp1 : tmp_vect_type_pipe3;
            variable tmp2 : tmp_vect_type_pipe3;
            variable k    : integer := 0;

          begin

            tmp0 := (others => (others => 0));
            tmp1 := (others => (others => 0));
            tmp2 := (others => (others => 0));

            -- partial results : sum --
            for i in 0 to 1 loop
              tmp0(i) := (state0_pipe3_out(i) + state0_pipe3_out(i + 1);
              tmp1(i) := (state1_pipe3_out(i) + state1_pipe3_out(i + 1);
              tmp2(i) := (state2_pipe3_out(i) + state2_pipe3_out(i + 1);
        i = i + 2;
            end loop;
            tmp0(3)   := (state0_pipe3_out(2);
            tmp1(3)   := (state1_pipe3_out(2);
            tmp2(3)   := (state2_pipe3_out(2);
            state0_pipe3_in <= tmp0;
            state1_pipe3_in <= tmp1;
            state2_pipe3_in <= tmp2;

          end process PIPE3_EVALUATION_PROCESS;

          -- pipe3 state 0 reg generate -- N.B.] ENABLE WITH LOAD_RES2

          PIPE3_STATE0_GEN : for i in 0 to 2 generate

            PIPE3_STATE0 : REG
              port map (state0_pipe3_in(i), state0_pipe3_out(i), clk, rst_n, load_res3);

          end generate PIPE3_STATE0_GEN;

          -- pipe3 state 1 reg generate -- N.B.] ENABLE WITH LOAD_RES2

          PIPE3_STATE1_GEN : for i in 0 to 2 generate

            PIPE3_STATE0 : REG
              port map (state1_pipe3_in(i), state1_pipe3_out(i), clk, rst_n, load_res3);

          end generate PIPE3_STATE0_GEN;

          -- pipe3 state 2 reg generate -- N.B.] ENABLE WITH LOAD_RES2

          PIPE3_STATE2_GEN : for i in 0 to 2 generate

            PIPE3_STATE0 : REG
              port map (state2_pipe3_in(i), state2_pipe3_out(i), clk, rst_n, load_res3);

          end generate PIPE3_STATE0_GEN;

          ------------------------------------------------------------------------
          -- 4th PIPE --

          PIPE4_EVALUATION_PROCESS : process (state_vector, coeff) is

            variable tmp0 : tmp_vect_type_pipe4;
            variable tmp1 : tmp_vect_type_pipe4;
            variable tmp2 : tmp_vect_type_pipe4;

          begin

            tmp0 := (others => (others => 0));
            tmp1 := (others => (others => 0));
            tmp2 := (others => (others => 0));

            -- partial results : sum --
            tmp0(0) := (state0_pipe3_out(0) + state0_pipe3_out(1);
            tmp1(0) := (state1_pipe3_out(0) + state1_pipe3_out(1);
            tmp2(0) := (state2_pipe3_out(0) + state2_pipe3_out(1);
            tmp0(1) := (state0_pipe3_out(2);
            tmp1(1) := (state1_pipe3_out(2);
            tmp2(1) := (state2_pipe3_out(2);
            state0_pipe4_in <= tmp0;
            state1_pipe4_in <= tmp1;
            state2_pipe4_in <= tmp2;

          end process PIPE4_EVALUATION_PROCESS;

          -- pipe3 state 0 reg generate -- N.B.] ENABLE WITH LOAD_RES4

          PIPE4_STATE0_GEN : for i in 0 to 1 generate

            PIPE4_STATE0 : REG
              port map (state0_pipe3_in(i), state0_pipe3_out(i), clk, rst_n, load_res4);

          end generate PIPE4_STATE0_GEN;

          -- pipe3 state 1 reg generate -- N.B.] ENABLE WITH LOAD_RES4

          PIPE4_STATE1_GEN : for i in 0 to 1 generate

            PIPE4_STATE0 : REG
              port map (state1_pipe3_in(i), state1_pipe3_out(i), clk, rst_n, load_res4);

          end generate PIPE4_STATE0_GEN;

          -- pipe3 state 2 reg generate -- N.B.] ENABLE WITH LOAD_RES4

          PIPE4_STATE2_GEN : for i in 0 to 1 generate

            PIPE4_STATE0 : REG
              port map (state2_pipe3_in(i), state2_pipe3_out(i), clk, rst_n, load_res4);

          end generate PIPE4_STATE0_GEN;

          ------------------------------------------------------------------------
          -- 5th PIPE --

          PIPE5_EVALUATION_PROCESS : process (state_vector, coeff) is

            variable tmp0 : signed (10 downto 0);
            variable tmp1 : signed (10 downto 0);
            variable tmp2 : signed (10 downto 0);

          begin

            tmp0 := (others => 0);
            tmp1 := (others => 0);
            tmp2 := (others => 0);

            -- partial results : sum --
            tmp0 := (state0_pipe4_out(0) + state0_pipe4_out(1);
            tmp1 := (state1_pipe4_out(0) + state1_pipe4_out(1);
            tmp2 := (state2_pipe4_out(0) + state2_pipe4_out(1);
            out_vect(0) <= tmp0;
            out_vect(1) <= tmp1;
            out_vect(2) <= tmp2;

          end process PIPE5_EVALUATION_PROCESS;

          RESULT_REG_GEN : for i in 0 to 2 generate

            RESULT_REG : REG
              port map (out_vect(i), out_mux_in(i), clk, rst_n, load_res5);

          end generate RESULT_REG_GEN;

end architecture BEH;
