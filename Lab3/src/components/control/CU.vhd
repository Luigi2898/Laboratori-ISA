library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity CU is
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
end entity;

architecture arch of CU is

  constant ARITH : std_logic_vector(6 downto 0) := "0110011"; -- ADD XOR SLT
  constant BEQ   : std_logic_vector(6 downto 0) := "1100011";                   -- TO B SENT TO IMM 000
  constant IMM   : std_logic_vector(6 downto 0) := "0010011"; -- ADDI SRAI ANDI -- TO B SENT TO IMM 001
  constant AUIPC : std_logic_vector(6 downto 0) := "0010111";                   -- TO B SENT TO IMM 010
  constant LUI   : std_logic_vector(6 downto 0) := "0110111";                   -- TO B SENT TO IMM 011
  constant LW    : std_logic_vector(6 downto 0) := "0000011";
  constant JAL   : std_logic_vector(6 downto 0) := "1101111";                   -- TO B SENT TO IMM 100
  constant SW    : std_logic_vector(6 downto 0) := "0100011";

begin

  with OPCODE select EX_ALUSRC_OUT  <= '0' when ARITH,
                                       '1' when IMM,
                                       '1' when BEQ,
                                       '1' when AUIPC,
                                       '1' when SW,
                                       '1' when LW,
                                       '0' when others;

  with OPCODE select EX_ALUCTRL_OUT <= '0' when ARITH,
                                       '0' when IMM,
                                       '1' when BEQ,
                                       '1' when SW,
                                       '1' when LW,
                                       '0' when others;

  with OPCODE select EX_ALUEN_OUT   <= '1' when ARITH,
                                       '1' when IMM,
                                       '1' when BEQ,
                                       '1' when SW,
                                       '1' when LW,
                                       '0' when others;

  with OPCODE select M_RD_OUT       <= '1' when LW,
                                       '0' when others;

  with OPCODE select M_WR_OUT       <= '1' when SW,
                                       '0' when others;

  with OPCODE select WB_RFEN_OUT    <= '1' when ARITH,
                                       '0' when BEQ,
                                       '1' when IMM,
                                       '1' when AUIPC,
                                       '1' when LUI,
                                       '1' when LW,
                                       '1' when JAL,
                                       '0' when SW,
                                       '0' when others;

  with OPCODE select WB_RFMUX_OUT   <= '0' when ARITH,
                                       '0' when BEQ,
                                       '0' when IMM,
                                       '0' when AUIPC,
                                       '0' when LUI,
                                       '1' when LW,
                                       '0' when JAL,
                                       '1' when SW,
                                       '0' when others;

  with OPCODE select IMM_CODE_OUT   <= "000" when IMM,
                                       "000" when LW,                                     
                                       "001" when SW,
                                       "010" when BEQ,
                                       "011" when AUIPC,
                                       "011" when LUI,
                                       "100" when JAL,
                                       "---" when others;

  with OPCODE select IMM_EN_OUT     <= '1' when BEQ,
                                       '1' when IMM,
                                       '1' when AUIPC,
                                       '1' when LUI,
                                       '1' when JAL,
                                       '1' when SW,
                                       '1' when LW,
                                       '0' when others;

  PIPE_FLUSH <= BPU_MISSPRED;
  
  with OPCODE select AUIPC_MUX_OUT  <= '1' when AUIPC,
                                       '0' when others;

  with OPCODE select LUI_MUX_OUT <= '1' when LUI,
                                    '0' when others;

  JUMP       <= BPU_PREDICTION;
  PIPE_STALL <= HDU_STALL;
  DP_RST     <= RST;

end architecture;
