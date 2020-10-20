library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myfir_cu_unfolded is
port(
	clk : in std_logic;
	rst_n : in std_logic;
	vin : in std_logic;
	cntinputs_out : in unsigned (1 downto 0);
	cntmux_tc : in std_logic;
	vout : out std_logic;
	dp_rst : out std_logic;
	state0_en : out std_logic;
	state0_en : out std_logic;
	state0_en : out std_logic;
	inbuff_en : out std_logic;
	outbuff_en : out std_logic;
	cntinputs_en : out std_logic;
	res_en : out std_logic;
	cntmux_en : out std_logic;
	cntmux_rst : out std_logic;
	
	)
end entity myfir_cu_unfolded;

architecture beh of myfir_cu_unfolded is

type state_type is (rst,idle,load_data0,load_data1,load_data2,store_res0,res_out00,res_out01,
					store_res1,res_out10,res_out11);
signal state : state_type;
signal vout_d : std_logic;

component ff is
	port(ff_in : in std_logic;
		 ff_out : out std_logic;
		 clk, rst, load : in std_logic	
	);
end component;

begin

state_transition_process : process (clk,rst_n,vin,cnt_out)
begin

if (rst_n = '0') then
	state <= rst;
	elsif (clk'event and clk = '1') then
		case state is
			when rst => 		state <= idle;
			
			when idle => 		if (vin = '1') then
									state <= load_data;
								else
									state <= idle;
								end if;
									
			
			when load_data0 =>	if (cntinputs_out = "11") then
								if (vin = '1') then
									state <= store_res0;
								else
									state <= store_res1;
									end if;
								else
									state <= idle;
								end if;
								
			when load_data1 =>	if (cntinputs_out = "11") then
								if (vin = '1') then
									state <= store_res0;
								else
									state <= store_res1;
									end if;
								else
									state <= idle;
								end if;
								
			when load_data2 =>	if (cntinputs_out = "11") then
								if (vin = '1') then
									state <= store_res0;
								else
									state <= store_res1;
									end if;
								else
									state <= idle;
								end if;
							
			when store_res0 =>	if (vin = '1') then
									state <= res_out00;
								else
									state <= res_out01;	
								end if;

			when store_res1 =>	if (vin = '1') then
									state <= res_out10;
								else
									state <= res_out11;	
								end if;
								
			when res_out00 =>	if (cntmux_tc = '1') then
									if (vin = '1') then	
										state <= load_data;
									else
										state <= idle;
									end if;
								elsif (vin = '1') then
									state <= res_out00;
								else
									state <= res_out01;
								end if;
								
			when res_out01 =>	if (cntmux_tc = '1') then
									if (vin = '1') then	
										state <= load_data;
									else
										state <= idle;
									end if;
								elsif (vin = '1') then
									state <= res_out00;
								else
									state <= res_out01;
								end if;
								
			when res_out10 =>	if (cntmux_tc = '1') then
									if (vin = '1') then	
										state <= load_data;
									else
										state <= idle;
									end if;
								elsif (vin = '1') then
									state <= res_out10;
								else
									state <= res_out11;
								end if;
								
			when res_out11 =>	if (cntmux_tc = '1') then
									if (vin = '1') then	
										state <= load_data;
									else
										state <= idle;
									end if;
								elsif (vin = '1') then
									state <= res_out10;
								else
									state <= res_out11;
								end if;
		end case;
	end if;
								
end process state_transition_process;

output_evaluation_process : process (state)
begin

inbuff_en <= '1';
dp_rst <= '1';
state0_en <= '0';
state0_en <= '0';
state0_en <= '0';
inbuff_en <= '0';
outbuff_en <= '0';
cntinputs_en <= '0';
cntmux_en <= '0';
vout_d <= '0';
res_en <= '0';

	case state is
		when reset =>			dp_rst <= '0';
		
		when idle =>			
		
		when load_data0 =>		state0_en <= '1';
								cntinputs_en <= '1';
								
		when load_data1 =>		state1_en <= '1';
								cntinputs_en <= '1';
		
		when load_data2 =>		state2_en <= '1';
								cntinputs_en <= '1';
								
		when store_res0 =>		res_en <= '1';
								cntmux_rst < = '1';

		when store_res1 =>		res_en <= '1';
								cntmux_rst < = '1';
		
		when res_out00 =>
		
		when res_out01 =>
		
		when res_out10 =>
		
		when res_out11 =>
								
								




end architecture beh;

	