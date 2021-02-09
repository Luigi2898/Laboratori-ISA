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
        FORWARD_A   : out std_logic_vector(1 downto 0);
        FORWARD_B   : out std_logic_vector(1 downto 0)     
    );
end entity  HDU;

architecture beh of  HDU is

signal EX_HAZARD_RS1: std_logic;
signal EX_HAZARD_RS2: std_logic;    
signal MEM_HAZARD_RS1: std_logic;
signal MEM_HAZARD_RS2: std_logic;
signal WB_HAZARD_RS1: std_logic;
signal WB_HAZARD_RS2: std_logic;
signal IS_JAL :std_logic;
signal IS_UIMM :std_logic;
signal IS_BEQ :std_logic;

constant JAL  : std_logic_vector(2 downto 0) := "100";
constant UIMM : std_logic_vector(2 downto 0) := "011";
constant BEQ  : std_logic_vector(2 downto 0) := "010";


begin

EX_HAZARD_RS1 <= REG_WR_EX AND AND_REDUCE(RS1_ID_IN XNOR RD_EX_IN) AND OR_REDUCE(RD_EX_IN); -- RS1 == RD of ID/EX stage AND RD != x0 

EX_HAZARD_RS2 <= REG_WR_EX AND AND_REDUCE(RS2_ID_IN XNOR RD_EX_IN) AND OR_REDUCE(RD_EX_IN); -- RS2 == RD of ID/EX stage AND RD != x0    
    
MEM_HAZARD_RS1 <= REG_WR_MEM AND AND_REDUCE(RS1_ID_IN XNOR RD_MEM_IN) AND OR_REDUCE(RD_MEM_IN); -- RS1 == RD of EX/MEM stage AND RD != x0 

MEM_HAZARD_RS2 <= REG_WR_MEM AND AND_REDUCE(RS2_ID_IN XNOR RD_MEM_IN) AND OR_REDUCE(RD_MEM_IN); -- RS2 == RD of EX/MEM stage AND RD != x0 

WB_HAZARD_RS1 <= REG_WR_WB AND AND_REDUCE(RS1_ID_IN XNOR RD_WB_IN) AND OR_REDUCE(RD_WB_IN)
                 AND NOT(MEM_HAZARD_RS1); -- RS1 == RD of MEM/WB stage AND RD != x0 

WB_HAZARD_RS2 <= REG_WR_WB AND AND_REDUCE(RS2_ID_IN XNOR RD_WB_IN) AND OR_REDUCE(RD_WB_IN)
                 AND NOT(MEM_HAZARD_RS2); -- RS2 == RD of MEM/WB stage AND RD != x0   

imm_code_process: process(IMM_COD)
variable jal_var : std_logic := '0';
variable uimm_var : std_logic := '0';
variable beq_var : std_logic := '0';
begin
if(IMM_COD /= "---") then
    jal_var := AND_REDUCE(IMM_COD XOR JAL);
    uimm_var := AND_REDUCE(IMM_COD XOR UIMM);
    beq_var := AND_REDUCE(IMM_COD XOR BEQ);
    else NULL;
end if;                  
IS_JAL <= jal_var;
IS_UIMM <= uimm_var;
IS_BEQ <= beq_var;
end process;                                  
                     

--a stall occurs whenever INSTR(ID/EX) is a load, but INSTR(IF/ID) is not a jump or an upper-imm
STALL <= ((AND_REDUCE(RS1_ID_IN XNOR RD_EX_IN) OR AND_REDUCE(RS2_ID_IN XNOR RD_EX_IN)) AND LOAD_EXE_IN 
         AND NOT(IS_JAL) AND NOT(IS_UIMM)) OR ((AND_REDUCE(RS1_ID_IN XNOR RD_EX_IN) OR AND_REDUCE(RS2_ID_IN XNOR RD_EX_IN)) AND LOAD_EXE_IN AND IS_BEQ);

forward_a_process : process(EX_HAZARD_RS1, MEM_HAZARD_RS1, WB_HAZARD_RS1)
begin
if(EX_HAZARD_RS1 = '1') then
    FORWARD_A <= "01";
elsif(MEM_HAZARD_RS1 = '1') then   
    FORWARD_A <= "10";
elsif(WB_HAZARD_RS1 = '1') then   
    FORWARD_A <= "11";
else FORWARD_A <= "00";
end if;
end process; --forward_a_process

forward_b_process : process(EX_HAZARD_RS2, MEM_HAZARD_RS2, WB_HAZARD_RS2)
begin
if(EX_HAZARD_RS2 = '1') then
    FORWARD_B <= "01";
elsif(MEM_HAZARD_RS2 = '1') then   
    FORWARD_B <= "10";
elsif(WB_HAZARD_RS2 = '1') then   
    FORWARD_B <= "11";
else FORWARD_B <= "00";
end if;
end process; --forward_b_process

end architecture beh;
