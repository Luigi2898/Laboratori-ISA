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

  -- Global signals
  signal Vdd, GND     : std_logic;
  signal I_RST        : std_logic;
  -- Fetch stage signals
  signal PC_SOURCE    : std_logic_vector(31 downto 0);
  signal CURRENT_PC   : std_logic_vector(31 downto 0);
  signal DIFF_PC      : std_logic_vector(31 downto 0);
  signal NEXT_PC      : std_logic_vector(31 downto 0);
  signal BEFOREJMP_PC : std_logic_vector(31 downto 0);
  signal SELECTED_SRC : std_logic_vector(31 downto 0);
  signal PC_DIR       : std_logic;
  signal PC_SOURCE    : std_logic;
  -- Decode stage signals
  signal RF_OUT1      : std_logic_vector(31 downto 0);
  signal RF_OUT2      : std_logic_vector(31 downto 0);
  signal RF_IN        : std_logic_vector(31 downto 0);
  signal IMM_GEN_OUT  : std_logic_vector(31 downto 0);
  signal JMP_ADDR     : std_logic_vector(31 downto 0);
  signal BC_COMP1     : std_logic_vector(31 downto 0);
  signal BC_COMP2     : std_logic_vector(31 downto 0);
  -- CU signals
  signal FLUSH        : std_logic;
  signal STALL        : std_logic;
  signal RF_WR_EN     : std_logic;
  signal IMM_EN_IN    : std_logic;
  signal IMM_CODE     : std_logic_vector(2 downto 0);
  signal BRANCH       : std_logic;
  signal BPU_MISSPRED   : std_logic;
  signal BPU_PREDICTION : std_logic;

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

  BRANCH_PREDICTION_UNIT : BPU port map(CLK, I_RST,);

  PIPE_REG1 : PIPE_IF_ID generic map(32)
                         port map(CLK, I_RST, FLUSH, STALL, INSTR, CURRENT_PC, INSTR_ID, PC_ID);

  ----------- Instruction decoding stage -----------

  RF : REG_FILE generic map(32, 32)
                port map(CLK, I_RST, INSTR_ID(24 downto 20), RF_OUT1, INSTR_ID(20 downto 16), RF_OUT2, INSTR_ID(11 downto 7), RF_IN, RF_WR_EN);

  JA : JMP_ADD port map(IMM_GEN_OUT, PC_ID, JMP_ADDR);

  IG : IMM_GEN port map(INSTR_ID, IMM_GEN_OUT, IMM_EN_IN, IMM_CODE);

  BC : BRANCH_COMP generic map(IMM_CODE, BC_IN1, BC_IN2, BRANCH);

  BC_MUX_A : MUX_4to1 generic map(32)
                      port map(RFOUT_1, ..., BC_IN1);
  
  BC_MUX_B : MUX_4to1 generic map(32)
                      port map(RFOUT_2, ..., BC_IN2);

  CONTROL_UNIT : CU port map(EXTERNAL_RST, INSTR_ID(6 downto 0), BPU_MISSPRED, BPU_PREDICTION)

end architecture;