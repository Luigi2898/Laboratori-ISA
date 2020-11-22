library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_signed.all;

  entity CSA is
    generic (N : integer := 32)
      port (
          IN0 : in unsigned (N-1 downto 0);
          IN1 : in unsigned (N-1 downto 0);
          IN2 : in unsigned (N-1 downto 0); 
          S : in unsigned (N-1 downto 0);
          C : in unsigned (N-1 downto 0);
      );
  end entity CSA;

  architecture structural of CSA

  

      
  begin
      
      
      
  end architecture structural;