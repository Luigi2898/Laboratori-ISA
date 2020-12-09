library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_signed.all;

  entity CSA is
    generic (N : integer := 32);
      port (
          IN0 : in std_logic_vector (N-1 downto 0);
          IN1 : in std_logic_vector (N-1 downto 0);
          IN2 : in std_logic_vector (N-1 downto 0); 
          S : out std_logic_vector (N-1 downto 0);
          C : out std_logic_vector (N-1 downto 0)
      );
  end entity CSA;

  architecture structural of CSA is

  component FA
    port(
		  A, B, Cin : in std_logic;
		  S, Co : out std_logic
	  );	
  end component FA;

  begin

  compressor_generate : for i in 0 to N-1 generate
    compr : FA port map (IN0(i),IN1(i),IN2(i),S(i),C(i));
  end generate;
       
  end architecture structural;
