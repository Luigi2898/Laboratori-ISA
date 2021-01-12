library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RISC_V is
  port (
	-- Data memory interface
  DATA_IN      : in  std_logic_vector(31 downto 0);
	DATA_ADDR    : out std_logic_vector(31 downto 0);
  DATA_OUT     : out std_logic_vector(31 downto 0);
  WRITE_EN     : out std_logic;
  READ_EN      : out std_logic;
	-- Instruction memory interface
	INSTR_ADDR   : out std_logic_vector(31 downto 0);
  INSTR        : in  std_logic_vector(31 downto 0);
  --
  CLK          : in  std_logic;
  EXTERNAL_RST : in  std_logic
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
    generic( word_size :  integer := 32 );
    port(
      CLK               : in  std_logic;
      RST               : in  std_logic;
      FLUSH             : in  std_logic;
      STALL             : in  std_logic; 
      INSTR_IF_IN       : in  std_logic_vector(word_size-1 downto 0);
      INSTR_PC_ADDR_IN  : in  std_logic_vector(word_size-1 downto 0);
      INSTR_IF_OUT      : out std_logic_vector(word_size-1 downto 0);
      INSTR_PC_ADDR_OUT : out std_logic_vector(word_size-1 downto 0)
    );
  end component;

  component REG_FILE is
    generic (Nbit : integer := 32;
             Nrow : integer := 32);
    port (
      CLK      : in  std_logic;
      RSTN     : in  std_logic;
  
      RD1_ADDR : in  std_logic_vector (Nbit-1 downto 0);
      RD1_DOUT : out std_logic_vector (Nbit-1 downto 0);
      --RD1_EN   : in std_logic;
  
      RD2_ADDR : in  std_logic_vector (Nbit-1 downto 0);
      RD2_DOUT : out std_logic_vector (Nbit-1 downto 0);
      --RD2_EN   : in std_logic;
      
      WR1_ADDR : in  std_logic_vector (Nbit-1 downto 0);
      WR1_DIN  : in  std_logic_vector (Nbit-1 downto 0);
      WR1_EN   : in  std_logic
    );
  end component;

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
      HDU_STALL      : in  std_logic;unsigned
      HDU_FORWARD    : in  std_logic_vector(3 downto 0);
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
      -- Forward
      FORWARD_B      : out std_logic;
      FORWARD_A      : out std_logic;
      -- Datapath reset
      DP_RST         : out std_logic
    );
  end component;

  component PIPE_ID_EX is 
  generic( word_size :  integer := 32 );
  port(
    CLK                   : in std_logic;
    RST                   : in std_logic;
    FLUSH                 : in std_logic;
    STALL                 : in std_logic; 
    RS1_VAL_IN            : in std_logic_vector(word_size-1 downto 0);
    RS2_VAL_IN            : in std_logic_vector(word_size-1 downto 0);
    IMM_GEN_IN            : in std_logic_vector(word_size-1 downto 0);
    RS1_ADDR_IN           : in std_logic_vector(4 downto 0);
    RS2_ADDR_IN           : in std_logic_vector(4 downto 0);
    RD_ADDR_IN            : in std_logic_vector(4 downto 0);
    WR_RFEN_IN            : in std_logic;
    WR_RFMUX_IN           : in std_logic;
    JUMP_IN               : in std_logic;
    M_RD_EN_IN            : in std_logic;
    M_WR_IN               : in std_logic;
    EX_ALUSRC_IN          : in std_logic;
    EX_ALUCTRL_IN         : in std_logic;
    EX_ALUEN_IN           : in std_logic;
    ------------------------------------------------------------------ out
    WR_RFEN_OUT           : out std_logic;
    WR_RFMUX_OUT          : out std_logic;
    JUMP_OUT              : out std_logic;
    M_RD_EN_OUT           : out std_logic;
    M_WR_OUT              : out std_logic;
    EX_ALUSRC_OUT         : out std_logic;
    EX_ALUCTRL_OUT        : out std_logic;
    EX_ALUEN_OUT          : out std_logic;
    RS1_VAL_OUT           : out std_logic_vector(word_size-1 downto 0);
    RS2_VAL_OUT           : out std_logic_vector(word_size-1 downto 0);
    IMM_GEN_OUT           : out std_logic_vector(word_size-1 downto 0);
    RS1_ADDR_OUT          : out std_logic_vector(4 downto 0);
    RS2_ADDR_OUT          : out std_logic_vector(4 downto 0);
    RD_ADDR_OUT           : out std_logic_vector(4 downto 0)    
  );
end component PIPE_ID_EX;

component ALU is
  generic (N : integer := 32)
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
      CODE_OUT : out std_logic_vector(5 downto 0)
    );
  end component;

  component PIPE_EX_MEM is  

  generic( word_size :  integer := 32 );
  port(
    CLK           : in  std_logic;
    RST           : in  std_logic;
    ALU_RES_IN    : in  std_logic_vector(word_size-1 downto 0);
    RS2_VAL_IN    : in  std_logic_vector(word_size-1 downto 0); --from mux
    OP_WB_MEM_IN  : in  std_logic_vector(4 downto 0); --MEM/WB ctrls (WB_RFEN_OUT & WB_RFMUX_OUT & BRANCH & M_RD_OUT & M_WR_OUT)
    RD_ADDR_IN    : in  std_logic_vector(4 downto 0);
    ------------------------------------------------------------------ out
    ALU_RES_OUT   : out std_logic_vector(word_size-1 downto 0);
    RS2_VAL_OUT   : out std_logic_vector(word_size-1 downto 0);
    OP_WB_MEM_OUT : out std_logic_vector(4 downto 0);
    RD_ADDR_OUT   : out std_logic_vector(4 downto 0)
  );
end component PIPE_EX_MEM;

  -- Global signals  
  signal Vdd, GND       : std_logic;
  signal I_RST          : std_logic;
  -- Fetch stage signals
  signal PC_SOURCE      : std_logic_vector(31 downto 0);
  signal CURRENT_PC     : std_logic_vector(31 downto 0);
  signal DIFF_PC        : std_logic_vector(31 downto 0);
  signal NEXT_PC        : std_logic_vector(31 downto 0);
  signal BEFOREJMP_PC   : std_logic_vector(31 downto 0);
  signal SELECTED_SRC   : std_logic_vector(31 downto 0);
  signal PC_DIR         : std_logic;
  signal PC_SOURCE      : std_logic;
  -- Decode stage signals
  signal RF_OUT1        : std_logic_vector(31 downto 0);
  signal RF_OUT2        : std_logic_vector(31 downto 0);
  signal RF_IN          : std_logic_vector(31 downto 0);
  signal IMM_GEN_OUT    : std_logic_vector(31 downto 0);
  signal JMP_ADDR       : std_logic_vector(31 downto 0);
  signal BC_COMP1       : std_logic_vector(31 downto 0);
  signal BC_COMP2       : std_logic_vector(31 downto 0);
  signal ALU_CODE       : std_logic_vector(5 downto 0);
  signal RS1_VAL_IDEX_OUT     : std_logic_vector(31 downto 0);
  signal RS2_VAL_IDEX_OUT     : std_logic_vector(31 downto 0);
  signal IMM_GEN_IDEX_OUT     : std_logic_vector(31 downto 0);
  signal RS1_ADDR_IDEX_OUT    : std_logic_vector(4 downto 0);
  signal RS2_ADDR_IDEX_OUT    : std_logic_vector(4 downto 0);
  signal RD_ADDR_IDEX_OUT     : std_logic_vector(4 downto 0);
  signal FUNC3_IDEX_OUT       : std_logic_vector(2 downto 0);
  signal WR_RFEN_IDEX_OUT     : std_logic;
  signal WR_RFMUX_IDEX_OUT    : std_logic;
  signal JUMP_IDEX_OUT        : std_logic;
  signal M_RD_EN_IDEX_OUT     : std_logic;
  signal M_WR_IDEX_OUT        : std_logic;
  signal EX_ALUSRC_IDEX_OUT   : std_logic;
  signal EX_ALUCTRL_IDEX_OUT  : std_logic;
  signal EX_ALUEN_IDEX_OUT    : std_logic;
  -- CU signals
  signal FLUSH          : std_logic;
  signal STALL          : std_logic;
  signal RF_WR_EN       : std_logic;
  signal IMM_CODE       : std_logic_vector(2 downto 0);
  signal BRANCH         : std_logic;
  signal BPU_MISSPRED   : std_logic;
  signal BPU_PREDICTION : std_logic;
  signal HDU_STALL      : std_logic;
  signal HDU_FORWARD    : std_logic;
  signal ALU_SRC        : std_logic;
  signal ALU_CTRL       : std_logic;
  signal ALU_CTRL_EN    : std_logic;
  signal MEM_RD         : std_logic;
  signal MEM_WR         : std_logic;
  signal RF_EN          : std_logic;
  signal RF_MUX         : std_logic; -- 1 from memory 0 non-from-memory
  signal IMM_EN         : std_logic;
  signal JUMP           : std_logic;
  signal FORWARD_B      : std_logic;
  signal FORWARD_A      : std_logic;
-- Execute stage signals
signal ALU_IN1_EXE          : std_logic_vector(31 downto 0);
signal ALU_IN2_EXE          : std_logic_vector(31 downto 0);
signal ALU_RES_EXE          : std_logic_vector(31 downto 0);
signal CODE_ALUCTRL_OUT     : std_logic_vector(5 downto 0);
signal OP_WB_MEM_PIPE_IN    : std_logic_vector(4 downto 0);  
signal ALU_RES_PIPE_OUT     : std_logic_vector(31 downto 0);
signal RS2_VAL_PIPE_OUT     : std_logic_vector(31 downto 0);
signal OP_WB_MEM_PIPE_OUT   : std_logic_vector(4 downto 0);
signal RD_ADDR_PIPE_OUT     : std_logic_vector(4 downto 0);

begin

  Vdd <= '1';
  GND <= '0';

  ----------- Instruction fetching stage -----------

  PC_INCREMENTER : INCREMENTER generic map(1)
                               port map(SELECTED_SRC, NEXT_PC);

  SOURCE_MUX : MUX2to1 generic map(32)
                       port map(CURRENT_PC, OLD_PC, PC_SOURCE, SELECTED_SRC);

  PC_MUX : MUX2to1 generic map(32)
                   port map(NEXT_PC, DIFF_PC, PC_DIR, PC_SOURCE);

  PC : REG generic map(32)
           port map(PC_SOURCE, CLK, I_RST, Vdd, CURRENT_PC);

  INSTR_ADDR <= CURRENT_PC;


  BRANCH_PREDICTION_UNIT : BPU port map(CLK, I_RST,); -- To b completed with other signals

  PIPE_REG1 : PIPE_IF_ID generic map(32)
                         port map(CLK, I_RST, FLUSH, STALL, INSTR, CURRENT_PC, INSTR_ID, PC_ID);

  ----------- Instruction decoding stage -----------

  RF : REG_FILE generic map(32, 32)
                port map(CLK, I_RST, INSTR_ID(24 downto 20), RF_OUT1, INSTR_ID(20 downto 16), RF_OUT2, INSTR_ID(11 downto 7), RF_IN, RF_WR_EN);

  JA : JMP_ADD port map(IMM_GEN_OUT, PC_ID, JMP_ADDR);

  IG : IMM_GEN port map(INSTR_ID, IMM_GEN_OUT, IMM_EN, IMM_CODE);

  BC : BRANCH_COMP generic map(IMM_CODE, BC_IN1, BC_IN2, BRANCH);

  BC_MUX_A : MUX_4to1 generic map(32)
                      port map(RFOUT_1, ..., BC_IN1);-- To b completed with other signals
  
  BC_MUX_B : MUX_4to1 generic map(32)
                      port map(RFOUT_2, ..., BC_IN2);-- To b completed with other signals

  CONTROL_UNIT : CU port map(EXTERNAL_RST, INSTR_ID(6 downto 0), BPU_MISSPRED, BPU_PREDICTION, HDU_STALL, HDU_FORWARD, ALU_SRC, ALU_CTRL, ALU_CTRL_EN, MEM_RD, MEM_WR, RF_EN, RF_MUX, IMM_EN, IMM_CODE, JUMP, FORWARD_B, FORWARD_A, I_RST);

  ALU_CONTROLLER : ALU_CTRL port map(ALU_CTRL_EN, ALU_CTRL, INSTR_ID(9 downto 7), ALU_CODE)

  PIPE_REG2 : PIPE_ID_EXE generic map(32)
                          port map(CLK, I_RST, PIPE_FLUSH, PIPE_STALL, BC_IN1, BC_IN2, IMM_GEN_OUT,
                                   INSTR_ID(11 downto 7), INSTR_ID(20 downto 16), INSTR_ID(24 downto 20),
                                   WR_RFEN, WR_RFMUX, JUMP, M_RD_EN, M_WR, EX_ALUSRC, EX_ALUCTRL, EX_ALUEN,
                                   WR_RFEN_IDEX_OUT, WR_RFMUX_IDEX_OUT, JUMP_IDEX_OUT, M_RD_EN_IDEX_OUT, M_WR_IDEX_OUT, EX_ALUSRC_IDEX_OUT, EX_ALUCTRL_IDEX_OUT, EX_ALUEN_IDEX_OUT,
                                   RS1_VAL_IDEX_OUT, RS2_VAL_IDEX_OUT, IMM_GEN_IDEX_OUT, RS1_ADDR_IDEX_OUT, RS2_ADDR_IDEX_OUT, RD_ADDR_IDEX_OUT);

  ----------- Instruction execute stage -----------

  MUX_ALU_IN2 : MUX2to1 generic map(32)
                        port map(RS2_VAL_IDEX_OUT, IMM_GEN_IDEX_OUT, EX_ALUSRC_OUT, ALU_IN2_EXE);
  
  ALU_EXE : ALU generic map(32)
                port map(RS1_VAL_IDEX_OUT, ALU_IN2_EXE, CODE_ALUCTRL_OUT, ALU_RES_EXE);


  ALU_CTRL_EXE : ALE_CTRL port map(EX_ALUEN_IDEX_OUT, EX_ALUCTRL_IDEX_OUT, FUNC3_IDEX_OUT, CODE_ALUCTRL_OUT);              


  OP_WB_MEM_PIPE_IN <= WR_RFEN_IDEX_OUT & WR_RFMUX_IDEX_OUT & JUMP_IDEX_OUT & M_RD_EN_IDEX_OUT & M_WR_IDEX_OUT;

  PIPE_REG3 : PIPE_EX_MEM generic map(32)
                          port map(CLK, I_RST, ALU_RES_EXE, ALU_IN2_EXE, OP_WB_MEM_PIPE_IN, RD_ADDR_IDEX_OUT,
                          ALU_RES_PIPE_OUT, RS2_VAL_PIPE_OUT, OP_WB_MEM_PIPE_OUT, RD_ADDR_PIPE_OUT);

end architecture;