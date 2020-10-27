library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
------------------------------------------------------------------------
entity myfir_dp_unfolded is
	port(
	CLK: in std_logic;
	RST_N: in std_logic;
	DIN: in signed(10 downto 0);
	LOAD_BUFF : in std_logic;
	LOAD_STATE : in std_logic;
	BUFF_ON : in std_logic;
	LOAD_OUT : in std_logic;
	LOAD_RES : in std_logic;
	TC_ACK_IN : in std_logic;
	EN_CNT_MUX : in std_logic;
	EN_CNT_IN : in std_logic;
	H0: in signed(10 downto 0);
	H1: in signed(10 downto 0);
	H2: in signed(10 downto 0);
	H3: in signed(10 downto 0);
	H4: in signed(10 downto 0);
	H5: in signed(10 downto 0);
	H6: in signed(10 downto 0);
	H7: in signed(10 downto 0);
	H8: in signed(10 downto 0);
	STATE0_DEBUG,STATE1_DEBUG,STATE2_DEBUG : out signed (10 downto 0); -- DEBUG SIGNALS
	TC_CNT_IN : out std_logic;
	TC_CNT_MUX : out std_logic;
	DOUT: out signed(10 downto 0)
		);
end entity myfir_dp_unfolded;
------------------------------------------------------------------------
architecture beh of myfir_dp_unfolded is
------------------------------------------------------------------------
component REG is
	port(REG_IN : in signed(10 downto 0);
		 REG_OUT : out signed(10 downto 0);
		 CLK, RST_N, LOAD : in std_logic
	);
end	component;

component mux3x11to1x11 is
	port(
	in_mux0,in_mux1,in_mux2 : in signed (10 downto 0);
	out_mux : out signed (10 downto 0);
	sel_mux : unsigned (1 downto 0)
	);
end component;

component N_COUNTER is
	generic (
		N      : integer := 6;
		MODULE : integer := 42);
	port (
		CLK     : in STD_LOGIC;
		EN      : in STD_LOGIC;
		RST_N     : in STD_LOGIC;
		RST0_RST1N : in std_logic;
		CNT_END : out STD_LOGIC;
		CNT_OUT : buffer UNSIGNED(N - 1 downto 0)
	);
end component;

component cnt_mod is
    generic (
        N : positive := 2;
        MODULE : integer := 3
        );
    port (
        clk : in std_logic;
        rstn : in std_logic;
        en_cnt : in std_logic;
        tc_ack : in std_logic;
        tc : out std_logic;
        cnt_out : out unsigned (N-1 downto 0)
        );
end component cnt_mod;

------------------------------------------------------------------------
type vector is array (8 downto 0) of signed(10 downto 0);
type state_vector_type is array (10 downto 0) of signed(10 downto 0);
type out_vect_type is array (2 downto 0) of signed(10 downto 0);
type tmp_vect_type is array (2 downto 0) of signed(21 downto 0);
signal coeff : vector;
signal state_vector : state_vector_type;
signal out_vect,out_mux_in : out_vect_type; 
signal out_cnt_mux,cnt_out : unsigned (1 downto 0);
--signal reg_out : vector2;
signal ff_out: signed(7 downto 0);  
signal reg_out0,out_mux_out,input_buff_out1,input_buff_out2 : signed(10 downto 0);
signal var : signed(21 downto 0);
signal load_state0,load_state1,load_state2 : std_logic;
signal vdd : std_logic;
signal gnd : std_logic;
------------------------------------------------------------------------
begin

vdd <= '1';
gnd <= '0';

coeff(0) <=  H0;
coeff(1) <=  H1;
coeff(2) <=  H2;
coeff(3) <=  H3;
coeff(4) <=  H4;
coeff(5) <=  H5;
coeff(6) <=  H6;
coeff(7) <=  H7;
coeff(8) <=  H8;

STATE0_DEBUG <= state_vector(2);
STATE1_DEBUG <= state_vector(1);
STATE2_DEBUG <= state_vector(0);

state_vect0_gen : for i in 0 to 2 generate 
	    state_0_in : if (i = 0) generate 
		        state_0 : reg port map(input_buff_out2, state_vector(3*i+2), clk, rst_N, load_state0);
				end generate state_0_in;
		state_0 : if(i > 0) generate		
	           state_0 : reg port map(state_vector(3*i-1), state_vector(3*i+2), clk, rst_n, load_state0);
			   end generate;			   
        end generate state_vect0_gen;
		
state_vect1_gen : for i in 0 to 3 generate 
	    state_1_in : if (i = 0) generate 
		        state_1 : reg port map(input_buff_out2, state_vector(3*i+1), clk, rst_N, load_state1);
				end generate state_1_in;
		state_1 : if(i > 0) generate		
	           state_1 : reg port map(state_vector(3*i-2), state_vector(3*i+1), clk, rst_n, load_state1);
			   end generate;			   
		end generate state_vect1_gen;		

state_vect2_gen : for i in 0 to 3 generate 
	    state_2_in : if (i = 0) generate 
		        state_2 : reg port map(input_buff_out2, state_vector(3*i), clk, rst_N, load_state2);
				end generate state_2_in;
		state_2 : if(i > 0) generate		
	           state_2 : reg port map(state_vector(3*i-3), state_vector(3*i), clk, rst_n, load_state2);
			   end generate;			   
		end generate state_vect2_gen;	
		


--------------- PIPE STARTS HERE ---------------
result_reg_gen : for i in 0 to 2 generate 
		result_reg : reg port map(out_vect(i), out_mux_in(i), clk, rst_n, load_res);
	end generate result_reg_gen;		
--------------- PIPE  ENDS  HERE ---------------
	

input_buffer1 : reg port map (DIN,input_buff_out1,clk,rst_n,BUFF_ON);

input_buffer2 : reg port map (input_buff_out1,input_buff_out2,clk,rst_n,LOAD_BUFF);

cnt_in : cnt_mod generic map (2,3) port map (clk,rst_n,EN_CNT_IN,TC_ACK_IN,TC_CNT_IN,cnt_out);

output_buffer : reg port map (out_mux_out,DOUT,clk,rst_N,load_out);

out_mux : mux3x11to1x11 port map (out_mux_in(0),out_mux_in(1),out_mux_in(2),out_mux_out,out_cnt_mux);

mux_cnt : N_counter generic map (2,3) port map (clk,en_cnt_mux,rst_n,vdd,tc_cnt_mux,out_cnt_mux);

cnt_decode_process : process (cnt_out,LOAD_STATE)
begin
	case cnt_out is
		when "01" =>	load_state0 <= '1' and LOAD_STATE;
						load_state1 <= '0' and LOAD_STATE;
						load_state2 <= '0' and LOAD_STATE;

		when "10" =>	load_state0 <= '0' and LOAD_STATE;
						load_state1 <= '1' and LOAD_STATE;
						load_state2 <= '0' and LOAD_STATE;

		when "11" =>	load_state0 <= '0' and LOAD_STATE;
						load_state1 <= '0' and LOAD_STATE;
						load_state2 <= '1' and LOAD_STATE;
						
		when others =>	load_state0 <= '0' and LOAD_STATE;
						load_state1 <= '0' and LOAD_STATE;
						load_state2 <= '0' and LOAD_STATE;	

	end case;
end process;
				

evaluation_process : process (state_vector, coeff)
variable tmp : out_vect_type;
variable tmp_mult : signed (21 downto 0);
begin
tmp(0) := (others => '0');
tmp(1) := (others => '0');
tmp(2) := (others => '0');
tmp_mult := (others => '0');
	for i in 0 to 2 loop
		for j in 0 to 8 loop
			tmp_mult := (coeff(j)*state_vector(i+j));
			tmp(i) := tmp(i) + tmp_mult(20 downto 10);
		end loop;
	end loop;
out_vect(2) <= tmp(0);
out_vect(1) <= tmp(1);
out_vect(0) <= tmp(2);
end process evaluation_process;

------------------------------------------------------------------------
end architecture;