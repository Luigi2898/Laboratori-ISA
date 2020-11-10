library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
------------------------------------------------------------------------
entity myfir_dp_piped_unfolded_v2 is
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
	LOAD_RES2 : in std_logic;
	--STATE0_DEBUG,STATE1_DEBUG,STATE2_DEBUG : out signed (10 downto 0); -- DEBUG SIGNALS
	TC_CNT_IN : out std_logic;
	TC_CNT_MUX : out std_logic;
	DOUT: out signed(10 downto 0)
		);
end entity myfir_dp_piped_unfolded_v2;
------------------------------------------------------------------------
architecture beh of myfir_dp_piped_unfolded_v2 is
------------------------------------------------------------------------
component REG IS
GENERIC(
	N : INTEGER := 8
);
	PORT(
		REG_IN : IN signed(N-1 DOWNTO 0);
		 REG_OUT : OUT signed(N-1 DOWNTO 0);
		 CLK, RST_N, LOAD : IN STD_LOGIC
	);
END component;
component mux3xNto1xN is
	generic(
	  N : integer := 8
	);
	  port(
	  in_mux0,in_mux1,in_mux2 : in signed (N-1 downto 0);
	  out_mux : out signed (N-1 downto 0);
	  sel_mux : in unsigned (1 downto 0)
	  );
  end component mux3xNto1xN;
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
type vector is array (8 downto 0) of signed(7 downto 0);
type state_vector_type is array (10 downto 0) of signed(7 downto 0);
type out_vect_type is array (2 downto 0) of signed(7 downto 0);
type tmp_vect_type is array (2 downto 0) of signed(15 downto 0);

type tmp_vect_type_pipe_mult is array (8 downto 0) of signed(15 downto 0);
type tmp_vect_type_pipe1 is array (8 downto 0) of signed(7 downto 0);
type tmp_vect_type_pipe2 is array (4 downto 0) of signed(7 downto 0);
type tmp_vect_type_pipe3 is array (2 downto 0) of signed(7downto 0);
type tmp_vect_type_pipe4 is array (1 downto 0) of signed(7 downto 0);


signal state0_pipe1_in,state1_pipe1_in,state2_pipe1_in : tmp_vect_type_pipe1; -- pipe 1st stage reg inputs
signal state0_pipe1_out,state1_pipe1_out,state2_pipe1_out : tmp_vect_type_pipe1; -- pipe 1st stage reg outputs

signal state0_pipe2_in,state1_pipe2_in,state2_pipe2_in : tmp_vect_type_pipe2; -- pipe 1st stage reg inputs
signal state0_pipe2_out,state1_pipe2_out,state2_pipe2_out : tmp_vect_type_pipe2; -- pipe 2nd stage reg outputs

signal state0_pipe3_in,state1_pipe3_in,state2_pipe3_in : tmp_vect_type_pipe3; -- pipe 1st stage reg inputs
signal state0_pipe3_out,state1_pipe3_out,state2_pipe3_out : tmp_vect_type_pipe3; -- pipe 3rd stage reg outputs

signal state0_pipe4_in,state1_pipe4_in,state2_pipe4_in : tmp_vect_type_pipe4; -- pipe 1st stage reg inputs
signal state0_pipe4_out,state1_pipe4_out,state2_pipe4_out : tmp_vect_type_pipe4; -- pipe 4th stage reg outputs

signal coeff : vector;
signal state_vector : state_vector_type;
signal out_vect,out_mux_in : out_vect_type; 
signal out_cnt_mux,cnt_out : unsigned (1 downto 0);
--signal reg_out : vector2;
signal output_buff_in : signed(10 downto 0);  
signal reg_out0,out_mux_out,input_buff_out1,input_buff_out2,DIN8 : signed(7 downto 0);
signal var : signed(21 downto 0);
signal load_state0,load_state1,load_state2 : std_logic;
signal vdd : std_logic;
signal gnd : std_logic;
------------------------------------------------------------------------
begin

vdd <= '1';
gnd <= '0';

DIN8 <= DIN(10 downto 3);
coeff(0) <=  H0(10 downto 3);
coeff(1) <=  H1(10 downto 3);
coeff(2) <=  H2(10 downto 3);
coeff(3) <=  H3(10 downto 3);
coeff(4) <=  H4(10 downto 3);
coeff(5) <=  H5(10 downto 3);
coeff(6) <=  H6(10 downto 3);
coeff(7) <=  H7(10 downto 3);
coeff(8) <=  H8(10 downto 3);
output_buff_in <= out_mux_out & '0' & '0' & '0';
--STATE0_DEBUG <= state_vector(2);
--STATE1_DEBUG <= state_vector(1);
--STATE2_DEBUG <= state_vector(0);

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
		

input_buffer1 : reg port map (DIN8,input_buff_out1,clk,rst_n,BUFF_ON);

input_buffer2 : reg port map (input_buff_out1,input_buff_out2,clk,rst_n,LOAD_BUFF);

cnt_in : cnt_mod generic map (2,3) port map (clk,rst_n,EN_CNT_IN,TC_ACK_IN,TC_CNT_IN,cnt_out);

output_buffer : reg generic map (11) port map (output_buff_in,DOUT,clk,rst_N,load_out);

out_mux : mux3xNto1xN port map (out_mux_in(0),out_mux_in(1),out_mux_in(2),out_mux_out,out_cnt_mux);

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
-----------------------------------------------------------------------------------------
-- PIPE ARCHITECTURE --

-- 1st PIPE --
pipe1_evaluation_process : process (state_vector, coeff)
variable tmp0 : tmp_vect_type_pipe_mult;
variable tmp1 : tmp_vect_type_pipe_mult;
variable tmp2 : tmp_vect_type_pipe_mult;
begin

tmp0 := (others => (others => '0'));
tmp1 := (others => (others => '0'));
tmp2 := (others => (others => '0'));

-- partial results : multiplications --
	for i in 0 to 8 loop
		tmp0(i) := (coeff(i)*state_vector(i+2));
		state0_pipe1_in(i) <= tmp0(i)(14 downto 7);
		tmp1(i) := (coeff(i)*state_vector(i+1));
		state1_pipe1_in(i) <= tmp1(i)(14 downto 7);
		tmp2(i) := (coeff(i)*state_vector(i));
		state2_pipe1_in(i) <= tmp2(i)(14 downto 7);
	end loop;

end process pipe1_evaluation_process;


-- pipe1 state 0 reg generate -- N.B.] ENABLE WITH LOAD_RES
pipe1_state0_gen : for i in 0 to 8 generate 
    pipe1_state0 : reg port map(state0_pipe1_in(i), state0_pipe1_out(i), clk, rst_n, load_res);
end generate pipe1_state0_gen;	

-- pipe1 state 1 reg generate -- N.B.] ENABLE WITH LOAD_RES
pipe1_state1_gen : for i in 0 to 8 generate 
    pipe1_state1 : reg port map(state1_pipe1_in(i), state1_pipe1_out(i), clk, rst_n, load_res);
end generate pipe1_state1_gen;		

-- pipe1 state 2 reg generate -- N.B.] ENABLE WITH LOAD_RES
pipe1_state2_gen : for i in 0 to 8 generate 
    pipe1_state2 : reg port map(state2_pipe1_in(i), state2_pipe1_out(i), clk, rst_n, load_res);
end generate pipe1_state2_gen;		

-----------------------------------------------------------------------------------------------------
--2nd PIPE

pipe2_evaluation_process : process (state0_pipe1_out,state1_pipe1_out,state2_pipe1_out)
	variable tmp_res0, tmp_res1, tmp_res2 : signed (7 downto 0);
begin
	tmp_res0 := (others => '0');
	tmp_res1 := (others => '0');
	tmp_res2 := (others => '0');
	for i in 0 to 8 loop
		tmp_res0 := tmp_res0 + state0_pipe1_in(i);
		tmp_res1 := tmp_res1 + state1_pipe1_in(i);
		tmp_res2 := tmp_res2 + state2_pipe1_in(i);
	end loop;
	out_vect(0) <= tmp_res0;
	out_vect(1) <= tmp_res1;
	out_vect(2) <= tmp_res2;
end process;

result_reg_gen : for i in 0 to 2 generate 
    result_reg : reg port map(out_vect(i), out_mux_in(i), clk, rst_n, load_res2);
end generate result_reg_gen;		

end architecture;