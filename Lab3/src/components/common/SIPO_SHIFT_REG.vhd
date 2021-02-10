library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SIPO_SHIFT_REG is
  generic (Nbit : integer := 4);
  port(
    CLK: in std_logic;
    RSTN: in std_logic;
    SH_EN: in std_logic;
    DIN: in std_logic;
    DOUT: out std_logic_vector (Nbit-1 downto 0)
    );
end entity SIPO_SHIFT_REG;

architecture beh of SIPO_SHIFT_REG is


begin 
  shift_reg_process : process (CLK,SH_EN,RSTN)

  variable content : std_logic_vector (Nbit-1 downto 0);

  begin
    if RSTN = '0' then
      content := (others => '0');
      
    elsif (CLK'event and CLK = '1') then 
      if SH_EN = '1' then
        for i in Nbit-2 downto 0 loop
          content(i+1):=content(i);
        end loop;
        content(0):=(DIN);
      else
        content := content;
      end if;
    end if;

    DOUT <= (content);

  end process;
  
end beh;	