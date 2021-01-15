library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DELAY_CHAIN is
  generic (Nbits : integer := 32;
           DelayUnits : integer := 2);
  port (
    CLK : in std_logic;
    RSTN : in std_logic;
    EN : in std_logic;
    DIN : in std_logic_vector (Nbits-1 downto 0);
    DOUT : buffer std_logic_vector (Nbits-1 downto 0)
  );
end entity DELAY_CHAIN;

architecture beh of DELAY_CHAIN is

  component REG is
    generic(N : integer := 11);
    port(
    REG_IN           : in  std_logic_vector(N-1 downto 0);
    CLK, RST_N, LOAD : in  std_logic;
    REG_OUT          : out std_logic_vector(N-1 downto 0)
    );
  end component;

  type content_type is array (DelayUnits downto 0) of std_logic_vector (Nbits-1 downto 0);
  signal CONTENT : content_type;
  
begin

  CONTENT(0) <= DIN;
  DOUT <= CONTENT(DelayUnits);

  delay_regs_generation : for i in 1 to DelayUnits generate

    DELAY_ELEMENT : REG generic map (Nbits)
                    port map (CONTENT(i-1),CLK,RSTN,EN,CONTENT(i));
    
  end generate delay_regs_generation ;
  
end architecture beh;