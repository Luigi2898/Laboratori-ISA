library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity myfir_cu is
		port(CLK: in std_logic;
			 RST_N: in std_logic;
			 RST_N_FIR : out std_logic;
			 VIN: in std_logic;
			 LOAD : out std_logic;
			 VOUT: out std_logic;
			 TC : in std_logic;
			 CNT_EN : out std_logic
		);
end entity;


architecture beh of myfir_cu is

TYPE STATE_TYPE IS (RST_S, IDLE, COUNT, WAIT_S, DATA_VALID, ELABORATE, WAIT_VIN);
SIGNAL STATE : STATE_TYPE; 

begin
FSM_PROCESS : PROCESS(CLK, RST_N)
BEGIN
IF(RST_N = '0') THEN
	STATE <= RST_S;
	ELSIF(CLK'EVENT AND CLK = '1') THEN
	CASE STATE IS
		  WHEN RST_S      => STATE <= IDLE;
		  WHEN IDLE 	  => IF(VIN = '1') THEN	
								 STATE <= COUNT;
								 ELSE STATE <= IDLE;
								 END IF;
		  WHEN COUNT      => IF(VIN = '1') THEN
								 IF(TC = '1') THEN
								   STATE <= DATA_VALID;
								 ELSE STATE <= COUNT;
								 END IF;
							 ELSE STATE <= WAIT_S;
							 END IF;
		  WHEN WAIT_S     => IF(VIN = '0') THEN
								 STATE <= WAIT_S;
							 ELSIF(TC = '1') THEN 
								 STATE <= DATA_VALID;
							 ELSE STATE <= COUNT;
							 END IF;
		  WHEN DATA_VALID => IF(VIN = '1') THEN
							 STATE <= ELABORATE;
							 ELSE STATE <= WAIT_VIN;
							 END IF;
          WHEN ELABORATE  => STATE <= DATA_VALID;
		  WHEN WAIT_VIN	  => IF(VIN = '0') THEN
								 STATE <= WAIT_VIN;
							 ELSE STATE <= ELABORATE;
							 END IF;
		  WHEN OTHERS     => STATE <= RST_S;					 
		  END CASE;
END IF;
END PROCESS;	

OUTPUT_P: PROCESS(STATE) 
begin
CNT_EN <= '0';
RST_N_FIR <= '1';
LOAD <= '0';
VOUT <= '0';
	case STATE is
	when RST_S => 
		 RST_N_FIR <= '0';
	when IDLE  =>
		 CNT_EN <= '0';
	when COUNT => 	
		 CNT_EN <= '1';
		 LOAD <= '1';
	when WAIT_S =>

	when DATA_VALID =>	
	     VOUT <= '1';
	when WAIT_VIN =>
	
	when ELABORATE => 
		 LOAD <= '1';
	end case;
end process;
  
end architecture;

 
