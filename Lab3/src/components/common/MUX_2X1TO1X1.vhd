LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_2X1TO1X1 IS
  PORT (x1 : IN  STD_LOGIC;
        x2 : IN  STD_LOGIC;
        s  : IN  STD_LOGIC;
        o  : OUT STD_LOGIC);
END ENTITY MUX_2X1TO1X1;

ARCHITECTURE Behavior OF MUX_2X1TO1X1 IS
BEGIN
  o <= (NOT(s) AND x1) OR (s AND x2);
END ARCHITECTURE Behavior;
