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
        REG_WR_EX   : in  std_logic; --ID/EX.RegWrite
        IMM_COD     : in  std_logic_vector(2 downto 0);
        STALL       : out std_logic;
        FORWARD     : out std_logic_vector(5 downto 0)     
    );
end entity  HDU;

architecture beh of  HDU is

signal EX_HAZARD_RS1: std_logic;
signal EX_HAZARD_RS2: std_logic;    
signal MEM_HAZARD_RS1: std_logic;
signal MEM_HAZARD_RS2: std_logic;
signal WB_HAZARD_RS1: std_logic;
signal WB_HAZARD_RS2: std_logic;

constant JAL  : std_logic_vector(2 downto 0) := "100";
constant UIMM : std_logic_vector(2 downto 0) := "011";
constant BEQ  : std_logic_vector(2 downto 0) := "010";


begin

EX_HAZARD_RS1 <= REG_WR_EX AND AND_REDUCE(RS1_ID_IN XNOR RD_EX_IN) AND OR_REDUCE(RD_EX_IN); -- RS1 == RD of ID/EX stage AND RD != x0 

EX_HAZARD_RS2 <= REG_WR_EX AND AND_REDUCE(RS2_ID_IN XNOR RD_EX_IN) AND OR_REDUCE(RD_EX_IN); -- RS2 == RD of ID/EX stage AND RD != x0    
    
MEM_HAZARD_RS1 <= REG_WR_MEM AND AND_REDUCE(RS1_EXE_IN XNOR RD_MEM_IN) AND OR_REDUCE(RD_MEM_IN)
                  AND NOT(EX_HAZARD_RS1); -- RS1 == RD of EX/MEM stage AND RD != x0 

MEM_HAZARD_RS2 <= REG_WR_MEM AND AND_REDUCE(RS2_EXE_IN XNOR RD_MEM_IN) AND OR_REDUCE(RD_MEM_IN)
                  AND NOT(EX_HAZARD_RS2); -- RS2 == RD of EX/MEM stage AND RD != x0 

WB_HAZARD_RS1 <= REG_WR_WB AND AND_REDUCE(RS1_EXE_IN XNOR RD_WB_IN) AND OR_REDUCE(RD_WB_IN)
                 AND NOT(MEM_HAZARD_RS1); -- RS1 == RD of MEM/WB stage AND RD != x0 

WB_HAZARD_RS2 <= REG_WR_WB AND AND_REDUCE(RS2_EXE_IN XNOR RD_WB_IN) AND OR_REDUCE(RD_WB_IN)
                 AND NOT(MEM_HAZARD_RS2); -- RS2 == RD of MEM/WB stage AND RD != x0   

FORWARD <=  WB_HAZARD_RS2 & WB_HAZARD_RS1 & MEM_HAZARD_RS2 & MEM_HAZARD_RS1 & EX_HAZARD_RS2 & EX_HAZARD_RS1;                  

--a stall occurs whenever INSTR(ID/EX) is a load, but INSTR(IF/ID) is not a jump or an upper-imm
STALL <= ((AND_REDUCE(RS1_ID_IN XNOR RD_EX_IN) OR AND_REDUCE(RS2_ID_IN XNOR RD_EX_IN)) AND LOAD_EXE_IN 
         AND NOT(AND_REDUCE(IMM_COD XNOR JAL)) AND NOT(AND_REDUCE(IMM_COD XNOR UIMM))) OR
         ((AND_REDUCE(RS1_ID_IN XNOR RD_EX_IN) OR AND_REDUCE(RS2_ID_IN XNOR RD_EX_IN)) AND LOAD_EXE_IN AND AND_REDUCE(IMM_COD XNOR BEQ));

--encoding for forwanding:
--FORWARD_A <= "01" when EX_HAZARD_RS1  = '1',
--             "10" when MEM_HAZARD_RS1 = '1',
--             "11" when WB_HAZARD_RS1  = '1',
--             "00" when others;  
--FORWARD_B <= "01" when EX_HAZARD_RS2  = '1',
--             "10" when MEM_HAZARD_RS2 = '1',
--             "11" when WB_HAZARD_RS2  = '1',
--             "00" when others;                     

end architecture beh;
