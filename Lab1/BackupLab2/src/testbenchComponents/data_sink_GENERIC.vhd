library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink_GENERIC is
  generic(
    N_bit : integer := 8;
    fileName : string := "" -- P.N. IT HAS TO CONTAIN ALSO THE RELATIVE PATH
  );
  port (
    STARTsink : in std_logic;
    CLK      : in std_logic;
    DATA     : in std_logic_vector(N_bit - 1 downto 0)
	);
end data_sink_GENERIC;

architecture beh of data_sink_GENERIC is

begin  -- beh

  process (CLK)
    file res_fp : text open WRITE_MODE is fileName;
    variable line_out : line; 	
  begin  -- process
    if (CLK'event and CLK = '1' and STARTsink = '1') then  -- rising clock edge
        write(line_out, DATA);
        writeline(res_fp, line_out);
    end if;
  end process;

end beh;
