library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_textio.all;
use work.array_std.all;
library std;
use std.textio.all;

entity tb_mul_mbe is
end entity;

architecture sim of tb_mul_mbe is

COMPONENT MBE_mult_uns is
    port (
        IN_A    : in std_logic_vector (31 downto 0);
        IN_B    : in std_logic_vector (31 downto 0);
        OUT_MPY : out std_logic_vector (63 downto 0)        
    );
   END COMPONENT MBE_mult_uns;

COMPONENT data_maker is
  port (
    CLK  : in  std_logic;
    DATA : out std_logic_vector(31 downto 0));
end COMPONENT data_maker;

COMPONENT clk_gen is
  port (
    CLK     : out std_logic;
    RST_n   : out std_logic);
end COMPONENT clk_gen;

signal d_in : std_logic_vector(31 downto 0);
signal out_mpy, prod : std_logic_vector(63 downto 0);
signal clk1, rst : std_logic;


BEGIN

CG : clk_gen port map(clk1, rst);

DM : data_maker port map(clk1, d_in);

UUT1 : MBE_mult_uns port map(d_in, d_in, out_mpy);

I2combo : PROCESS (d_in)
          VARIABLE dtemp : unsigned(63 DOWNTO 0);
          BEGIN
          dtemp := (unsigned(d_in) * unsigned(d_in));
          prod <= std_logic_vector(dtemp);
		  END PROCESS I2combo;
		  
		  
process (clk1)
    file res_mbe : text open WRITE_MODE is "../prod_tb_mbe.hex";
	file res_beh : text open WRITE_MODE is "../prod_tb_beh.hex";
    variable line_out1 : line;
    variable line_out2 : line; 	
  begin  -- process
    if clk1'event and clk1 = '1' then  -- rising clock edge
        hwrite(line_out1, out_mpy);
		hwrite(line_out2, prod);
        writeline(res_mbe, line_out1);
		writeline(res_beh, line_out2);
    end if;
  end process;



end architecture sim;
