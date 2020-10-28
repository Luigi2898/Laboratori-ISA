library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_cuoutputs_unfolded is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    start : in std_logic;
    tc_cnt_mux : in std_logic;
    en_cnt_mux : out std_logic;
    load_out : inout std_logic;
    vout : out std_logic    
  ) ;
end entity myfir_cuoutputs_unfolded;

architecture beh of myfir_cuoutputs_unfolded is

    component FF is
        port (
            FF_IN          : in STD_LOGIC;
            FF_OUT         : out STD_LOGIC;
            CLK, RST, LOAD : in STD_LOGIC
        );
    end component;

    type state_type is (rst,idle,counting);
    signal state : state_type;
    signal ff_en : std_logic;

begin

    state_transition_process : process(clk,rst_n)
    begin
      if (rst_n = '0') then
        state <= rst;
      elsif (clk'event and clk = '1') then
        case state is
          when rst =>       state <= idle;

          when idle =>      if (start = '1') then
                              state <= counting;
                            else
                              state <= idle;    
                            end if;

          when counting =>     if (tc_cnt_mux = '1') then
                                  if (start = '1') then
                                    state <= counting;
                                  else
                                    state <= idle;    
                                  end if; 
                                else
                                    state <= counting;
                                end if;
        end case;
      end if;
    end process;

    output_evaluation_process: process(state)
    begin

    en_cnt_mux <= '0';
    load_out <= '0';
    ff_en <= '1';

      case state is
        when rst =>       

        when idle =>      

        when counting =>     en_cnt_mux <= '1';
                             load_out <= '1';
                             ff_en <= '1';

      end case;

    end process output_evaluation_process;


    delay_reg : FF port map (load_out,vout,clk,rst_n,ff_en);

end architecture beh  ;