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
COMPONENT signExtender ; 
 
signal a_1 : std_logic_vector(N-1 downto 0);
signal b_1 : std_logic_vector(N-1 downto 0);
signal s   : std_logic_vector(N/2 downto 0);
signal PP_tb : PP_array;
signal PP_ext_tb : PP_array_ext;

BEGIN

data_proc : process
begin
a_1 <= "00000000000000000000000001111100";
b_1 <= "00001100010100100100001101111101";
wait for 10 ns;
a_1 <= "00000000000000000000000001111100";
b_1 <= "01111010100001000111001001010001";
wait for 1 sec;
end process;


ppg_UUT1 : mbe_ppg generic map (N => 32, N_PP => 17) port map(a_1, b_1, s, PP_tb);
ext_UUT2 : signExtender generic map (N => 32) port map(PP_tb, s, PP_ext_tb);


end architecture sim;
