library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity PIPE_IF_ID is 
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
end entity PIPE_IF_ID;


architecture beh of PIPE_IF_ID is

signal IF_WORD_IN, PC_ADDR_IN : std_logic_vector(word_size-1 downto 0); 
constant NOP                  : std_logic_vector(word_size-1 downto 0) := "00000000000000000000000000010011";
constant NOP_PC               : std_logic_vector(word_size-1 downto 0) := "00000000000000000000000000000000";
constant RST_PC               : std_logic_vector(word_size-1 downto 0) := "11111111111111111111111111111100";   
    
begin

pipe_if_id_process : process(CLK, RST)
begin
    if(RST = '0') then

        IF_WORD_IN <= NOP;
        PC_ADDR_IN <= RST_PC;
    
    elsif (CLK'event and CLK = '1') then
      
        if(FLUSH = '1') then --flush
          
          IF_WORD_IN <= NOP;
          PC_ADDR_IN <= NOP_PC;
        
        elsif(FLUSH = '0' and STALL = '1') then --stall
          
          NULL;
        
        elsif(FLUSH = '0' and STALL = '0') --normal exe  

          IF_WORD_IN <= INSTR_IF_IN;
          PC_ADDR_IN <= INSTR_PC_ADDR_IN;
        
        end if;

    end if;

end process; --pipe_if_id_process   

INSTR_IF_OUT <= IF_WORD_IN;
INSTR_PC_ADDR_OUT <= PC_ADDR_IN;

end architecture beh;