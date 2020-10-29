
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_signed.all;
------------------------------------------------------------------------

entity MYFIR_DP_UNFOLDED is
  port (
    CLK        : in    std_logic;
    RST_N      : in    std_logic;
    DIN        : in    signed(10 downto 0);
    LOAD_BUFF  : in    std_logic;
    LOAD_STATE : in    std_logic;
    BUFF_ON    : in    std_logic;
    LOAD_OUT   : in    std_logic;
    LOAD_RES   : in    std_logic;
    TC_ACK_IN  : in    std_logic;
    EN_CNT_MUX : in    std_logic;
    EN_CNT_IN  : in    std_logic;
    H0         : in    signed(10 downto 0);
    H1         : in    signed(10 downto 0);
    H2         : in    signed(10 downto 0);
    H3         : in    signed(10 downto 0);
    H4         : in    signed(10 downto 0);
    H5         : in    signed(10 downto 0);
    H6         : in    signed(10 downto 0);
    H7         : in    signed(10 downto 0);
    H8         : in    signed(10 downto 0);
    TC_CNT_IN  : out   std_logic;
    TC_CNT_MUX : out   std_logic;
    DOUT       : out   signed(10 downto 0)
  );
end entity MYFIR_DP_UNFOLDED;

architecture BEH of MYFIR_DP_UNFOLDED is

  component REG is
    generic (
      N : integer := 8
    );
    port (
      REG_IN  : in    signed(N - 1 downto 0);
      REG_OUT : out   signed(N - 1 downto 0);
      CLK     : in    std_logic;
      RST_N   : in    std_logic;
      LOAD    : in    std_logic
    );
  end component;

  component MUX3XNTO1XN is
    generic (
      N : integer := 8
    );
    port (
      IN_MUX0 : in    signed (N - 1 downto 0);
      IN_MUX1 : in    signed (N - 1 downto 0);
      IN_MUX2 : in    signed (N - 1 downto 0);
      OUT_MUX : out   signed (N - 1 downto 0);
      SEL_MUX : in    unsigned (1 downto 0)
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

  type vector is array (8 downto 0) of signed(7 downto 0);

  type state_vector_type is array (10 downto 0) of signed(7 downto 0);

  type out_vect_type is array (2 downto 0) of signed(7 downto 0);

  signal coeff                   : vector;
  signal state_vector            : state_vector_type;
  signal out_vect,    out_mux_in : out_vect_type;
  signal out_cnt_mux, cnt_out    : unsigned (1 downto 0);
  signal din8                    : signed(7 downto 0);
  signal reg_out0                : signed(7 downto 0);
  signal input_buff_out1         : signed(7 downto 0);
  signal input_buff_out2         : signed(7 downto 0);
  signal output_buff_in          : signed (10 downto 0);
  signal out_mux_out             : signed (7 downto 0);
  signal var                     : signed(21 downto 0);
  signal load_state0             : std_logic;
  signal load_state1             : std_logic;
  signal load_state2             : std_logic;
  signal vdd                     : std_logic;
  signal gnd                     : std_logic;

begin

  vdd <= '1';
  gnd <= '0';

  din8     <= DIN(10 downto 3);
  coeff(0) <= H0(10 downto 3);
  coeff(1) <= H1(10 downto 3);
  coeff(2) <= H2(10 downto 3);
  coeff(3) <= H3(10 downto 3);
  coeff(4) <= H4(10 downto 3);
  coeff(5) <= H5(10 downto 3);
  coeff(6) <= H6(10 downto 3);
  coeff(7) <= H7(10 downto 3);
  coeff(8) <= H8(10 downto 3);

  output_buff_in <= out_mux_out & "000";

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

  RESULT_REG_GEN : for i in 0 to 2 generate

    RESULT_REG : REG
      generic map (8
      )
      port map (out_vect(i), out_mux_in(i), clk, rst_n, load_res);
      end generate RESULT_REG_GEN;

      INPUT_BUFFER1 : REG
        port map (DIN8, input_buff_out1, clk, rst_n, BUFF_ON);

      INPUT_BUFFER2 : REG
        port map (input_buff_out1, input_buff_out2, clk, rst_n, LOAD_BUFF);

      CNT_IN : CNT_MOD
        generic map (2, 3
        )
        port map (clk, rst_n, EN_CNT_IN, TC_ACK_IN, TC_CNT_IN, cnt_out);

          OUTPUT_BUFFER : REG
            generic map (11
            )
            port map (output_buff_in, DOUT, clk, rst_N, load_out);

              OUT_MUX : MUX3XNTO1XN
                port map (out_mux_in(0), out_mux_in(1), out_mux_in(2), out_mux_out, out_cnt_mux);

              MUX_CNT : N_COUNTER
                generic map (2, 3
                )
                port map (clk, en_cnt_mux, rst_n, vdd, tc_cnt_mux, out_cnt_mux);

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

                  EVALUATION_PROCESS : process (state_vector, coeff) is

                    variable tmp      : out_vect_type;
                    variable tmp_mult : signed (15 downto 0);

                  begin

                    tmp(0)       := (others => '0');
                    tmp(1)       := (others => '0');
                    tmp(2)       := (others => '0');
                    tmp_mult     := (others => '0');
                    for i in 0 to 2 loop
                      for j in 0 to 8 loop
                        tmp_mult := (coeff(j) * state_vector(i + j));
                        tmp(i)   := tmp(i) + tmp_mult(14 downto 7);
                      end loop;
                    end loop;
                    out_vect(2) <= tmp(0);
                    out_vect(1) <= tmp(1);
                    out_vect(0) <= tmp(2);

                  end process EVALUATION_PROCESS;

end architecture BEH;
