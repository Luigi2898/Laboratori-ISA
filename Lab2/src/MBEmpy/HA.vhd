LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY HA IS
PORT(
		A, B : IN STD_LOGIC;
		S, Co : OUT STD_LOGIC
	 );
END HA;

ARCHITECTURE struct OF HA IS
BEGIN
S <= A XOR B;
Co <= A AND B;
END struct;