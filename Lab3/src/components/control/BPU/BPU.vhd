library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BPU is
  port (
    CLK : in std_logic;
    RSTN : in std_logic;
    PC : in unsigned (31 downto 0);
    PC_D2 : in unsigned (31 downto 0);
    OPCODE_D2 : in std_logic_vector (6 downto 0);
    OUTCOME : in std_logic;
    TARGET_ADDRESS_IN : in unsigned (31 downto 0);
    PREDICTION : out std_logic;
    TARGET_ADDRESS_OUT : unsigned (31 downto 0)
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

  
  
begin

  INSTR_CACHE : CACHE_MEM generic map (4,8,5,8,8,0,3)
                port map (CLK,RSTN,PC,PC_D2,WR_EN_CACHE,VDD,TARGET_ADDRESS_IN,TARGET_ADDRESS_OUT,HIT_MISSN);
  
  BHT : BHT generic map (8,4,3)
        port map (CLK,RSTN,WR_EN_BHT,PC_LSBs_D2,PC_LSBs,OUTCOME,RD_ADDR_PHT);

  PHT : PHT generic map (16,4)
        port map (CLK,RSTN,RD_ADDR_PHT,RD_ADDR_PHT_D2,WR_EN_PHT,OUTCOME,PREDICTION);
  
  BPU_CU : BPU_CU port map (HIT_MISSN_D2,OPCODE_D2,WR_EN_CACHE,WR_EN_BHT,WR_EN_PHT);

  
end architecture rtl;

