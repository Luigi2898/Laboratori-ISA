library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity REG_FILE is
  generic (Nbit : integer := 32;
           Nrow : integer := 32);
  port (
    CLK      : in std_logic;
    RSTN     : in std_logic;

    RD1_ADDR : in unsigned (Nbit-1 downto 0);
    RD1_DOUT : out signed (Nbit-1 downto 0);
    --RD1_EN   : in std_logic;

    RD2_ADDR : in unsigned (Nbit-1 downto 0);
    RD2_DOUT : out signed (Nbit-1 downto 0);
    --RD2_EN   : in std_logic;
    
    WR1_ADDR : in unsigned (Nbit-1 downto 0);
    WR1_DIN  : in signed (Nbit-1 downto 0);
    WR1_EN   : in std_logic
  );
end entity REG_FILE;

architecture beh of REG_FILE is
  type mem_type is array (0 to Nrow-1) of signed (Nbit-1 downto 0);
  signal MEM : mem_type;

begin

  regfile_mem_process : process (CLK,RSTN,RD1_ADDR,RD2_ADDR)
    variable mem_content : mem_type;
    variable rd1_dout_tmp : signed (Nbit-1 downto 0);
    variable rd2_dout_tmp : signed (Nbit-1 downto 0);

  begin

    if RSTN = '0' then
      mem_content := (others => (others => '0'));

    elsif CLK'event and CLK = '1' then

      if WR1_EN = '1' then
        mem_content(to_integer(WR1_ADDR)) := WR1_DIN;
      end if;

    end if;

    rd1_dout_tmp := MEM(to_integer(RD1_ADDR));
    rd2_dout_tmp := MEM(to_integer(RD2_ADDR)); 

    MEM <= mem_content;
    RD1_DOUT <= rd1_dout_tmp;
    RD2_DOUT <= rd2_dout_tmp;  

  end process regfile_mem_process;

end architecture beh;