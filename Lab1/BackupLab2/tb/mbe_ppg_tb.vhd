library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.array_std.all;

entity mbe_ppg_tb is
end entity;

architecture sim of mbe_ppg_tb is

COMPONENT mbe_ppg is
    GENERIC(N : INTEGER := 32; N_PP : INTEGER := 17);
	PORT(A : in std_logic_vector(N-1 downto 0);
		 B : in std_logic_vector(N-1 downto 0);
		 S : out std_logic_vector(N/2 downto 0);
		 PP: out PP_array	
	);
END COMPONENT;

COMPONENT signExtender is
  generic(N : integer := 32);
  port (
    PP      : in  PP_array;
    PP_sign : in  std_logic_vector (N / 2 downto 0);
    PP_ext  : out PP_array_ext
  ) ;
END COMPONENT signExtender ; 
 
component data_sink is
	generic(N_bit : integer := 8;
	fileName : string := "");
	port (
	  CLK      : in std_logic;
	  DATA     : in std_logic_vector(N_bit - 1 downto 0)
	  );
end component data_sink;

signal a_1 : std_logic_vector(31 downto 0);
signal b_1 : std_logic_vector(31 downto 0);
signal s   : std_logic_vector(16 downto 0);
signal PP_tb : PP_array;
signal PP_ext_tb : PP_array_ext;
signal PP : std_logic_vector(32 downto 0) ;
signal PP_ext : std_logic_vector(36 downto 0) ;
signal clk1, clk2 : std_logic;


BEGIN

data_proc : process
begin
a_1 <= "00000000000000000000000001111100";
b_1 <= "00001100010100100100001101111101";
wait for 40 ns;
a_1 <= "00000000000000000000000001111100";
b_1 <= "01111010100001000111001001010001";
wait for 1 sec;
end process;


ppg_UUT1 : mbe_ppg generic map (N => 32, N_PP => 17) port map(a_1, b_1, s, PP_tb);

DS_1 : data_sink generic map(33, "../file/pp.txt") port map(clk1, PP);

PP_sink_clock : process
begin
	clk1 <= '0';
	wait for 500 ps;
	clk1 <= '1';
	wait for 500 ps;
end process ; -- PP_sink_clock

PP_sink_feed : process
begin
	wait for 100 ps;
	FEED : for i in 16 downto 0 loop
		PP <= PP_tb(i);
		wait for 500 ps;
	end loop ; -- FEED
end process ; -- PP_sink_feed

ext_UUT2 : signExtender generic map (N => 32) port map(PP_tb, s, PP_ext_tb);

DS_2 : data_sink generic map(37, "../file/pp_ext.txt") port map(clk2, PP_ext);

PP_sink_clock2 : process
begin
	clk2 <= '0';
	wait for 500 ps;
	clk2 <= '1';
	wait for 500 ps;
end process ; -- PP_sink_clock2

PP_sink_feed2 : process
begin
	wait for 100 ps;
	FEED2 : for i in 16 downto 0 loop
		PP_ext <= PP_ext_tb(i);
		wait for 500 ps;
	end loop ; -- FEED2
end process ; -- PP_sink_feed2

end architecture sim;
