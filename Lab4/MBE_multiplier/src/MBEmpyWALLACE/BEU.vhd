LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY BEU is
	PORT(y      : in std_logic_vector(2 downto 0);
		 s      : out std_logic;
		 decode : out std_logic_vector(2 downto 0)
	    );
END ENTITY;

ARCHITECTURE BEH OF BEU is


signal zero, x_1a, x_2a : std_logic;


BEGIN

zero <= NOT(y(1) XOR y(0)) AND NOT(y(2) XOR y(1));
x_1a <= y(1) XOR y(0);
x_2a <= NOT(y(1) XOR y(0)) AND (y(2) XOR y(1));
s <= y(2);
decode <= x_2a & x_1a & zero;




END ARCHITECTURE;