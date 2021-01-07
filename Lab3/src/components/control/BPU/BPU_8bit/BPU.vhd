library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BPU is
  port (
    CLK : in std_logic;
    RSTN : in std_logic;
    PC : in unsigned (7 downto 0);
    PC_D2 : in unsigned (7 downto 0);
    OPCODE_D2 : in std_logic_vector (6 downto 0);
    OUTCOME : in std_logic;
    TARGET_ADDRESS_IN : in unsigned (7 downto 0);
    TARGET_ADDRESS_OUT : out unsigned (7 downto 0);
    PREDICTION : inout std_logic;
    MISPREDICTION : out std_logic
  );
end entity BPU;

architecture rtl of BPU is

  component CACHE_MEM is
    generic (SetNum : integer := 2;
             SetEntries : integer := 2;
             TagSize : integer := 1;
             ContentSize : integer := 2;
             AddrBits : integer := 2;
             SetBits : integer := 1 ;
             EntriesBits : integer := 1);
    port (
      CLK : in std_logic;
      RSTN : in std_logic;
      RD_ADDR : in unsigned(AddrBits-1 downto 0);
      WR_ADDR : in unsigned(AddrBits-1 downto 0);
      WR_EN : in std_logic;
      RD_EN : in std_logic;
      DIN : in unsigned (ContentSize-1 downto 0);
      DOUT : out unsigned (ContentSize-1 downto 0);
      HIT_MISSN : out std_logic
  
    );
  end component CACHE_MEM;

  component BPU_CU is
    port (
      HIT_MISSN_D2 : in std_logic;
      OPCODE_D2 : in std_logic_vector(6 downto 0);
      WR_EN_CACHE : out std_logic;
      WR_EN_BHT : out std_logic;
      WR_EN_PHT : out std_logic    
    );
  end component BPU_CU;

  component BHT is
    generic (Size : integer := 4;
             Depth : integer := 4;
             AddrBits : integer := 2);
    port (
      CLK   : in std_logic;
      RSTN : in std_logic;
      WR_EN : in std_logic;
      WR_ADDR : in unsigned (AddrBits-1 downto 0);
      RD_ADDR : in unsigned (AddrBits-1 downto 0);
      DIN : in std_logic;
      DOUT : out std_logic_vector(Depth-1 downto 0)   
    );
  end component BHT;

  component PHT is
    generic (Size : integer := 16;
             AddrBits : integer := 4);
    port (
      CLK : in std_logic;
      RSTN : in std_logic;
      RD_ADDR : in unsigned(AddrBits-1 downto 0);
      WR_ADDR : in unsigned(AddrBits-1 downto 0);
      WR_EN : in std_logic;
      OUTCOME_IN : in std_logic;
      PREDICTION_OUT : out std_logic
    );
  end component PHT;

  component REG is
    generic(N : integer := 11);
    port(
    REG_IN           : in  std_logic_vector(N-1 downto 0);
    CLK, RST_N, LOAD : in  std_logic;
    REG_OUT          : out std_logic_vector(N-1 downto 0)
    );
  end component REG;

  component MUX_2X1TO1X1 is
  port (
    X1 : in  std_logic;
    X2 : in  std_logic;
    S  : in  std_logic;
    O  : out std_logic
    );
  end component MUX_2X1TO1X1;

  component DELAY_CHAIN is
    generic (Nbits : integer := 32;
             DelayUnits : integer := 2);
    port (
      CLK : in std_logic;
      RSTN : in std_logic;
      EN : in std_logic;
      DIN : in std_logic_vector (Nbits-1 downto 0);
      DOUT : out std_logic_vector (Nbits-1 downto 0)
    );
  end component DELAY_CHAIN;

  component DELAY_CHAIN_1 is
    generic (DelayUnits : integer := 2);
    port (
      CLK : in std_logic;
      RSTN : in std_logic;
      EN : in std_logic;
      DIN : in std_logic;
      DOUT : out std_logic
    );
  end component DELAY_CHAIN_1;

  constant SizePC : integer := 8;
  signal VDD, GND : std_logic;
  signal HIT_MISSN, HIT_MISSN_D2 : std_logic;
  signal PC_LSBs, PC_LSBs_D2 : unsigned (SizePC-5-1 downto 0);
  signal RD_ADDR_PHT, RD_ADDR_PHT_D2 : unsigned (3 downto 0);
  signal WR_EN_BHT, WR_EN_CACHE, WR_EN_PHT : std_logic;
  signal BRANCH_HISTORY, BRANCH_HISTORY_D2 : std_logic_vector (3 downto 0);
  signal PREDICTION_OUT, PREDICTION_D2 : std_logic;
  
begin

  VDD <= '1';
  GND <= '0';
  PC_LSBs <= PC (2 downto 0);
  PC_LSBs_D2 <= PC_D2 (2 downto 0);
  RD_ADDR_PHT <= unsigned(BRANCH_HISTORY);
  RD_ADDR_PHT_D2 <= unsigned(BRANCH_HISTORY_D2);
  MISPREDICTION <= OUTCOME xor PREDICTION_D2;

  INSTR_CACHE : CACHE_MEM generic map (4,8,5,8,8,0,3)
                port map (CLK,RSTN,PC,PC_D2,WR_EN_CACHE,VDD,TARGET_ADDRESS_IN,TARGET_ADDRESS_OUT,HIT_MISSN);
  
  BRANCH_HISTORY_TABLE : BHT generic map (8,4,3)
        port map (CLK,RSTN,WR_EN_BHT,PC_LSBs_D2,PC_LSBs,OUTCOME,BRANCH_HISTORY);

  PATTERN_HISTORY_TABLE : PHT generic map (16,4)
        port map (CLK,RSTN,RD_ADDR_PHT,RD_ADDR_PHT_D2,WR_EN_PHT,OUTCOME,PREDICTION_OUT);
  
  CONTROL_UNIT : BPU_CU port map (HIT_MISSN_D2,OPCODE_D2,WR_EN_CACHE,WR_EN_BHT,WR_EN_PHT);

  PRED_MUX : MUX_2X1TO1X1 port map (GND,PREDICTION_OUT,HIT_MISSN,PREDICTION);

  PHT_ADDR_DELAY_CHAIN : DELAY_CHAIN generic map (4,1)
                         port map (CLK,RSTN,VDD,BRANCH_HISTORY,BRANCH_HISTORY_D2);

  HIT_MISSN_DELAY_CHAIN : DELAY_CHAIN_1 generic map (1)
                          port map (CLK,RSTN,VDD,HIT_MISSN,HIT_MISSN_D2);

  PREDICTION_DELAY_CHAIN : DELAY_CHAIN_1 generic map (1)
                           port map (CLK,RSTN,VDD,PREDICTION,PREDICTION_D2);

end architecture rtl;

