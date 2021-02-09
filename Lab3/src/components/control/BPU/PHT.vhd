library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PHT is
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
end entity PHT;

architecture rtl of PHT is

  component SAT_CNT is
    generic ( Nb : integer := 2;
              Module : integer := 4);
    port (
      CLK : in std_logic;
      RSTN : in std_logic;
      EN : in std_logic;
      CNT_UP_DOWNN : in std_logic;
      CNT_OUT : out unsigned (Nb-1 downto 0)
    );
  end component SAT_CNT;
  
  signal DECODED_ADDR : std_logic_vector(Size-1 downto 0);
  type memtype is array (Size-1 downto 0) of unsigned(1 downto 0);
  signal MEM : memtype;

begin

  write_address_decode_process : process (WR_ADDR,WR_EN)
  variable hot_one : integer := 0;
  variable decoded_addr_var : std_logic_vector(Size-1 downto 0);

  begin
    hot_one := to_integer(WR_ADDR);
    decoded_addr_var := (others => '0');
    decoded_addr_var(hot_one) := '1' and WR_EN;

    DECODED_ADDR <= decoded_addr_var;
  
  end process write_address_decode_process;

  pattern_history_regs: for i in 0 to size -1 generate

    PHR : SAT_CNT port map (CLK,RSTN,DECODED_ADDR(i),OUTCOME_IN,MEM(i));

  end generate pattern_history_regs;

  data_read_process : process(RD_ADDR,MEM)
  variable rd_addr_var : integer := 0;

    begin
      rd_addr_var := to_integer(RD_ADDR);
      PREDICTION_OUT <= MEM(rd_addr_var)(1);      
    
  end process data_read_process;
  
  
  
end architecture rtl;