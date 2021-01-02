library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is
  generic(filename : string := "");
  port (
    CLK    : in  std_logic;
    SIM_END: out std_logic;
    DATA   : out std_logic_vector(31 downto 0));
end data_maker;

architecture beh of data_maker is

begin  -- beh

  process (CLK)
    file fp : text open read_mode is filename;
    variable ptr : line;
    variable val : std_logic_vector(31 downto 0);
    variable sim_end_i : std_logic := '0';
  begin  -- process
    if CLK'event and CLK = '1' then  -- rising clock edge
      if (not(endfile(fp))) then
        readline(fp, ptr);
        read(ptr, val);     
      else sim_end_i := '1';     
      end if;
      DATA <= val;
      sim_end <= sim_end_i;
    end if;
  end process;

end beh;
