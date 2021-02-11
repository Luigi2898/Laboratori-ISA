library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


  entity PIPE_ID_EX is 
    port(
      CLK                   : in std_logic;
      RSTN                  : in std_logic;
      FLUSH                 : in std_logic;
      STALL                 : in std_logic;
      LUI_IN                : in std_logic;
      AUIPC_MUX_OUT         : in std_logic;
      RS1_VAL_IN            : in std_logic_vector(31 downto 0);
      RS2_VAL_IN            : in std_logic_vector(31 downto 0);
      IMM_GEN_IN            : in std_logic_vector(31 downto 0);
      RS1_ADDR_IN           : in std_logic_vector(4 downto 0);
      RS2_ADDR_IN           : in std_logic_vector(4 downto 0);
      RD_ADDR_IN            : in std_logic_vector(4 downto 0);
      FUNC3_IN              : in std_logic_vector(2 downto 0);
      FUNC7_IN              : in std_logic;
      WR_RFEN_IN            : in std_logic;
      WR_RFMUX_IN           : in std_logic;
      BRANCH_COMP_IN        : in std_logic;
      M_RD_EN_IN            : in std_logic;
      M_WR_IN               : in std_logic;
      EX_ALUSRC_IN          : in std_logic;
      EX_ALUCTRL_IN         : in std_logic;
      EX_ALUEN_IN           : in std_logic;
      ------------------------------------------------------------------ out
      WR_RFEN_OUT           : out std_logic;
      WR_RFMUX_OUT          : out std_logic;
      BRANCH_COMP_OUT       : out std_logic;
      M_RD_EN_OUT           : out std_logic;
      M_WR_OUT              : out std_logic;
      EX_ALUSRC_OUT         : out std_logic;
      EX_ALUCTRL_OUT        : out std_logic;
      EX_ALUEN_OUT          : out std_logic;
      RS1_VAL_OUT           : out std_logic_vector(31 downto 0);
      RS2_VAL_OUT           : out std_logic_vector(31 downto 0);
      IMM_GEN_OUT           : out std_logic_vector(31 downto 0);
      RS1_ADDR_OUT          : out std_logic_vector(4 downto 0);
      RS2_ADDR_OUT          : out std_logic_vector(4 downto 0);
      RD_ADDR_OUT           : out std_logic_vector(4 downto 0);
      FUNC3_OUT             : out std_logic_vector(2 downto 0);
      FUNC7_OUT             : out std_logic;
      LUI_OUT               : out std_logic; 
      AUIPC_MUX_OUT_EX      : out std_logic
    );
  end entity PIPE_ID_EX;


architecture beh of PIPE_ID_EX is

signal WR_RFEN    : std_logic;
signal WR_RFMUX   : std_logic;
signal BRANCH_COMP: std_logic;
signal M_RD_EN    : std_logic;
signal M_WR       : std_logic;
signal EX_ALUSRC  : std_logic;
signal EX_ALUCTRL : std_logic;
signal EX_ALUEN   : std_logic;
signal AUIPC_INT  : std_logic;
signal RS1        : std_logic_vector(31 downto 0);
signal RS2        : std_logic_vector(31 downto 0);
signal IMM        : std_logic_vector(31 downto 0);
signal RS1_ADDR   : std_logic_vector(4 downto 0);
signal RS2_ADDR   : std_logic_vector(4  downto 0);
signal RD_ADDR    : std_logic_vector(4  downto 0);	
signal FUNC3      : std_logic_vector(2 downto 0);
signal FUNC7      : std_logic;
signal LUI        : std_logic;

begin

pipe_id_exe_process : process(CLK, RSTN)
begin
    if(RSTN = '0') then

        WR_RFEN    <= '0';        
        WR_RFMUX   <= '0';
        BRANCH_COMP<= '0';
        M_RD_EN    <= '0';
        M_WR       <= '0';
        EX_ALUSRC  <= '0';
        EX_ALUCTRL <= '0';
        EX_ALUEN   <= '0';
        LUI        <= '0';
        AUIPC_INT  <= '0';
        RS1        <= (others => '0');
        RS2        <= (others => '0');
        IMM        <= (others => '0');
        RS1_ADDR   <= (others => '0');
        RS2_ADDR   <= (others => '0');
        RD_ADDR    <= (others => '0');
        FUNC3      <= (others => '0');
        FUNC7      <= '0';
        
    
    elsif (CLK'event and CLK = '1') then
      
        if(FLUSH = '1') then --flush
          
        WR_RFEN    <= WR_RFEN_IN;        
        WR_RFMUX   <= WR_RFMUX_IN;
        BRANCH_COMP<= BRANCH_COMP_IN;
        M_RD_EN    <= M_RD_EN_IN;
        M_WR       <= M_WR_IN;
        EX_ALUSRC  <= EX_ALUSRC_IN;
        EX_ALUCTRL <= EX_ALUCTRL_IN;
        EX_ALUEN   <= EX_ALUEN_IN;
        AUIPC_INT  <= '0';
        LUI      <= '0';
        RS1      <= (others => '0');
        RS2      <= (others => '0');
        IMM      <= (others => '0');
        RS1_ADDR <= (others => '0');
        RS2_ADDR <= (others => '0');
        RD_ADDR  <= (others => '0');
        FUNC3    <= (others => '0');
        FUNC7    <= '0';
        
        elsif(FLUSH = '0' and STALL = '1') then --stall
        LUI        <= '0';
        WR_RFEN    <= '0';        
        WR_RFMUX   <= '0';
        M_RD_EN    <= '0';
        M_WR       <= '0';
        EX_ALUSRC  <= '0';
        EX_ALUCTRL <= '0';
        EX_ALUEN   <= '0';
        AUIPC_INT  <= '0';

        elsif(FLUSH = '0' and STALL = '0') then--normal exe  

        RS1        <= RS1_VAL_IN;
        RS2        <= RS2_VAL_IN;
        IMM        <= IMM_GEN_IN;
        RS1_ADDR   <= RS1_ADDR_IN;
        RS2_ADDR   <= RS2_ADDR_IN;
        RD_ADDR    <= RD_ADDR_IN;
        WR_RFEN    <= WR_RFEN_IN;        
        WR_RFMUX   <= WR_RFMUX_IN;
        BRANCH_COMP<= BRANCH_COMP_IN;
        M_RD_EN    <= M_RD_EN_IN;
        M_WR       <= M_WR_IN;
        EX_ALUSRC  <= EX_ALUSRC_IN;
        EX_ALUCTRL <= EX_ALUCTRL_IN;
        EX_ALUEN   <= EX_ALUEN_IN;
        FUNC3      <= FUNC3_IN;
        FUNC7      <= FUNC7_IN;
        LUI        <= LUI_IN;
        AUIPC_INT  <= AUIPC_MUX_OUT;

        end if;

    end if;

end process; --pipe_id_exe_process   

RS1_VAL_OUT      <= RS1; 
RS2_VAL_OUT      <= RS2;
IMM_GEN_OUT      <= IMM;
RS1_ADDR_OUT     <= RS1_ADDR;
RS2_ADDR_OUT     <= RS2_ADDR;
RD_ADDR_OUT      <= RD_ADDR;
FUNC3_OUT        <= FUNC3;
FUNC7_OUT        <= FUNC7;
WR_RFEN_OUT      <= WR_RFEN;      
WR_RFMUX_OUT     <= WR_RFMUX;
BRANCH_COMP_OUT  <= BRANCH_COMP;
M_RD_EN_OUT      <= M_RD_EN;
M_WR_OUT         <= M_WR;
EX_ALUSRC_OUT    <= EX_ALUSRC;
EX_ALUCTRL_OUT   <= EX_ALUCTRL;
EX_ALUEN_OUT     <= EX_ALUEN;
LUI_OUT          <= LUI;
AUIPC_MUX_OUT_EX <= AUIPC_INT;

end architecture beh;