library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clk_gen is
  port (
    END_SIM : in std_logic;
    CLK     : out std_logic;
    RST_n   : out std_logic);
end clk_gen;

architecture beh of clk_gen is

  signal CLK_i : std_logic;

  constant ts : time := 10 ns;

begin -- beh

  process
  begin -- process
    if (CLK_i = 'U') then
      CLK_i <= '0';
    else
      CLK_i <= not(CLK_i);
    end if;
    wait for ts/2;
  end process;

  CLK <= CLK_i and not(END_SIM);

  process
  begin -- process
    RST_n <= '0';
    wait for 2.5 * ts/2;
    RST_n <= '1';
    wait;
  end process;

end beh;