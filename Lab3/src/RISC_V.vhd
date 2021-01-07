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

  -- Global signals
  signal Vdd, GND   : std_logic;
  signal I_RST      : std_logic;
  -- Fetch stage signals
  signal PC_SOURCE  : std_logic_vector(31 downto 0);
  signal CURRENT_PC : std_logic_vector(31 downto 0);
  signal DIFF_PC    : std_logic_vector(31 downto 0);
  signal NEXT_PC    : std_logic_vector(31 downto 0);
  signal PC_DIR     : std_logic;
  -- CU signals
  signal FLUSH      : std_logic;
  signal STALL      : std_logic;

begin

  Vdd <= '1';
  GND <= '0';

  ----------- Instruction fetching stage -----------

  PC_INCREMENTER : INCREMENTER generic map(4)
                               port map(CURRENT_PC, NEXT_PC);

  PC_MUX : MUX2to1 generic map(32)
                   port map(NEXT_PC, DIFF_PC, PC_DIR, PC_SOURCE);

  PC : REG generic map(32)
           port map(PC_SOURCE, CLK, I_RST, Vdd, CURRENT_PC);

  INSTR_ADDR <= CURRENT_PC;

  PIPE_REG1 : PIPE_IF_ID generic map(32)
                         port map(CLK, I_RST, FLUSH, STALL, )

  ----------- Instruction decoding stage -----------


end architecture;