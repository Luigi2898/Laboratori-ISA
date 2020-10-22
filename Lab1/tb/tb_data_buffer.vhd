library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_data_buffer is
end entity;

architecture sim of tb_data_buffer is

component data_buffer_3x11 is
generic (W: positive:=3;
		 B: positive:=11;
		 log2W : positive:=2);
port(
	clk : in std_logic;
	data_in : in signed (11-1 downto 0);
	buff_on : in std_logic;
	load : in std_logic;
	flush : in std_logic;
	rst_n : in std_logic;
	data_out0 : out signed (11-1 downto 0);
	data_out1 : out signed (11-1 downto 0);
	data_out2 : out signed (11-1 downto 0);
	buff_full : out std_logic
	);
end component data_buffer_3x11;

signal clk,buff_on,load,flush,rst_n,buff_full : std_logic;
signal data_ext,data_out0,data_out1,data_out2 : signed (10 downto 0); 
begin

clk_process : process
begin
clk <= '0';
wait for 10 ns;
clk <= '1';
wait for 10 ns;
end process;

data_process : process (clk)
variable tmp : integer := 0;
begin
if clk'event and clk = '1' then
	tmp := tmp + 1;
	end if;
data_ext <= to_signed(tmp,11);
end process;

buff_on_process : process
begin
buff_on <= '0';
wait for 10 ns;
buff_on <= '1';
wait for 80 ns;
buff_on <= '1';
wait for 80 sec;
end process;

rst_process : process
begin
rst_n <= '1';
wait for 10 ns;
rst_n <= '0';
wait for 10 ns;
rst_n <= '1';
wait for 1 sec;
end process;

--flush_process : process 
--begin
flush <= '0';
--wait for 200 ns;
--flush <= '1';
--wait for 40 ns;
--flush <= '0';
--end process;

load_process : process 
begin
load <= '0';
wait for 40 ns;
load <= '1';
wait for 100 ns;
load <= '0';
wait for 100 ns;
load <= '1';
wait for 1 sec;
end process;


DUT : data_buffer_3x11 port map (clk,data_ext,buff_on,load,flush,rst_n,data_out0,data_out1,data_out2,buff_full);

end architecture sim;















