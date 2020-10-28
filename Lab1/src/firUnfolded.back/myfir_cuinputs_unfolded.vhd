library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_cuinputs_unfolded is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    tc_cnt_in : in std_logic;
    vin : in std_logic;
    load_buff : out std_logic;
    state_load : out std_logic;
    en_cnt_in : out std_logic;
    buff_on : out std_logic;
    tc_ack_in : out std_logic;
    load_first_res : out std_logic;
    start_pipe : out std_logic    
  ) ;
end entity myfir_cuinputs_unfolded;

architecture beh of myfir_cuinputs_unfolded is

    type state_type is (rst,idle,load_buffs,load_state,load_res,load_buff_res,
                        load_buff_state,load_buff_state_res,load_state_res);
    signal state : state_type;
    signal vdd : std_logic;

begin

    state_transition_process : process(clk,rst_n)
    begin
      if (rst_n = '0') then
        state <= rst;
      elsif (clk'event and clk = '1') then
        case state is
          when rst =>       state <= idle;

          when idle =>        if (vin = '1' and tc_cnt_in = '0') then
                                state <= load_buffs;
                              elsif (vin = '1' and tc_cnt_in = '1') then
                                state <= load_buff_res;
                              elsif (vin = '0' and tc_cnt_in = '1') then
                                state <= load_res;
                              elsif (vin = '0' and tc_cnt_in = '0') then
                                state <= idle;
                              else
                                state <= idle;
                              end if;

          when load_buffs =>  if (vin = '1' and tc_cnt_in = '0') then
                                state <= load_buff_state;
                              elsif (vin = '1' and tc_cnt_in = '1') then
                                state <= load_buff_state_res;
                              elsif (vin = '0' and tc_cnt_in = '1') then
                                state <= load_state_res;
                              elsif (vin = '0' and tc_cnt_in = '0') then
                                state <= load_state;
                              else
                                state <= load_state;
                              end if;


          when load_state =>  if (vin = '1' and tc_cnt_in = '0') then
                                state <= load_buffs;
                              elsif (vin = '1' and tc_cnt_in = '1') then
                                state <= load_buff_res;
                              elsif (vin = '0' and tc_cnt_in = '1') then
                                state <= load_res;
                              elsif (vin = '0' and tc_cnt_in = '0') then
                                state <= idle;
                              else
                                state <= idle;
                              end if; 
                              
                              
          when load_buff_state =>   if (vin = '1' and tc_cnt_in = '0') then
                                      state <= load_buff_state;
                                    elsif (vin = '1' and tc_cnt_in = '1') then
                                      state <= load_buff_state_res;
                                    elsif (vin = '0' and tc_cnt_in = '1') then
                                      state <= load_state_res;
                                    elsif (vin = '0' and tc_cnt_in = '0') then
                                      state <= load_state;
                                    else
                                      state <= load_state;
                                    end if; 

          when load_buff_state_res => if (vin = '1') then
                                        state <= load_buff_state;
                                      else
                                        state <= load_state;
                                      end if; 

          when load_state_res =>      if (vin = '1') then
                                        state <= load_buffs;
                                      else
                                        state <= idle;
                                      end if; 

          when load_buff_res =>       if (vin = '1') then
                                        state <= load_buff_state;
                                      else
                                        state <= load_state;
                                      end if; 

          when load_res =>            if (vin = '1') then
                                        state <= load_buffs;
                                      else
                                        state <= idle;
                                      end if; 
          end case;
      end if;
    end process;

    output_evaluation_process: process(state)
    begin

    load_buff <= '0';
    buff_on <= '1';
    start_pipe  <= '0';
    tc_ack_in <= '0';
    load_first_res <= '0';
    state_load <= '0';
    en_cnt_in <= '0';
  


      case state is

        when rst =>       

        when idle =>        

        when load_buffs =>  load_buff <= '1';
                            en_cnt_in <= '1';
                            
        when load_state =>  state_load <= '1';
                            
                            
        when load_buff_state =>   load_buff <= '1';
                                  en_cnt_in <= '1';
                                  state_load <= '1';

        when load_buff_state_res => load_buff <= '1';
                                    en_cnt_in <= '1';
                                    state_load <= '1';
                                    tc_ack_in <= '1';
                                    load_first_res <= '1';
                                    start_pipe <= '1';

        when load_state_res =>      state_load <= '1';
                                    tc_ack_in <= '1';
                                    load_first_res <= '1';
                                    start_pipe <= '1';

        when load_buff_res =>       load_buff <= '1';
                                    en_cnt_in <= '1';
                                    tc_ack_in <= '1';
                                    load_first_res <= '1';
                                    start_pipe <= '1';

        when load_res =>            tc_ack_in <= '1';
                                    load_first_res <= '1';
                                    start_pipe <= '1';
        end case;

    end process output_evaluation_process;

end architecture beh  ;