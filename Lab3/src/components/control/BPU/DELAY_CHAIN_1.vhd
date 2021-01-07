library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DELAY_CHAIN_1 is
  generic (DelayUnits : integer := 1);
  port (
    CLK : in std_logic;
    RSTN : in std_logic;
    EN : in std_logic;
    DIN : in std_logic;
    DOUT : out std_logic
  );
end entity DELAY_CHAIN_1;

architecture beh of DELAY_CHAIN_1 is

  component FF is
    port (
      FF_IN          : in STD_LOGIC;
      FF_OUT         : out STD_LOGIC;
      CLK, RST, LOAD : in STD_LOGIC
    );
  end component;

  signal CONTENT : std_logic_vector (DelayUnits downto 0);
  
begin

  CONTENT(0) <= DIN;
  DOUT <= CONTENT(DelayUnits);

  delay_regs_generation : for i in 1 to DelayUnits generate

    DELAY_ELEMENT : FF port map (CONTENT(i-1),CONTENT(i),CLK,RSTN,EN);
    
  end generate delay_regs_generation ;
  
end architecture beh;