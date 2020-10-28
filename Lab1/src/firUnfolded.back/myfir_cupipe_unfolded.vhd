library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_cupipe_unfolded is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    start_pipe : in std_logic;
    load_res : out std_logic;
    start_out : out std_logic
  ) ;
end entity myfir_cupipe_unfolded;

architecture beh of myfir_cupipe_unfolded is

    type state_type is (rst,idle,start_outs);
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

            when idle =>        if (start_pipe = '1') then
                                    state <= start_outs;
                                else
                                    state <= idle;
                                end if;

            when start_outs =>   state <= idle; 
                            
        end case;
      end if;
    end process;

    output_evaluation_process: process(state)
    begin

    load_res <= '0';
    start_out <= '0';
  
      case state is

        when rst =>       

        when idle =>        

        when start_outs =>  load_res <= '1';
                            start_out <= '1';

      end case;

    end process output_evaluation_process;

end architecture beh  ;