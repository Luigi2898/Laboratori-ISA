library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity PIPE_EX_MEM is 
  port(
    CLK           : in  std_logic;
    RSTN          : in  std_logic;
    ALU_RES_IN    : in  std_logic_vector(31 downto 0);
    RS2_VAL_IN    : in  std_logic_vector(31 downto 0); --from mux
    OP_WB_MEM_IN  : in  std_logic_vector(3 downto 0); --MEM/WB ctrls (WB_RFEN_OUT & WB_RFMUX_OUT & M_RD_OUT & M_WR_OUT)
    RD_ADDR_IN    : in  std_logic_vector(4 downto 0);
    ------------------------------------------------------------------ out
    ALU_RES_OUT   : out std_logic_vector(31 downto 0);
    RS2_VAL_OUT   : out std_logic_vector(31 downto 0);
    OP_WB_MEM_OUT : out std_logic_vector(3 downto 0);
    RD_ADDR_OUT   : out std_logic_vector(4 downto 0)
  );
end entity PIPE_EX_MEM;


architecture beh of PIPE_EX_MEM is

signal  ALU_RES   :  std_logic_vector(31 downto 0);
signal  RS2_VAL   :  std_logic_vector(31 downto 0);
signal  OP_WB_MEM :  std_logic_vector(3 downto 0);
signal  RD_ADDR   :  std_logic_vector(4 downto 0);    

begin

pipe_id_exe_process : process(CLK, RSTN)
begin
    if(RSTN = '0') then
      
        ALU_RES   <= (others => '0');
        RS2_VAL   <= (others => '0');
        RD_ADDR   <= (others => '0');
        OP_WB_MEM <= (others => '0');
    
    elsif (CLK'event and CLK = '1') then
      
        ALU_RES   <=   ALU_RES_IN;
        RS2_VAL   <=   RS2_VAL_IN;
        RD_ADDR   <=   RD_ADDR_IN;
        OP_WB_MEM <=   OP_WB_MEM_IN; 

    end if;

end process; --pipe_id_exe_process   

ALU_RES_OUT   <= ALU_RES;
RS2_VAL_OUT   <= RS2_VAL;
RD_ADDR_OUT   <= RD_ADDR;
OP_WB_MEM_OUT <= OP_WB_MEM;

end architecture beh;