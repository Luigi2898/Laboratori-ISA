library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity RISC_V is
  port (
	-- Data memory interfaces
  DATA_IN      : in  std_logic_vector(31 downto 0);
	DATA_ADDR    : out std_logic_vector(31 downto 0);
  DATA_OUT     : out std_logic_vector(31 downto 0);
  WRITE_EN     : out std_logic;
  READ_EN      : out std_logic;
	-- Instruction memory interfaces
	INSTR_ADDR   : out std_logic_vector(31 downto 0);
  INSTR        : in  std_logic_vector(31 downto 0);
  --
  CLK          : in  std_logic;
  EXTERNAL_RSTN : in  std_logic
  );
end RISC_V;

architecture rtl of RISC_V is

  -- Component declarations

  component MUX_2to1 is
    generic(N: integer := 1);								
    Port(
      IN0: in	 std_logic_vector(N-1 downto 0);		
      IN1: in	 std_logic_vector(N-1 downto 0);		
      SEL: in	 std_logic;							
      Y  : out std_logic_vector(N-1 downto 0)
    );	
  end component;

  component REG is
    generic(N : integer := 11);
    port(
    REG_IN           : in  std_logic_vector(N-1 downto 0);
    CLK, RST_N, LOAD : in  std_logic;
    REG_OUT          : out std_logic_vector(N-1 downto 0)
    );
  end component;

  component INCREMENTER is
    generic (STEP : integer := 4);
    port (
      CURRENT_ADDR : in  std_logic_vector(31 downto 0);
      NEXT_ADDR    : out std_logic_vector(31 downto 0)
    );
  end component;

  component PIPE_IF_ID is 
    port(
      CLK               : in  std_logic;
      RSTN              : in  std_logic;
      FLUSH             : in  std_logic;
      STALL             : in  std_logic; 
      INSTR_IF_IN       : in  std_logic_vector(31 downto 0);
      INSTR_PC_ADDR_IN  : in  std_logic_vector(31 downto 0);
      INSTR_IF_OUT      : out std_logic_vector(31 downto 0);
      INSTR_PC_ADDR_OUT : out std_logic_vector(31 downto 0)
    );
  end component;


  component PIPE_EX_MEM is 
    port(
      CLK           : in  std_logic;
      RSTN          : in  std_logic;
      ALU_RES_IN    : in  std_logic_vector(31 downto 0);
      RS2_VAL_IN    : in  std_logic_vector(31 downto 0); --from mux
      OP_WB_MEM_IN  : in  std_logic_vector(3 downto 0); --MEM/WB ctrls (WB_RFEN_OUT & WB_RFMUX_OUT & M_RD_OUT & M_WR_OUT)
      RD_ADDR_IN    : in  std_logic_vector(4 downto 0);
      ------------------------------------------------------------------ out
      ALU_RES_OUT   : out std_logic_vector(31 downto 0);
      RS2_VAL_OUT   : out std_logic_vector(31 downto 0);
      OP_WB_MEM_OUT : out std_logic_vector(3 downto 0);
      RD_ADDR_OUT   : out std_logic_vector(4 downto 0)
    );
  end component PIPE_EX_MEM;


  component PIPE_MEM_WB is 
    port(
      CLK                   : in  std_logic;
      RSTN                  : in  std_logic;
      ALU_RES_IN            : in  std_logic_vector(31 downto 0);
      MEM_RES_IN            : in  std_logic_vector(31 downto 0); 
      OP_WB_IN              : in  std_logic_vector(1 downto 0); --WB ctrls (WB_RFEN_OUT & WB_RFMUX_OUT)
      RD_ADDR_IN            : in  std_logic_vector(4 downto 0);
      ------------------------------------------------------------------ out
      ALU_RES_OUT           : out std_logic_vector(31 downto 0);
      MEM_RES_OUT           : out std_logic_vector(31 downto 0);
      OP_WB_OUT             : out std_logic_vector(1 downto 0);
      RD_ADDR_OUT           : out std_logic_vector(4 downto 0)
    );
  end component PIPE_MEM_WB;


  component REG_FILE is
    generic (Nbit : integer := 32;
             Nrow : integer := 32);
    port (
      CLK      : in  std_logic;
      RSTN     : in  std_logic;
  
      RD1_ADDR : in  std_logic_vector (integer(ceil(log2(real(Nrow))))-1 downto 0);
      RD1_DOUT : out std_logic_vector (Nbit-1 downto 0);
      --RD1_EN   : in std_logic;
  
      RD2_ADDR : in  std_logic_vector (integer(ceil(log2(real(Nrow))))-1 downto 0);
      RD2_DOUT : out std_logic_vector (Nbit-1 downto 0);
      --RD2_EN   : in std_logic;
      
      WR1_ADDR : in  std_logic_vector (integer(ceil(log2(real(Nrow))))-1 downto 0);
      WR1_DIN  : in  std_logic_vector (Nbit-1 downto 0);
      WR1_EN   : in  std_logic
    );
  end component REG_FILE;

  component JMP_ADD is
    port (
      IMM_GEN_IN : in  std_logic_vector(31 downto 0);
      PC_IF_ID   : in  std_logic_vector(31 downto 0);
      JMP_ADDR   : out std_logic_vector(31 downto 0)
    );
  end component;

  component IMM_GEN is
    port(
      IR_IN       : in  std_logic_vector(31 downto 0);
      IMM_GEN_OUT : out std_logic_vector(31 downto 0);
      IMM_EN_IN   : in  std_logic;
      IMM_CODE_IN : in  std_logic_vector(2 downto 0)
    );
  end component;

  component BRANCH_COMP is
    generic(word_size: integer:= 32);	
    port(
      IMM_CODE		: in  std_logic_vector(2 downto 0);			    --condition to take branch
      DATA_IN1		: in  std_logic_vector(word_size-1 downto 0);	--data to test
      DATA_IN2		: in  std_logic_vector(word_size-1 downto 0);	--data to test
      BRANCH_IS_TAKEN	: out std_logic
      );						
  end component;

  component MUX_4to1 is
    generic (N : integer := 8);
    port (
      IN0 : in  std_logic_vector(N - 1 downto 0);
      IN1 : in  std_logic_vector(N - 1 downto 0);
      IN2 : in  std_logic_vector(N - 1 downto 0);
      IN3 : in  std_logic_vector(N - 1 downto 0);
      S   : in  std_logic_vector(1 downto 0);  
      O   : out std_logic_vector(N - 1 downto 0)    
    );
  end component;

  component CU is
    port (
      -- External reset
      RST            : in  std_logic;
      -- From code memory
      OPCODE         : in  std_logic_vector(6 downto 0);
      -- From BPU
      BPU_MISSPRED   : in  std_logic;
      BPU_PREDICTION : in  std_logic;
      -- From HDU
      HDU_STALL      : in  std_logic;
      -- To ALU input MUX
      EX_ALUSRC_OUT  : out std_logic; -- 1 immediate 0 non-immediate
      -- To ALU_CTRL
      EX_ALUCTRL_OUT : out std_logic;
      EX_ALUEN_OUT   : out std_logic;
      -- To memory
      M_RD_OUT       : out std_logic;
      M_WR_OUT       : out std_logic;
      -- To REGISTER FILE
      WB_RFEN_OUT    : out std_logic;
      -- To REGISTER FILE MUX
      WB_RFMUX_OUT   : out std_logic; -- 1 from memory 0 non-from-memory
      -- To immediate generator
      IMM_EN_OUT     : out std_logic;
      IMM_CODE_OUT   : out std_logic_vector(2 downto 0);
      -- Flush the pipe
      PIPE_FLUSH     : out std_logic; -- Send to pc the right address and resets pipe
      -- Stall the pipe
      PIPE_STALL     : out std_logic;
      -- Jump
      JUMP           : out std_logic;
      -- Datapath reset
      DP_RST         : out std_logic;
      -- AUIPC handling
      AUIPC_MUX_OUT  : out std_logic;
      -- LUI handling
      LUI_MUX_OUT    : out std_logic
    );
  end component;

  component HDU is
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
  end component  HDU;

  component BPU is
    port (
      CLK                : in std_logic;
      RSTN               : in std_logic;
      PC                 : in unsigned (31 downto 0);
      PC_D2              : in unsigned (31 downto 0);
      OPCODE_D2          : in std_logic_vector (6 downto 0);
      OUTCOME            : in std_logic;
      TARGET_ADDRESS_IN  : in unsigned (31 downto 0);
      TARGET_ADDRESS_OUT : out unsigned (31 downto 0);
      PREDICTION         : inout std_logic;
      MISPREDICTION      : out std_logic
    );
  end component;

  component PIPE_ID_EX is 
    port(
      CLK                   : in std_logic;
      RSTN                  : in std_logic;
      FLUSH                 : in std_logic;
      STALL                 : in std_logic;
      LUI_IN                : in std_logic;
      RS1_VAL_IN            : in std_logic_vector(31 downto 0);
      RS2_VAL_IN            : in std_logic_vector(31 downto 0);
      IMM_GEN_IN            : in std_logic_vector(31 downto 0);
      RS1_ADDR_IN           : in std_logic_vector(4 downto 0);
      RS2_ADDR_IN           : in std_logic_vector(4 downto 0);
      RD_ADDR_IN            : in std_logic_vector(4 downto 0);
      FUNC3_IN              : in std_logic_vector(2 downto 0);
      WR_RFEN_IN            : in std_logic;
      WR_RFMUX_IN           : in std_logic;
      BRANCH_COMP_IN        : in std_logic;
      JUMP_IN               : in std_logic;
      M_RD_EN_IN            : in std_logic;
      M_WR_IN               : in std_logic;
      EX_ALUSRC_IN          : in std_logic;
      EX_ALUCTRL_IN         : in std_logic;
      EX_ALUEN_IN           : in std_logic;
      ------------------------------------------------------------------ out
      WR_RFEN_OUT           : out std_logic;
      WR_RFMUX_OUT          : out std_logic;
      BRANCH_COMP_OUT       : out std_logic;
      JUMP_OUT              : out std_logic;
      M_RD_EN_OUT           : out std_logic;
      M_WR_OUT              : out std_logic;
      EX_ALUSRC_OUT         : out std_logic;
      EX_ALUCTRL_OUT        : out std_logic;
      EX_ALUEN_OUT          : out std_logic;
      RS1_VAL_OUT           : out std_logic_vector(31 downto 0);
      RS2_VAL_OUT           : out std_logic_vector(31 downto 0);
      IMM_GEN_OUT           : out std_logic_vector(31 downto 0);
      RS1_ADDR_OUT          : out std_logic_vector(4 downto 0);
      RS2_ADDR_OUT          : out std_logic_vector(4 downto 0);
      RD_ADDR_OUT           : out std_logic_vector(4 downto 0);
      FUNC3_OUT             : out std_logic_vector(2 downto 0);
      LUI_OUT               : out std_logic    
    );
  end component PIPE_ID_EX;

  component ALU is
    generic (N : integer := 32);
    port (
      DATA1_IN   : in  std_logic_vector(N - 1 downto 0);
      DATA2_IN   : in  std_logic_vector(N - 1 downto 0);
      OPCODE_IN  : in  std_logic_vector(5 downto 0);
      ZF_OUT     : out std_logic;
      NF_OUT     : out std_logic;
      RESULT_OUT : out std_logic_vector(N - 1 downto 0)
    );
  end component;

  component ALU_CTRL is
    port (
      EN_IN    : in  std_logic;
      CTRL_IN  : in  std_logic;
      FUNC_IN  : in  std_logic_vector(2 downto 0);
      AUIPC_MUX_OUT  : in std_logic;
      CODE_OUT : out std_logic_vector(5 downto 0)
    );
  end component;

  -- Global signals  
  signal Vdd, GND : std_logic;
  signal I_RST    : std_logic;
  -- Fetch stage signals
  signal PC_SOURCE    : std_logic_vector(31 downto 0);
  signal CURRENT_PC   : std_logic_vector(31 downto 0);
  signal DIFF_PC      : std_logic_vector(31 downto 0);
  signal DIFF_PC_U    : unsigned(31 downto 0);
  signal NEXT_PC      : std_logic_vector(31 downto 0);
  signal SELECTED_SRC : std_logic_vector(31 downto 0);
  signal PC_DIR       : std_logic;
  -- Decode stage signals
  signal PC_ID               : std_logic_vector(31 downto 0);
  signal INSTR_ID            : std_logic_vector(31 downto 0);
  signal RF_OUT1             : std_logic_vector(31 downto 0);
  signal RF_OUT2             : std_logic_vector(31 downto 0);
  signal IMM_GEN_OUT         : std_logic_vector(31 downto 0);
  signal JMP_ADDR            : std_logic_vector(31 downto 0);
  signal FORWARD_A           : std_logic_vector(1 downto 0);
  signal FORWARD_B           : std_logic_vector(1 downto 0);
  signal RS1_VAL_OUT_IDEX    : std_logic_vector(31 downto 0);
  signal RS2_VAL_OUT_IDEX    : std_logic_vector(31 downto 0);
  signal IMM_GEN_OUT_IDEX    : std_logic_vector(31 downto 0);
  signal BC_IN1              : std_logic_vector(31 downto 0);
  signal BC_IN2              : std_logic_vector(31 downto 0);
  signal RF_WRDIN_WB         : std_logic_vector(31 downto 0);
  signal OUT_AUIPC           : std_logic_vector(31 downto 0);
  signal RS1_ADDR_OUT_IDEX   : std_logic_vector(4 downto 0);
  signal RS2_ADDR_OUT_IDEX   : std_logic_vector(4 downto 0);
  signal RD_ADDR_OUT_IDEX    : std_logic_vector(4 downto 0);
  signal FUNC3_OUT_IDEX      : std_logic_vector(2 downto 0);
  signal BRANCH_OUT_IDEX     : std_logic;
  signal JUMP_OUT_IDEX       : std_logic;
  signal WR_RFEN_OUT_IDEX    : std_logic;
  signal WR_RFMUX_OUT_IDEX   : std_logic;
  signal M_RD_EN_OUT_IDEX    : std_logic;
  signal M_WR_OUT_IDEX       : std_logic;
  signal EX_ALUCTRL_OUT_IDEX : std_logic;
  signal EX_ALUEN_OUT_IDEX   : std_logic;
  -- CU signals
  signal IMM_CODE       : std_logic_vector(2 downto 0);
  signal FLUSH          : std_logic;
  signal STALL          : std_logic;
  signal NSTALL         : std_logic;  
  signal BRANCH         : std_logic;
  signal BPU_MISSPRED   : std_logic;
  signal BPU_PREDICTION : std_logic;
  signal HDU_STALL      : std_logic;
  signal ALU_SRC        : std_logic;
  signal ALU_CTR        : std_logic;
  signal ALU_CTRL_EN    : std_logic;
  signal MEM_RD         : std_logic;
  signal MEM_WR         : std_logic;
  signal RF_EN          : std_logic;
  signal RF_MUX         : std_logic; -- 1 from memory 0 non-from-memory
  signal IMM_EN         : std_logic;
  signal JUMP           : std_logic;
  signal AUIPC_MUX_OUT  : std_logic;
  signal LUI_HANDLER    : std_logic;
  -- Execute stage signals
  signal LUI_HANDLER_EXE     : std_logic;
  signal LUI_ALU             : std_logic_vector(31 downto 0);
  signal ALU_IN2_IDEX        : std_logic_vector(31 downto 0);
  signal ALU_RES_IN_EXMEM    : std_logic_vector(31 downto 0);
  signal CODE_ALUCTRL_OUT    : std_logic_vector(5 downto 0);
  signal OP_WB_IN_EXMEM      : std_logic_vector(3 downto 0);  
  signal ALU_RES_OUT_EXMEM   : std_logic_vector(31 downto 0);
  signal RS2_VAL_OUT_EXMEM   : std_logic_vector(31 downto 0);
  signal OP_WB_OUT_EXMEM     : std_logic_vector(3 downto 0);
  signal RD_ADDR_OUT_EXMEM   : std_logic_vector(4 downto 0);
  signal EX_ALUSRC_OUT       : std_logic;
  -- Data Memory Stage Signals
  signal ALU_RES_OUT_MEMWB : std_logic_vector(31 downto 0);
  signal MEM_RES_IN_MEMWB, MEM_RES_OUT_MEMWB : std_logic_vector(31 downto 0);
  signal OP_WB_OUT_MEMWB     : std_logic_vector(1 downto 0);
  signal RD_ADDR_OUT_MEMWB : std_logic_vector(4 downto 0);

begin

  VDD <= '1';
  GND <= '0';

  ----------- Instruction fetching stage -----------

  PC_INCREMENTER : INCREMENTER generic map(1)
                               port map(SELECTED_SRC, NEXT_PC);

  SOURCE_MUX : MUX_2to1 generic map(32)
                       port map(CURRENT_PC, PC_ID, FLUSH, SELECTED_SRC);

  PC_MUX : MUX_2to1 generic map(32)
                   port map(NEXT_PC, DIFF_PC, PC_DIR, PC_SOURCE);

  NSTALL <= NOT(STALL);
  PC : REG generic map(32)
           port map(PC_SOURCE, CLK, I_RST, NSTALL, CURRENT_PC);

  INSTR_ADDR <= CURRENT_PC;

  BRANCH_PREDICTION_UNIT : BPU port map(CLK, I_RST, unsigned(CURRENT_PC), unsigned(PC_ID), INSTR_ID(6 downto 0), BRANCH, unsigned(JMP_ADDR), DIFF_PC_U, BPU_PREDICTION, BPU_MISSPRED); 

  DIFF_PC <= std_logic_vector(DIFF_PC_U);

  PIPE_REG1 : PIPE_IF_ID port map(CLK, I_RST, FLUSH, STALL, INSTR, CURRENT_PC, INSTR_ID, PC_ID);

  ----------- Instruction decoding stage -----------

  RF : REG_FILE generic map(32, 32)
                port map(CLK, I_RST, INSTR_ID(19 downto 15), RF_OUT1, INSTR_ID(24 downto 20), RF_OUT2, RD_ADDR_OUT_MEMWB, RF_WRDIN_WB, OP_WB_OUT_MEMWB(1));

  JA : JMP_ADD port map(IMM_GEN_OUT, PC_ID, JMP_ADDR);

  IG : IMM_GEN port map(INSTR_ID, IMM_GEN_OUT, IMM_EN, IMM_CODE);

  BC : BRANCH_COMP generic map (32)
                   port map (IMM_CODE, BC_IN1, BC_IN2, BRANCH);

  BC_MUX_A : MUX_4to1 generic map(32)
                      port map(RF_OUT1, ALU_RES_IN_EXMEM, ALU_RES_OUT_EXMEM, RF_WRDIN_WB, FORWARD_A, BC_IN1);-- To b completed with other signals
  
  BC_MUX_B : MUX_4to1 generic map(32)
                      port map(RF_OUT2, ALU_RES_IN_EXMEM, ALU_RES_OUT_EXMEM, RF_WRDIN_WB, FORWARD_B, BC_IN2);-- To b completed with other signals


                      
  HDU_FU : HDU port map(INSTR_ID(19 downto 15), INSTR_ID(24 downto 20), RS1_ADDR_OUT_IDEX, RS2_ADDR_OUT_IDEX, RD_ADDR_OUT_IDEX, RD_ADDR_OUT_EXMEM, RD_ADDR_OUT_MEMWB,
                        M_RD_EN_OUT_IDEX, OP_WB_OUT_MEMWB(1), OP_WB_OUT_EXMEM(3), WR_RFEN_OUT_IDEX, IMM_CODE, HDU_STALL, FORWARD_A, FORWARD_B);                    

  CONTROL_UNIT : CU port map(EXTERNAL_RSTN, INSTR_ID(6 downto 0), BPU_MISSPRED, BPU_PREDICTION,
                             HDU_STALL, ALU_SRC, ALU_CTR, ALU_CTRL_EN, MEM_RD,
                             MEM_WR, RF_EN, RF_MUX, IMM_EN, IMM_CODE, FLUSH, STALL, JUMP, I_RST, AUIPC_MUX_OUT, LUI_HANDLER);

  MUX_AUIPC : MUX_2to1 generic map(32)
                       port map(BC_IN1, PC_ID, AUIPC_MUX_OUT, OUT_AUIPC);

  PIPE_REG2 : PIPE_ID_EX port map(CLK, I_RST, FLUSH, STALL, LUI_HANDLER, OUT_AUIPC, BC_IN2, IMM_GEN_OUT,
                                  INSTR_ID(19 downto 15), INSTR_ID(24 downto 20), INSTR_ID(11 downto 7), INSTR_ID(14 downto 12),
                                  RF_EN, RF_MUX, BRANCH, JUMP, MEM_RD, MEM_WR, ALU_SRC, ALU_CTR, ALU_CTRL_EN,
                                  WR_RFEN_OUT_IDEX, WR_RFMUX_OUT_IDEX, BRANCH_OUT_IDEX, JUMP_OUT_IDEX, M_RD_EN_OUT_IDEX, M_WR_OUT_IDEX, EX_ALUSRC_OUT, EX_ALUCTRL_OUT_IDEX, EX_ALUEN_OUT_IDEX,
                                  RS1_VAL_OUT_IDEX, RS2_VAL_OUT_IDEX, IMM_GEN_OUT_IDEX, RS1_ADDR_OUT_IDEX, RS2_ADDR_OUT_IDEX, RD_ADDR_OUT_IDEX, FUNC3_OUT_IDEX, LUI_HANDLER_EXE);
  ----------- Instruction execute stage -----------

  PC_DIR <= BRANCH_OUT_IDEX AND JUMP_OUT_IDEX;

  MUX_ALU_IN2 : MUX_2to1 generic map(32)
                         port map(RS2_VAL_OUT_IDEX, IMM_GEN_OUT_IDEX, EX_ALUSRC_OUT, ALU_IN2_IDEX);
  
  ALU_EXE : ALU generic map(32)
                port map(RS1_VAL_OUT_IDEX, ALU_IN2_IDEX, CODE_ALUCTRL_OUT, open, open, ALU_RES_IN_EXMEM);


  ALU_CTRL_EXE : ALU_CTRL port map(EX_ALUEN_OUT_IDEX, EX_ALUCTRL_OUT_IDEX, FUNC3_OUT_IDEX, AUIPC_MUX_OUT, CODE_ALUCTRL_OUT);              


  OP_WB_IN_EXMEM <= WR_RFEN_OUT_IDEX & WR_RFMUX_OUT_IDEX & M_RD_EN_OUT_IDEX & M_WR_OUT_IDEX;

  MUX_LUI : MUX_2to1 generic map(32)
                     port map(ALU_RES_IN_EXMEM, IMM_GEN_OUT_IDEX, LUI_HANDLER_EXE, LUI_ALU);

  PIPE_REG3 : PIPE_EX_MEM port map(CLK, I_RST, LUI_ALU, ALU_IN2_IDEX, OP_WB_IN_EXMEM, RD_ADDR_OUT_IDEX,
                          ALU_RES_OUT_EXMEM, RS2_VAL_OUT_EXMEM, OP_WB_OUT_EXMEM, RD_ADDR_OUT_EXMEM);

  ----------- Data Memory Stage -----------

  WRITE_EN <= OP_WB_OUT_EXMEM(0);
  READ_EN <= OP_WB_OUT_EXMEM(1);
  DATA_ADDR <= ALU_RES_OUT_EXMEM;
  DATA_OUT <= RS2_VAL_OUT_EXMEM;

  PIPE_REG4 : PIPE_MEM_WB port map (CLK, I_RST, ALU_RES_OUT_EXMEM, DATA_IN, OP_WB_OUT_EXMEM(3 downto 2), RD_ADDR_OUT_EXMEM,
                          ALU_RES_OUT_MEMWB, MEM_RES_OUT_MEMWB, OP_WB_OUT_MEMWB, RD_ADDR_OUT_MEMWB);

  ----------- Write Back Stage ------------

  WB_MUX : MUX_2to1 generic map (32)
                    port map (ALU_RES_OUT_MEMWB, MEM_RES_OUT_MEMWB,OP_WB_OUT_MEMWB(0),RF_WRDIN_WB);




end architecture;