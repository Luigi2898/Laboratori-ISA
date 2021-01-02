library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

entity HDU is
    port (
        RS1_ID_IN   : in  std_logic_vector(4 downto 0); -- IF/ID.RegisterRs1
		RS2_ID_IN   : in  std_logic_vector(4 downto 0); -- IF/ID.RegisterRs2
        RS1_EXE_IN  : in  std_logic_vector(4 downto 0); -- ID/EX.RegisterRs1
		RS2_EXE_IN  : in  std_logic_vector(4 downto 0); -- ID/EX.RegisterRs2
		RD_EX_IN    : in  std_logic_vector(4 downto 0); -- ID/EXE.RegisterRd
        RD_MEM_IN   : in  std_logic_vector(4 downto 0); -- EXE/MEM.RegisterRd
        RD_WB_IN    : in  std_logic_vector(4 downto 0); -- MEM/WB.RegisterRd
        LOAD_EXE_IN : in  std_logic; --ID/EX.MemRead
        REG_WR_WB   : in  std_logic; --MEM/WB.RegWrite 
        REG_WR_MEM  : in  std_logic; --EX/MEM.RegWrite
        STALL       : out std_logic;
        FORWARD     : out std_logic_vector(3 downto 0)     
    );
end entity  HDU;

architecture beh of  HDU is

signal MEM_HAZARD_RS1: std_logic;
signal MEM_HAZARD_RS2: std_logic;
signal WB_HAZARD_RS1: std_logic;
signal WB_HAZARD_RS2: std_logic;


begin
    
MEM_HAZARD_RS1 <= REG_WR_MEM AND AND_REDUCE(RS1_EXE_IN XNOR RD_MEM_IN) AND OR_REDUCE(RD_MEM_IN); -- RS1 == RD of EX/MEM stage AND RD != x0 

MEM_HAZARD_RS2 <= REG_WR_MEM AND AND_REDUCE(RS2_EXE_IN XNOR RD_MEM_IN) AND OR_REDUCE(RD_MEM_IN); -- RS2 == RD of EX/MEM stage AND RD != x0 

WB_HAZARD_RS1 <= REG_WR_WB AND AND_REDUCE(RS1_EXE_IN XNOR RD_WB_IN) AND OR_REDUCE(RD_WB_IN)
                 AND NOT(MEM_HAZARD_RS1); -- RS1 == RD of MEM/WB stage AND RD != x0 

WB_HAZARD_RS2 <= REG_WR_WB AND AND_REDUCE(RS2_EXE_IN XNOR RD_WB_IN) AND OR_REDUCE(RD_WB_IN)
                 AND NOT(MEM_HAZARD_RS2); -- RS2 == RD of MEM/WB stage AND RD != x0   

FORWARD <=  WB_HAZARD_RS2 & WB_HAZARD_RS1 & MEM_HAZARD_RS2 &  MEM_HAZARD_RS1;                  

STALL <= (AND_REDUCE(RS1_ID_IN XNOR RD_EX_IN) OR AND_REDUCE(RS2_ID_IN XNOR RD_EX_IN)) AND LOAD_EXE_IN;

--with FORWARD select FORWARD_A <= "01" when "0001",
--								   "01" when "1001",
--                                 "10" when "0100",
--                                 "10" when "0110",
--                                 "00" when others;

--with FORWARD select FORWARD_B <= "01" when "0010",
--                                 "10" when "1000",
--                                 "10" when "1001",
--                                 "01" when "0110",
--                                 "00" when others;                                

end architecture beh;
