library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.array_std.all;

entity mbe_ppg_tb is
end entity;

architecture sim of mbe_ppg_tb is

COMPONENT mbe_ppg is
    GENERIC(N : INTEGER := 8; N_PP : INTEGER := 5);
	PORT(A : in std_logic_vector(N-1 downto 0);
		 B : in std_logic_vector(N-1 downto 0);
		 S : out std_logic_vector(N/2 downto 0);
		 PP: out PP_array	
	);
END COMPONENT;
 
signal a_1 : std_logic_vector(7 downto 0);
signal b_1 : std_logic_vector(7 downto 0);
signal s   : std_logic_vector(4 downto 0);
signal PP_tb : pp_array;

BEGIN

data_proc : process
begin
a_1 <= "01111100";
b_1 <= "01111101";
wait for 10 ns;
a_1 <= "01111100";
b_1 <= "01001010";
wait for 1 sec;
end process;


uut : mbe_ppg generic map (N => 8, N_PP => 5) port map(a_1, b_1, s, PP_tb);


end architecture sim;
