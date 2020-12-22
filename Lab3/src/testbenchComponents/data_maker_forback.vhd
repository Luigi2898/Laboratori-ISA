library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker_forback is
  port (
    CLK  : in  std_logic;
    DATA : out std_logic_vector(31 downto 0));
end data_maker_forback;

architecture beh of data_maker_forback is

begin  -- beh

  process (CLK)
    file fp : text open read_mode is "../file/input_random.hex";
    variable ptr : line;
    variable val : std_logic_vector(31 downto 0);
  begin  -- process
    if CLK'event and CLK = '1' then  -- rising clock edge
      if (not(endfile(fp))) then
        readline(fp, ptr);
        hread(ptr, val);
      end if;
      DATA <= val after 1 ns;
    end if;
  end process;

end beh;
