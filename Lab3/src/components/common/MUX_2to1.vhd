library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_2to1 is
	generic(N: integer := 1);								
	Port(
		IN0: in	std_logic_vector(N-1 downto 0);		
		IN1: in	std_logic_vector(N-1 downto 0);		
		SEL: in	std_logic;							
		Y:	 out std_logic_vector(N-1 downto 0));	
end entity MUX_2to1;

architecture beh of MUX_2to1 is
begin

	with SEL select Y<=
		IN0 when '0',
		IN1 when others;
	
end architecture beh;
