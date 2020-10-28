
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.NUMERIC_STD.all;

entity MYFIR_CUPIPE_UNFOLDED is
  port (
    CLK        : in    std_logic;
    RST_N      : in    std_logic;
    START_PIPE : in    std_logic;
    LOAD_RES   : out   std_logic;
    START_OUT  : out   std_logic
  );
end entity MYFIR_CUPIPE_UNFOLDED;

architecture BEH of MYFIR_CUPIPE_UNFOLDED is

  type state_type is (rst, idle, start_outs);

  signal state : state_type;
  signal vdd   : std_logic;

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
          if (start_pipe = '1') then
            state <= start_outs;
          else
            state <= idle;
          end if;

        when start_outs =>
          state <= idle;

      end case;

    end if;

  end process STATE_TRANSITION_PROCESS;

  OUTPUT_EVALUATION_PROCESS : process(state) is
  begin

    load_res  <= '0';
    start_out <= '0';

    case state is

      when rst =>

      when idle =>

      when start_outs =>
        load_res  <= '1';
        start_out <= '1';

    end case;

  end process OUTPUT_EVALUATION_PROCESS;

end architecture BEH;
