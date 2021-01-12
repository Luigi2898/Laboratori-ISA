library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity PIPE_ID_EX is 
  generic( word_size :  integer := 32 );
  port(
    CLK                   : in std_logic;
    RST                   : in std_logic;
    FLUSH                 : in std_logic;
    STALL                 : in std_logic; 
    PC_VAL_IN             : in std_logic_vector(word_size-1 downto 0);
    TARGET_ADDR_IN        : in std_logic_vector(word_size-1 downto 0); 
    RS1_VAL_IN            : in std_logic_vector(word_size-1 downto 0);
    RS2_VAL_IN            : in std_logic_vector(word_size-1 downto 0);
    IMM_GEN_IN            : in std_logic_vector(word_size-1 downto 0);
    RS1_ADDR_IN           : in std_logic_vector(4 downto 0);
    RS2_ADDR_IN           : in std_logic_vector(4 downto 0);
    RD_ADDR_IN            : in std_logic_vector(4 downto 0);
    CTRL_CU_IN            : in std_logic_vector(6 downto 0); --dalla CU al pipe_reg WB/MEM/EXE bits group (WB_RFEN_OUT & WB_RFMUX_OUT & BRANCH & M_RD_OUT & M_WR_OUT & ALUSrc & ALUCtrl)
    ------------------------------------------------------------------ out
    PC_VAL_OUT            : out std_logic_vector(word_size-1 downto 0);
    TARGET_ADDR_OUT       : out std_logic_vector(word_size-1 downto 0); 
    RS1_VAL_OUT           : out std_logic_vector(word_size-1 downto 0);
    RS2_VAL_OUT           : out std_logic_vector(word_size-1 downto 0);
    IMM_GEN_OUT           : out std_logic_vector(word_size-1 downto 0);
    RS1_ADDR_OUT          : out std_logic_vector(4 downto 0);
    RS2_ADDR_OUT          : out std_logic_vector(4 downto 0);
    RD_ADDR_OUT           : out std_logic_vector(4 downto 0);
    CTRL_CU_OUT           : out std_logic_vector(6 downto 0) 
  );
end entity PIPE_ID_EX;


architecture beh of PIPE_ID_EX is

signal RS1      : std_logic_vector(word_size-1 downto 0);
signal RS2      : std_logic_vector(word_size-1 downto 0);
signal IMM      : std_logic_vector(word_size-1 downto 0);
signal RS1_ADDR : std_logic_vector(word_size-1 downto 0);
signal RS2_ADDR : std_logic_vector(4  downto 0);
signal RD_ADDR  : std_logic_vector(4  downto 0);	
signal PC_VAL   : std_logic_vector(word_size-1 downto 0);
signal TARG_ADD : std_logic_vector(word_size-1 downto 0);
signal CTRL_WRD : std_logic_vector(6  downto 0);

begin

pipe_id_exe_process : process(CLK, RST)
begin
    if(RST = '0') then

        RS1      <= (others => '0');
        RS2      <= (others => '0');
        IMM      <= (others => '0');
        RS1_ADDR <= (others => '0');
        RS2_ADDR <= (others => '0');
        RD_ADDR  <= (others => '0');
        PC_VAL   <= (others => '0');
        TARG_ADD <= (others => '0');
        CTRL_WRD <= (others => '0');
    
    elsif (CLK'event and CLK = '1') then
      
        if(FLUSH = '1') then --flush
          
        RS1      <= (others => '0');
        RS2      <= (others => '0');
        IMM      <= (others => '0');
        RS1_ADDR <= (others => '0');
        RS2_ADDR <= (others => '0');
        RD_ADDR  <= (others => '0');
        PC_VAL   <= (others => '0');
        TARG_ADD <= (others => '0');
        CTRL_WRD <= CTRL_CU_IN;
        
        elsif(FLUSH = '0' and STALL = '1') then --stall
          
        CTRL_WRD <= (others => '0');
        
        elsif(FLUSH = '0' and STALL = '0') --normal exe  

        RS1      <= RS1_VAL;
        RS2      <= RS2_VAL;
        IMM      <= IMM_GEN_IN;
        RS1_ADDR <= RS1_ADDR_IN;
        RS2_ADDR <= RS2_ADDR_IN;
        RD_ADDR  <= RD_ADDR_IN;
        PC_VAL   <= PC_VAL_IN;
        TARG_ADD <= TARGET_ADDR_IN;
        CTRL_WRD <= CTRL_CU_IN;
        
        end if;

    end if;

end process; --pipe_id_exe_process   

PC_VAL_OUT       <= PC_VAL;
TARGET_ADDR_OUT  <= TARG_ADD;
RS1_VAL_OUT      <= RS1; 
RS2_VAL_OUT      <= RS2;
IMM_GEN_OUT      <= IMM;
RS1_ADDR_OUT     <= RS1_ADDR;
RS2_ADDR_OUT     <= RS2_ADDR;
RD_ADDR_OUT      <= RD_ADDR;
CTRL_CU_OUT      <= CTRL_WRD;


end architecture beh;