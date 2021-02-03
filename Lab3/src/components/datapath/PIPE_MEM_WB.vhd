library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity PIPE_MEM_WB is 

  port(
    CLK                   : in  std_logic;
    RSTN                  : in  std_logic;
    RF_WRDIN_IN           : in  std_logic_vector(31 downto 0);
    OP_WB_IN              : in  std_logic_vector(1 downto 0); --WB ctrls (WB_RFEN_OUT & WB_RFMUX_OUT)
    RD_ADDR_IN            : in  std_logic_vector(4 downto 0);
    ------------------------------------------------------------------ out
    RF_WRDIN_OUT          : out  std_logic_vector(31 downto 0);
    OP_WB_OUT             : out std_logic_vector(1 downto 0);
    RD_ADDR_OUT           : out std_logic_vector(4 downto 0)
  );
end entity PIPE_MEM_WB;


architecture beh of PIPE_MEM_WB is

signal  RF_WRDIN   :  std_logic_vector(31 downto 0);
signal  OP_WB     :  std_logic_vector(1 downto 0);
signal  RD_ADDR   :  std_logic_vector(4 downto 0);    

begin

pipe_id_exe_process : process(CLK, RSTN)
begin
    if(RSTN = '0') then

        RF_WRDIN   <= (others => '0');
        RD_ADDR   <= (others => '0');
        OP_WB     <= (others => '0');
    
    elsif (CLK'event and CLK = '1') then
      
        RF_WRDIN   <=   RF_WRDIN_IN;
        RD_ADDR   <=   RD_ADDR_IN;
        OP_WB     <=   OP_WB_IN; 

    end if;

end process; --pipe_id_exe_process   

RF_WRDIN_OUT   <= RF_WRDIN;
RD_ADDR_OUT   <= RD_ADDR;
OP_WB_OUT     <= OP_WB;

end architecture beh;