library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity HDU is
  generic ( word_size :  integer := 32 );
  port (
      INSTR_IF_ID_IN     : in std_logic_vector(word_size-1 downto 0);
      INSTR_ID_EX_IN     : in std_logic_vector(word_size-1 downto 0);
      ID_EX_MEMREAD_IN   : in std_logic;
      PC_EN_OUT          : out std_logic;
      IF_ID_EN_OUT       : out std_logic;
      CTRL_BUBBLE_OUT    : out std_logic
  );
end entity;

architecture HDU_ARCH of HDU is
 
signal RS1, RS2, RD : integer;
 
begin

HDU_process : process(INSTR_IF_ID_IN, INSTR_ID_EX_IN, ID_EX_MEMREAD_IN )
variable RS1_ID, RS2_ID, RD_EXE : integer; 
begin
--get source registers  
RS1_ID := to_integer(unsigned(INSTR_IF_ID_IN(19 downto 15)));
RS2_ID := to_integer(unsigned(INSTR_IF_ID_IN(24 downto 20)));
RD_EXE := to_integer(unsigned(INSTR_ID_EX_IN(11 downto 7)));
RS1<= RS1_ID;
RS2<= RS2_ID;
RD<= RD_EXE;
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
