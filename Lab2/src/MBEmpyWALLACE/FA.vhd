LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY FA IS
PORT(
		A, B, Cin : IN STD_LOGIC;
		S, Co : OUT STD_LOGIC
	 );	
END FA;

ARCHITECTURE structural OF FA IS

SIGNAL OUT_FIRST_1, OUT_FIRST_2, OUT_SECOND : STD_LOGIC;

	COMPONENT HA 
	PORT(
		A, B : IN STD_LOGIC;
		S, Co : OUT STD_LOGIC
	 );
	END COMPONENT;
	
BEGIN

HALF1 : HA PORT MAP (A => A, B => B, Co => OUT_FIRST_2, S => OUT_FIRST_1);
HALF2 : HA PORT MAP (A => Cin, B => OUT_FIRST_1, Co => OUT_SECOND, S => S);
Co <= OUT_SECOND OR OUT_FIRST_2;

END structural;
	