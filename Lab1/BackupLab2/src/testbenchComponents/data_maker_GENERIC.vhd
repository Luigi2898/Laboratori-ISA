library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker_GENERIC is
  generic (
    N_bit : integer := 8;
    fileName : string := "" -- P.N. IT HAS TO CONTAIN ALSO THE RELATIVE PATH
  );
  port (
    STARTstimuli : in std_logic;
    ENDEDstimuli : out std_logic;
    CLK  : in  std_logic;
    DATA : out std_logic_vector(31 downto 0));
end data_maker_GENERIC;

architecture beh of data_maker_GENERIC is

begin  -- beh

  process (CLK,STARTstimuli)
    file fp : text open read_mode is fileName;
    variable ptr : line;
    variable val : std_logic_vector(31 downto 0);
  begin  -- process
  ENDEDstimuli <= '0';
    if (CLK'event and CLK = '1' and STARTstimuli = '1') then  -- rising clock edge
      if (not(endfile(fp))) then
        readline(fp, ptr);
        hread(ptr, val);        
      end if;
      DATA <= val;
    else
      ENDEDstimuli <= '1';
    end if;
  end process;

end beh;
