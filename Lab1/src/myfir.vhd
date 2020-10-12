library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity myfir is
	port(CLK: in std_logic;
		 RST_N: in std_logic;
		 DIN: in signed(10 downto 0);
		 VIN: in std_logic;
		 H0: in signed(10 downto 0);
		 H1: in signed(10 downto 0);
		 H2: in signed(10 downto 0);
		 H3: in signed(10 downto 0);
		 H4: in signed(10 downto 0);
		 H5: in signed(10 downto 0);
		 H6: in signed(10 downto 0);
		 H7: in signed(10 downto 0);
		 H8: in signed(10 downto 0);
		 DOUT: out signed(10 downto 0);
		 VOUT: out std_logic
		);
end entity;

architecture beh of myfir is

component REG is
	port(REG_IN : in signed(10 downto 0);
		 REG_OUT : out signed(10 downto 0);
		 CLK, RST_N, LOAD : in std_logic
	);
end	component;

component ff is
	port(ff_in : in std_logic;
		 ff_out : out std_logic;
		 clk, rst, load : in std_logic	
	);
end component;

type vector is array (8 downto 0) of signed(10 downto 0);
type vector2 is array (7 downto 0) of signed(10 downto 0);
signal coeff : vector;
signal reg_out : vector2;
signal ff_out: signed(7 downto 0);  
signal load : std_logic := '1';
signal reg_out0 : signed(10 downto 0);
signal var : signed(21 downto 0);

begin

coeff(0) <=  H0;
coeff(1) <=  H1;
coeff(2) <=  H2;
coeff(3) <=  H3;
coeff(4) <=  H4;
coeff(5) <=  H5;
coeff(6) <=  H6;
coeff(7) <=  H7;
coeff(8) <=  H8;

reg0 : reg port map(DIN, reg_out0, clk, rst_N, load);


z_gen : for i in 0 to 7 generate 
	    reg1 : if(i = 0) generate 
		        regz1 :reg port map(reg_out0, reg_out(i), clk, rst_N, VIN);
				end generate;
		reg2 : if(i > 0) generate		
	           regz2: reg port map(reg_out(i-1), reg_out(i), clk, rst_n, VIN);
			   end generate;			   
        end generate z_gen;
		
var <= (coeff(0) * reg_out0 + coeff(1)*reg_out(0) + coeff(2)*reg_out(1) + coeff(3)*reg_out(2) + coeff(4)*reg_out(3) + coeff(5)*reg_out(4) + coeff(6)*reg_out(5) + coeff(7)*reg_out(6) + coeff(8)*reg_out(7));

ff_gen : for i in 0 to 7 generate 
	    ff1 : if(i = 0) generate 
		        ffg1 :ff port map(VIN, ff_out(i), clk, rst_n, VIN);
				end generate;
		ff2 : if(i > 0) generate		
	           ffg2: ff port map(ff_out(i-1), ff_out(i), clk, rst_n, VIN);
			   end generate;
        end generate ff_gen;

VOUT <= ff_out(7);
		
reg3: reg port map(var(21 downto 11), DOUT, CLK, RST_N, ff_out(7));		

end architecture;