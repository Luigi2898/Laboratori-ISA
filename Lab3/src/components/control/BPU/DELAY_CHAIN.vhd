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
    DOUT : out std_logic_vector (Nbits-1 downto 0)
  );
end entity DELAY_CHAIN;

architecture beh of DELAY_CHAIN is

  type content_type is array (DelayUnits-1 downto 0) of std_logic_vector (Nbits-1 downto 0);
  
begin

  delay_chain_process : process (CLK,RSTN)

  variable content_var : content_type;

  begin

    if (RSTN = '0') then
      content_var := (others => (others => '0'));
      

    elsif (CLK'event and CLK = '1') then

      if (EN = '1') then
        DOUT <= content_var(DelayUnits-1);

        for i in DelayUnits-1 to 1 loop
          content_var(i) := content_var(i-1);
        end loop;

        content_var(0) := DIN;
      
      else 
        --content_var := content_var;
      end if;

    else
      --content_var := content_var;
    end if;

    DOUT <= content_var(DelayUnits-1);


  end process;
  
end architecture beh;