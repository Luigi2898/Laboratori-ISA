library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity HDU is
  generic ( word_size :  integer := 32; RF_ADDR_LEN : integer := 5 );
  port (
      INSTR_IF_ID_IN     : in std_logic_vector(word_size-1 downto 0);
      ID_EX_MEMREAD_IN   : in std_logic;
      ID_EX_RD_IN        : in std_logic_vector(RF_ADDR_LEN-1 downto 0);
      PC_EN_OUT          : out std_logic;
      IF_ID_EN_OUT       : out std_logic;
      CTRL_BUBBLE_OUT    : out std_logic
  );
end entity;

architecture HDU_ARCH of HDU is

signal IF_ID_RS1, IF_ID_RS2 : std_logic_vector(RF_ADDR_LEN-1 downto 0);
  
begin

HDU_process : process(INSTR_IF_ID_IN, ID_EX_MEMREAD_IN, ID_EX_RD_IN)
variable RS1_ID, RS2_ID, RD_EXE : integer range 0 to 2**32; 
begin
--get source registers  
RS1_ID := to_integer(unsigned(INSTR_IF_ID_IN(19 downto 15)));
RS2_ID := to_integer(unsigned(INSTR_IF_ID_IN(24 downto 20)));
RD_EXE := to_integer(unsigned(ID_EX_RD_IN));

--default assignment
PC_EN_OUT		    <= '1';
IF_ID_EN_OUT    <= '1';
CTRL_BUBBLE_OUT <= '0';

--detect load use data hazard
if (ID_EX_MEMREAD_IN = '1' and ((RS1_ID = RD_EXE) or (RS2_ID = RD_EXE))) then
  PC_EN_OUT		    <= '0';
  IF_ID_EN_OUT    <= '0';
  CTRL_BUBBLE_OUT <= '1';
  else 
  PC_EN_OUT		    <= '1';
  IF_ID_EN_OUT    <= '1';
  CTRL_BUBBLE_OUT <= '0';
end if; 

end process HDU_process;






end architecture;
