library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity SAT_CNT is
  generic ( Nb : integer := 2;
            Module : integer := 4);
  port (
    CLK : in std_logic;
    RSTN : in std_logic;
    EN : in std_logic;
    CNT_UP_DOWNN : in std_logic;
    CNT_OUT : out unsigned (Nb-1 downto 0)
  );
end entity SAT_CNT;

architecture beh of SAT_CNT is
  
begin
  
  counting_process: process(CLK, RSTN)
  variable cnt_var : unsigned (Nb-1 downto 0) := to_unsigned(0,Nb);
  begin
    if RSTN = '0' then
      cnt_var := (others => '0');
      
    elsif (CLK'event and CLK = '1') then
      if EN = '1' then
        if (CNT_UP_DOWNN = '1') then -- COUNT UP
          if (cnt_var = to_unsigned(Module-1,Nb)) then
            cnt_var := cnt_var;
          else
            cnt_var := cnt_var + to_unsigned(1,Nb);
          end if;

        elsif (CNT_UP_DOWNN = '0') then -- COUNT DOWN
          if (cnt_var = to_unsigned(0,Nb)) then
            cnt_var := cnt_var;
          else
            cnt_var := cnt_var - to_unsigned(1,Nb);
          end if;
        end if;

      else
        cnt_var := cnt_var;
      end if;
    end if;

    CNT_OUT <= cnt_var;
  end process counting_process;
  
end architecture beh;