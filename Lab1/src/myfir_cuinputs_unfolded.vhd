library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_cuinputs_unfolded is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    buff_full : in std_logic;
    vin : in std_logic;
    load_state : out std_logic;
    load_buff : out std_logic;
    load_res : out std_logic;
    buff_on : out std_logic;
    flush : out std_logic;
    flush_cnt : out std_logic;
    start_out : out std_logic    
  ) ;
end entity myfir_cuinputs_unfolded;

architecture beh of myfir_cuinputs_unfolded is

    type state_type is (rst,idle,load_buffs,state_update0,state_update0_flush,state_update1,load_res0,load_res1);
    signal state : state_type;

begin

    state_transition_process : process(clk,rst_n)
    begin
      if (rst_n = '0') then
        state <= rst;
      elsif (clk'event and clk = '1') then
        case state is
          when rst =>       state <= idle;

          when idle =>      if (vin = '1') then
                              state <= load_buffs;
                            else
                              if (buff_full = '1') then
                                state <= state_update0_flush;
                              else
                                state <= idle;    
                              end if;
                            end if;

          when load_buffs =>     if (buff_full = '1') then
                                  if (vin = '1') then
                                    state <= state_update1;
                                  else
                                    state <= state_update0;    
                                  end if; 
                                else
                                  if (vin = '1') then
                                    state <= load_buffs;
                                  else
                                    state <= idle;
                                  end if;  
                                end if; 

          when state_update0 => if (vin = '1') then
                                  state <= load_res1;
                                else
                                  state <= load_res0;
                                end if;

          when state_update0_flush => if (vin = '1') then
                                  state <= load_res1;
                                else
                                  state <= load_res0;
                                end if;                      
                                
          when state_update1 => if (vin = '1') then
                                  state <= load_res1;
                                else
                                  state <= load_res0;
                                end if; 

          when load_res0 => if (vin = '1') then
                                  state <= load_buffs;
                                else
                                  state <= idle;
                                end if;  
          when load_res1 => if (vin = '1') then
                                  state <= load_buffs;
                                else
                                  state <= idle;
                                end if;        
        end case;
      end if;
    end process;

    output_evaluation_process: process(state)
    begin

    load_state <= '0';
    load_buff <= '0';
    load_res <= '0';
    buff_on <= '1';
    flush  <= '0';
    flush_cnt <= '0';
    start_out <= '0';

      case state is
        when rst =>       

        when idle =>      

        when load_buffs =>     load_buff <= '1';

        when state_update0  => load_state <= '1';
                                load_buff <= '1';
                          

        when state_update0_flush => load_state <= '1';
                                    flush_cnt <= '1';
                                    load_buff <= '1';                           

                              
        when state_update1 => load_state <= '1';
                              --flush_cnt <= '1';
                              load_buff <= '1';

        when load_res0 =>     load_res <= '1';
                              start_out <= '1';

        when load_res1 =>     load_res <= '1';
                              load_buff <= '1';
                              start_out <= '1';
      end case;

    end process output_evaluation_process;

end architecture beh  ;