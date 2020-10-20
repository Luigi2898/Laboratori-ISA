library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_buffer_3x11 is
generic (W: positive:=3;
		 B: positive:=11;
		 log2W : positive:=2);
port(
	clk : in std_logic;
	data_in : in signed (11-1 downto 0);
	buff_on : in std_logic;
	load : in std_logic;
	flush : in std_logic;
	flush_cnt : in std_logic;
	rst_n : in std_logic;
	data_out0 : out signed (11-1 downto 0);
	data_out1 : out signed (11-1 downto 0);
	data_out2 : out signed (11-1 downto 0);
	buff_full : out std_logic
	);
end entity data_buffer_3x11;

architecture beh of data_buffer_3x11 is
---------------------------------------------
component reg is
	port(reg_in : in signed(10 downto 0);
		 reg_out : out signed(10 downto 0);
		 clk, rst_n, load : in std_logic
	);
end component;

component N_counter is
generic(N : integer:= 12; MODULE : integer:= 2604);
	port(clk : in std_logic;
		 en  : in std_logic;
		 rst_n : in std_logic;
		 rst0_rst1n : in std_logic;
		 cnt_end : out std_logic;
		 cnt_out : buffer unsigned(N-1 downto 0)		
	);
end component;
--------------------------------------------------
type buffer_type is array (W+1 downto 0) of signed (B-1 downto 0);
signal buffer_content : buffer_type;
signal cnt_out : unsigned (log2W-1 downto 0);
signal rst_signal,rst_n_internal,rst_n_cnt : std_logic;
signal gnd : std_logic := '0';
signal vdd : std_logic := '1';
-------------------------------------------------------------------------------------
begin 
-------------------------------------------------------------------------------------
buff_reg_gen : for i in 0 to W+1 generate
	buff_reg_gen1 : if (i = 0) generate 
		buff_reg : reg port map (reg_in=>data_in,reg_out=>buffer_content(i),clk=>clk,
								rst_n=>rst_n,load=>buff_on);
	end generate;
	buff_reg_gen2 : if (i > 0)  generate
		buff_reg : reg port map (reg_in=>buffer_content(i-1),reg_out=>buffer_content(i),clk=>clk,
								rst_n=>rst_n_internal,load=>load);
	end generate;
end generate buff_reg_gen;
-------------------------------------------------------------------------------------
cnt : N_counter generic map (N=>2,MODULE=>4) port map (clk=>clk,en=>load,rst_n=>rst_n_cnt,rst0_rst1N=>vdd,cnt_end=>buff_full);
-------------------------------------------------------------------------------------
rst_n_internal <= not(not(rst_n) or flush);
rst_n_cnt <= not(not(rst_n) or flush) or flush_cnt;
data_out0 <= buffer_content(2);
data_out1 <= buffer_content(3);
data_out2 <= buffer_content(4);
-------------------------------------------------------------------------------------
end architecture beh;



				
		
	
	
	
	
	
	
	