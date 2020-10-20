library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myfir_cu_unfolded_inputs is
port(
	clk : in std_logic;
	rst_n : in std_logic;
	vin : in std_logic;
	buff_full : in std_logic;
	buff_load : out std_logic;
	dp_rst : out std_logic;
	state_update : out std_logic;
	inbuff_en : out std_logic;
	output_start : out std_logic
	);
end entity myfir_cu_unfolded_inputs;

architecture beh of myfir_cu_unfolded_inputs is

type state_type is (rst,idle,load_buff,state_updates,load_update);
signal state : state_type;

begin

state_transition_process : process (clk,rst_n,vin)
begin

if (rst_n = '0') then
	state <= rst;
	elsif (clk'event and clk = '1') then
		case state is
			when rst => 		state <= idle;
			
			when idle => 		if (vin = '1' and buff_full = '1') then
									state <= load_update;
								elsif (vin = '0' and buff_full = '1') then
									state <= state_updates;
								elsif (vin = '0' and buff_full = '0') then
									state <= idle;
								elsif (vin = '1' and buff_full = '0') then
									state <= load_buff;			
								end if;
								
			when load_buff => 	if (vin = '1' and buff_full = '1') then
									state <= load_update;
								elsif (vin = '0' and buff_full = '1') then
									state <= state_updates;
								elsif (vin = '0' and buff_full = '0') then
									state <= idle;
								elsif (vin = '1' and buff_full = '0') then
									state <= load_buff;			
								end if;			
									
			
			when state_updates =>if (vin = '0') then
									state <= idle;
								else
									state <= load_buff;			
								end if;
								
			when load_update =>	if (vin = '0') then
									state <= idle;
								else
									state <= load_buff;			
								end if;
		end case;
	end if;
								
end process state_transition_process;

output_evaluation_process : process (state)
begin

inbuff_en <= '1';
dp_rst <= '1';
buff_load <= '0';
output_start <= '0';
state_update <= '0';

	case state is
		when rst =>			    dp_rst <= '0';
		
		when idle =>				
		
		when load_buff =>		buff_load <= '1';	
		
		when state_updates =>	state_update <= '1';
								output_start <= '1';
								
		when load_update =>		state_update <= '1';
								buff_load <= '1';
								output_start <= '1';
	end case;
end process output_evaluation_process;

end architecture beh;

	