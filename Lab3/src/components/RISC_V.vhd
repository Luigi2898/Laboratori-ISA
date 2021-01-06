library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RISC_V is
  port (
	-- Data memory interface
	DATA_ADDR    : out   std_logic_vector(32 downto 0);
  DATA         : inout std_logic_vector(32 downto 0);
  WRITE_EN     : out   std_logic;
	-- Instruction memory interface
	INSTR_ADDR   : out   std_logic_vector(32 downto 0);
  INSTR        : in    std_logic_vector(32 downto 0);
  --
  CLK          : in    std_logic;
  EXTERNAL_RST : in    std_logic
  );
end RISC_V;

architecture rtl of RISC_V is

  -- Component declarations

  component CU is
	  port (
	    -- From code memory
	    OPCODE         : in  std_logic_vector(6 downto 0);
	    -- From BPU
	    BPU_MISSPRED   : in  std_logic;
	    BPU_PREDICTION : in  std_logic;
	    -- From HDU
	    HDU_STALL      : in  std_logic;
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
      FORWARD_A      : out std_logic
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
      STALL       : out std_logic;
      FORWARD     : out std_logic_vector(3 downto 0)     
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

  component ALU is
	  port (
	    DATA1_IN   : in  std_logic_vector(31 downto 0);
	    DATA2_IN   : in  std_logic_vector(31 downto 0);
	    OPCODE_IN  : in  std_logic_vector(5 downto 0);
	    ZF_OUT     : out std_logic;
	    NF_OUT     : out std_logic;
	    RESULT_OUT : out std_logic_vector(31 downto 0)
	  );
  end component;

  component IMM_GEN is
    generic ( word_size : integer := 32);
    port (
      IR_IN       : in std_logic_vector(word_size - 1 downto 0);
      IMM_GEN_OUT : out std_logic_vector(word_size - 1 downto 0);
      IMM_EN_IN   : in std_logic;
      IMM_CODE_IN : in std_logic_vector(2 downto 0)
    );
  end component;

  component INCREMENTER is
	  port (
	    CURRENT_ADDR : in  std_logic_vector(31 downto 0);
	    NEXT_ADDR    : out std_logic_vector(31 downto 0)
	  );
  end component;

  component JMP_ADD is
	  port (
	    IMM_GEN_IN : in std_logic_vector(31 downto 0);
	    PC_IF_ID   : in std_logic_vector(31 downto 0);
	    JMP_ADDR   : out std_logic_vector(31 downto 0)
	  );
  end component;

  component PIPE_EX_MEM is 
  	generic( word_size :  integer := 32 );
  	port(
      CLK                   : in std_logic;
      RST                   : in std_logic;
      ALU_RES_IN            : in std_logic_vector(word_size-1 downto 0);
      RS2_VAL_IN            : in std_logic_vector(word_size-1 downto 0); --from mux
      OP_WB_MEM_IN          : in std_logic_vector(4 downto 0); --MEM/WB ctrls (WB_RFEN_OUT & WB_RFMUX_OUT & BRANCH & M_RD_OUT & M_WR_OUT)
      RD_ADDR_IN            : in std_logic_vector(4 downto 0);
      ------------------------------------------------------------------ out
      ALU_RES_OUT           : out std_logic_vector(word_size-1 downto 0);
      RS2_VAL_OUT           : out std_logic_vector(word_size-1 downto 0);
      OP_WB_MEM_OUT         : out std_logic_vector(4 downto 0);
      RD_ADDR_OUT           : out std_logic_vector(4 downto 0)
    );
  end component;


  component PIPE_ID_EX is 
    generic( word_size :  integer := 32 );
    port(
      CLK                   : in std_logic;
      RST                   : in std_logic;
      FLUSH                 : in std_logic;
      STALL                 : in std_logic; 
      PC_VAL_IN             : in std_logic_vector(word_size-1 downto 0);
      TARGET_ADDR_IN        : in std_logic_vector(word_size-1 downto 0); 
      RS1_VAL_IN            : in std_logic_vector(word_size-1 downto 0);
      RS2_VAL_IN            : in std_logic_vector(word_size-1 downto 0);
      IMM_GEN_IN            : in std_logic_vector(word_size-1 downto 0);
      RS1_ADDR_IN           : in std_logic_vector(4 downto 0);
      RS2_ADDR_IN           : in std_logic_vector(4 downto 0);
      RD_ADDR_IN            : in std_logic_vector(4 downto 0);
      CTRL_CU_IN            : in std_logic_vector(6 downto 0); --dalla CU al pipe_reg WB/MEM/EXE bits group (WB_RFEN_OUT & WB_RFMUX_OUT & BRANCH & M_RD_OUT & M_WR_OUT & ALUSrc & ALUCtrl)
      ------------------------------------------------------------------ out
      PC_VAL_OUT            : out std_logic_vector(word_size-1 downto 0);
      TARGET_ADDR_OUT       : out std_logic_vector(word_size-1 downto 0); 
      RS1_VAL_OUT           : out std_logic_vector(word_size-1 downto 0);
      RS2_VAL_OUT           : out std_logic_vector(word_size-1 downto 0);
      IMM_GEN_OUT           : out std_logic_vector(word_size-1 downto 0);
      RS1_ADDR_OUT          : out std_logic_vector(4 downto 0);
      RS2_ADDR_OUT          : out std_logic_vector(4 downto 0);
      RD_ADDR_OUT           : out std_logic_vector(4 downto 0);
      CTRL_CU_OUT           : out std_logic_vector(6 downto 0) 
    );
  end component;

  component PIPE_IF_ID is 
    generic( word_size :  integer := 32 );
    port(
      CLK               : in std_logic;
      RST               : in std_logic;
      FLUSH             : in std_logic;
      STALL             : in std_logic; 
      INSTR_IF_IN       : in std_logic_vector(word_size-1 downto 0);
      INSTR_PC_ADDR_IN  : in std_logic_vector(word_size-1 downto 0);
      INSTR_IF_OUT      : out std_logic_vector(word_size-1 downto 0);
      INSTR_PC_ADDR_OUT : out std_logic_vector(word_size-1 downto 0)
    );
  end component;

  component PIPE_MEM_WB is 
    generic( word_size :  integer := 32 );
    port(
      CLK                   : in std_logic;
      RST                   : in std_logic;
      ALU_RES_IN            : in std_logic_vector(word_size-1 downto 0);
      MEM_RES_IN            : in std_logic_vector(word_size-1 downto 0); 
      OP_WB_IN              : in std_logic_vector(4 downto 0); --WB ctrls (WB_RFEN_OUT & WB_RFMUX_OUT)
      RD_ADDR_IN            : in std_logic_vector(4 downto 0);
      ------------------------------------------------------------------ out
      ALU_RES_OUT           : out std_logic_vector(word_size-1 downto 0);
      MEM_RES_OUT           : out std_logic_vector(word_size-1 downto 0);
      OP_WB_OUT             : out std_logic_vector(4 downto 0);
      RD_ADDR_OUT           : out std_logic_vector(4 downto 0)
    );
  end component;

  component REG_FILE is
	  generic (Nbit : integer := 32;
	      		 Nrow : integer := 32);
	  port (
	    CLK      : in std_logic;
	    RSTN     : in std_logic;
	    RD1_ADDR : in unsigned (Nbit-1 downto 0);
	    RD1_DOUT : out signed (Nbit-1 downto 0);
	    RD2_ADDR : in unsigned (Nbit-1 downto 0);
	    RD2_DOUT : out signed (Nbit-1 downto 0);
	    WR1_ADDR : in unsigned (Nbit-1 downto 0);
	    WR1_DIN  : in signed (Nbit-1 downto 0);
	    WR1_EN   : in std_logic
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

  -- Signals definitions

  -- Global signals
  signal INTERNAL_RST   : std_logic;
  -- Program counter signals
  signal NEXT_ADDR      : std_logic_vector(31 downto 0);
  signal PC_EN          : std_logic;
  signal CURRENT_ADDR   : std_logic;
  signal TODECODE_ADDR  : std_logic_vector(31 downto 0);
  -- Pipe control signals
  signal PIPE_FLUSH     : std_logic;
  signal PIPE_STALL     : std_logic;
  -- Instruction signals
  signal FETCHED_INSTR  : std_logic_vector(31 downto 0);
  signal TODECODE_INSTR : std_logic_vector(31 downto 0);
  signal OPCODE         : std_logic_vector(31 downto 0);
  -- Branch prediction unit signals 
  signal BPU_MISSPRED   : std_logic;
  signal BPU_PREDICTION : std_logic;
  -- Hazard detection unit signals
  signal HDU_STALL      : std_logic;
  signal HDU_FORWARD    : std_logic_vector(3 downto 0);

begin

  FETCHED_INSTR <= INSTR;

  PC : REG generic map (32)
           port map    (NEXT_ADDR, CLK, INTERNAL_RST, PC_EN, CURRENT_ADDR);

  INSTR_ADDR <= CURRENT_ADDR;

  IF_ID : PIPE_IF_ID generic map (32)
                     port map    (CLK, INTERNAL_RST, PIPE_FLUSH, PIPE_STALL, FETCHED_INSTR, CURRENT_ADDR, TODECODE_INSTR, TODECODE_ADDR);

  OPCODE <= TODECODE_INSTR(6 downto 0);

  CONTROL_UNIT : CU port map(OPCODE, BPU_MISSPRED, BPU_PREDICTION, HDU_STALL, HDU_FORWARD)

end architecture;