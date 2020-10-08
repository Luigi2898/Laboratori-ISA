library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity myfir1 is
  port (
        CLK : in std_logic;
	    RST_n : in std_logic;
	    DIN : in signed(15 downto 0);
        VIN : in std_logic;
        H0      : in std_logic_vector(15 downto 0);
        H1      : in std_logic_vector(15 downto 0);
        H2      : in std_logic_vector(15 downto 0);
        H3      : in std_logic_vector(15 downto 0);
        DOUT : out std_logic;
        VOUT : out signed(15 downto 0)
  ) ;
end myfir1 ; 

architecture beh of myfir1 is

begin
    DOUT <= '1';
    VOUT <= "1010101010101010";
end architecture ;
