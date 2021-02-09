library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BPU_CU is
  port (
    HIT_MISSN_D2 : in std_logic;
    OPCODE_D2 : in std_logic_vector(6 downto 0);
    WR_EN_CACHE : out std_logic;
    WR_EN_BHT : out std_logic;
    WR_EN_PHT : out std_logic    
  );
end entity BPU_CU;

architecture rtl of BPU_CU is
  
begin

  bpu_status_pla_process : process (HIT_MISSN_D2,OPCODE_D2)
  begin
    if (OPCODE_D2 = "1100011") then
      case HIT_MISSN_D2 is
        when '0' => WR_EN_CACHE <= '1';
                    WR_EN_BHT <= '1';
                    WR_EN_PHT <= '1';
        
        when '1' => WR_EN_CACHE <= '0';
                    WR_EN_BHT <= '1';
                    WR_EN_PHT <= '1';
      
        when others =>  WR_EN_CACHE <= '0';
                        WR_EN_BHT <= '0';
                        WR_EN_PHT <= '0';
      end case;
    else
      WR_EN_CACHE <= '0';
      WR_EN_BHT <= '0';
      WR_EN_PHT <= '0';
    end if;
  end process;
  
end architecture rtl;