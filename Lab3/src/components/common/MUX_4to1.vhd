library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_4to1 is
  generic (N : integer := 8);
  port (
    IN0 : in  std_logic_vector(N - 1 downto 0);
    IN1 : in  std_logic_vector(N - 1 downto 0);
    IN2 : in  std_logic_vector(N - 1 downto 0);
    IN3 : in  std_logic_vector(N - 1 downto 0);
    S   : in  std_logic_vector(1 downto 0);  
    O   : out std_logic_vector(N - 1 downto 0)    
  );
end MUX_4to1;

architecture rtl of MUX_4to1 is

  component MUX_2to1 is
    generic(N: integer := 1);								
    port(
      IN0 : in	std_logic_vector(N - 1 downto 0);		
      IN1 : in	std_logic_vector(N - 1 downto 0);		
      SEL : in	std_logic;							
      Y   : out std_logic_vector(N - 1 downto 0)
    );	
  end component;

  signal OUT1 : std_logic_vector(N - 1 downto 0)
  signal OUT2 : std_logic_vector(N - 1 downto 0)

begin

    MUX1 : MUX_2to1 generic map(32)
                    port map(IN0, IN1, S(0), OUT1);
    MUX2 : MUX_2to1 generic map(32)
                    port map(IN2, IN3, S(0), OUT2);
    MUX3 : MUX_2to1 generic map(32)
                    port map(OUT1, OUT2, S(1), O);
    
    

end architecture;