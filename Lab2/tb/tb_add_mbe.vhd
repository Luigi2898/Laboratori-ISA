library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_textio.all;
use work.array_std.all;
library std;
use std.textio.all;

entity tb_add_mbe is
end entity;

architecture sim of tb_add_mbe is

component MBE_PPG is
        generic(N : integer := 32; N_pp : integer := 17);
        port (
            A : in std_logic_vector(n-1 downto 0);
            B : in std_logic_vector(n-1 downto 0);
            S : out std_logic_vector(n/2 downto 0);
            PP: out pp_array	
        );
end component;
	
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

type pp_out_ext is array (16 downto 0) of signed(63 downto 0);
type pp_out_sign is array (16 downto 0) of signed(32 downto 0);
signal d_in : std_logic_vector(31 downto 0);
signal out_mpy, SUM, sum_beh : std_logic_vector(63 downto 0);
signal clk1, rst : std_logic;
signal sign_out : std_logic_vector (16 downto 0);
signal pp_out : pp_array;


BEGIN

CG : clk_gen port map(clk1, rst);

DM : data_maker port map(clk1, d_in);

PPG : MBE_PPG port map (d_in,d_in,sign_out,pp_out);

UUT1 : MBE_mult_uns port map(d_in, d_in, out_mpy);

pp2scomp: process(pp_out, sign_out)
          variable pp_out_2scomp : pp_out_sign;
          variable pp_out_2scomp_ext : pp_out_ext;
		  variable add_out : pp_out_ext;
		  begin
		  
		  for i in 0 to 16 loop
		  if(sign_out(i) = '1') then
			pp_out_2scomp(i) := signed(pp_out(i)) + 1;
		  else
		    pp_out_2scomp(i) := signed(pp_out(i));	
		  end if;
		  pp_out_2scomp_ext(i)(63 downto 33) := (others => pp_out_2scomp(i)(32));
          pp_out_2scomp_ext(i)(32 downto 0) := pp_out_2scomp(i)(32 downto 0);
		  end loop;
		  
		  add_out(0) := pp_out_2scomp_ext(0);
		  for i in 1 to 16 loop
		  add_out(i) := add_out(i-1) + pp_out_2scomp_ext(i);
		  end loop;	  
		  sum_beh <= std_logic_vector(add_out(16));
		  end process;
		  
		  
process (clk1)
    file res_mbe : text open WRITE_MODE is "../file/add_tb_dadda.hex";
	file res_beh : text open WRITE_MODE is "../file/add_tb_beh.hex";
    variable line_out1 : line;
    variable line_out2 : line; 	
  begin  -- process
    if (clk1'event and clk1 = '1') then  -- rising clock edge
        hwrite(line_out1, out_mpy);
		hwrite(line_out2, sum_beh);
        writeline(res_mbe, line_out1);
		writeline(res_beh, line_out2);
    end if;
  end process;



end architecture sim;
