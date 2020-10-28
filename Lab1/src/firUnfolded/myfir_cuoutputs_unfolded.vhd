
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.NUMERIC_STD.all;

entity MYFIR_CUOUTPUTS_UNFOLDED is
  port (
    CLK        : in    std_logic;
    RST_N      : in    std_logic;
    START      : in    std_logic;
    TC_CNT_MUX : in    std_logic;
    EN_CNT_MUX : out   std_logic;
    LOAD_OUT   : inout std_logic;
    VOUT       : out   std_logic
  );
end entity MYFIR_CUOUTPUTS_UNFOLDED;

architecture BEH of MYFIR_CUOUTPUTS_UNFOLDED is

  component FF is
    port (
      FF_IN          : in    std_logic;
      FF_OUT         : out   std_logic;
      CLK            : in    std_logic
      RST            : in    std_logic
      LOAD           : in    std_logic
    );
  end component;

  type state_type is (rst, idle, counting);

  signal state : state_type;
  signal ff_en : std_logic;

begin

  STATE_TRANSITION_PROCESS : process(clk, rst_n) is
  begin

    if (rst_n = '0') then
      state <= rst;
    elsif (clk'event and clk = '1') then

      case state is

        when rst =>
          state <= idle;

        when idle =>
          if (start = '1') then
            state <= counting;
          else
            state <= idle;
          end if;

        when counting =>
          if (tc_cnt_mux = '1') then
            if (start = '1') then
              state <= counting;
            else
              state <= idle;
            end if;
          else
            state <= counting;
          end if;

      end case;

    end if;

  end process STATE_TRANSITION_PROCESS;

  OUTPUT_EVALUATION_PROCESS : process(state) is
  begin

    en_cnt_mux <= '0';
    load_out   <= '0';
    ff_en      <= '1';

    case state is

      when rst =>

      when idle =>

      when counting =>
        en_cnt_mux <= '1';
        load_out   <= '1';
        ff_en      <= '1';

    end case;

  end process OUTPUT_EVALUATION_PROCESS;

  DELAY_REG : FF
    port map (load_out, vout, clk, rst_n, ff_en);

end architecture BEH;
