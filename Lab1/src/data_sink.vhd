library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink is
  port (
    CLK   : in std_logic;
    RST_n : in std_logic;
    VOUT   : in std_logic;
    DOUT   : in std_logic_vector(10 downto 0));
end data_sink;

architecture beh of data_sink is

begin  -- beh

  process (CLK, RST_n)
    file res_fp : text open WRITE_MODE is "C:\Users\Davide\Desktop\POLI\Magistrale\V ANNO\ISA\Lab 1\testbench\results.txt";
    variable line_out : line;    
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      null;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if (VOUT = '1') then
        write(line_out, conv_integer(signed(DOUT)));
        writeline(res_fp, line_out);
      end if;
    end if;
  end process;

end beh;
