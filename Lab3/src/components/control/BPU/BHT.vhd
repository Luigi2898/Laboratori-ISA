library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BHT is
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
end entity BHT;

architecture rtl of BHT is

  component SIPO_SHIFT_REG is
    generic (Nbit : integer := 4);
    port(
      CLK: in std_logic;
      RSTN: in std_logic;
      SH_EN: in std_logic;
      DIN: in std_logic;
      DOUT: out std_logic_vector (Nbit-1 downto 0)
      );
  end component SIPO_SHIFT_REG;

  signal DECODED_ADDR : std_logic_vector(Size-1 downto 0);
  type memtype is array (Size-1 downto 0) of std_logic_vector(Depth-1 downto 0);
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

  branch_history_regs: for i in 0 to size -1 generate

    BHR : SIPO_SHIFT_REG port map (CLK,RSTN,DECODED_ADDR(i),DIN,MEM(i));

  end generate branch_history_regs;

  data_read_process : process(RD_ADDR,MEM)
  variable rd_addr_var : integer := 0;

    begin
      rd_addr_var := to_integer(RD_ADDR);
      DOUT <= MEM(rd_addr_var);      
    
  end process data_read_process;
 
  
  
end architecture rtl;
