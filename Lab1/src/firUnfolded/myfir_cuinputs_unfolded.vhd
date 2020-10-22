library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_cuinputs_unfolded is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    buff_full : in std_logic;
    vin : in std_logic;
    rst_cnt_0 : out std_logic;
    rst_cnt_1 : out std_logic;    
    load_state : buffer std_logic;
    load_buff : out std_logic;
    load_res : out std_logic;
    buff_on : out std_logic;
    flush : out std_logic;
    start_out : out std_logic    
  ) ;
end entity myfir_cuinputs_unfolded;

architecture beh of myfir_cuinputs_unfolded is

    type state_type is (rst,idle,load_buffs,ready_zero,ready_one);
    signal state : state_type;
    signal vdd,load_res_in : std_logic;

begin

    state_transition_process : process(clk,rst_n)
    begin
      if (rst_n = '0') then
        state <= rst;
      elsif (clk'event and clk = '1') then
        case state is
          when rst =>       state <= idle;

          when idle =>        if (vin = '1' and buff_full  ='1') then
                                state <= ready_one;
                              elsif (vin = '0' and buff_full  ='1') then
                                state <= ready_zero;  
                              elsif (vin = '0' and buff_full  ='0') then
                                state <= idle;
                              elsif (vin = '1' and buff_full  ='0') then
                                state <= load_buffs;
                              end if;


          when load_buffs =>  if (vin = '1' and buff_full  ='1') then
                                state <= ready_one;
                              elsif (load_state = '0' and buff_full  ='1') then
                                state <= ready_zero;  
                              elsif (load_state = '0' and buff_full  ='0') then
                                state <= idle;
                              elsif (vin = '1' and buff_full  ='0') then
                                state <= load_buffs;
                              end if; 

          when ready_one =>   if vin = '1' then
                                state <= load_buffs;
                              else
                                state <= idle;
                              end if;
                          
          when ready_zero =>   if vin = '1' then
                                state <= load_buffs;
                              else
                                state <= idle;
                              end if;
        end case;
      end if;
    end process;

    output_evaluation_process: process(buff_full,state)
    begin

    load_state <= '0';
    load_buff <= '0';
    load_res <= '0';
    buff_on <= '1';
    flush  <= '0';
    start_out <= '0';
    rst_cnt_0 <= '0';
    rst_cnt_1 <= '0';
    load_state <= buff_full;


      case state is

        when rst =>       

        when idle =>        

        when load_buffs =>  load_buff <= '1';
                            

        when ready_one =>   --rst_cnt_1 <= '1';
                            load_buff <= '1';
                            load_res <= '1';
                            start_out <= '1';
                              
        when ready_zero =>  rst_cnt_0 <= '1';
        --load_buff <= '1';
                            load_res <= '1';
                            start_out <= '1';

      end case;

    end process output_evaluation_process;

end architecture beh  ;