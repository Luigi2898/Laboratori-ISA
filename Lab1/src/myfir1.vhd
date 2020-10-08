library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity my_fir is
  port (
        CLK : in std_logic;
	    RST_n : in std_logic;
	    DIN : in signed(10 downto 0);
        VIN : in std_logic;
        H0      : in std_logic_vector(10 downto 0);
        H1      : in std_logic_vector(10 downto 0);
        H2      : in std_logic_vector(10 downto 0);
        H3      : in std_logic_vector(10 downto 0);
        DOUT : out std_logic;
        VOUT : out signed(10 downto 0)
  ) ;
end my_fir ; 

architecture beh of my_fir is

begin
    DOUT <= '1010101010';
    VOUT <= '1';
end architecture ;