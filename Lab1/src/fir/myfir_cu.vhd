library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity myfir_cu is
	port (
		CLK       : in std_logic;
		RST_N     : in std_logic;
		VIN       : in std_logic;
		LOAD      : out std_logic;
		VOUT      : out std_logic
	);
end entity;
architecture beh of myfir_cu is

	type STATE_TYPE is (RST_S, IDLE, DATA_VALID);
	signal STATE : STATE_TYPE;

begin
	FSM_PROCESS : process (CLK, RST_N)
	begin
		if (RST_N = '0') then
			STATE <= RST_S;
		elsif (CLK'EVENT and CLK = '1') then
			case STATE is
				when RST_S => STATE <= IDLE;
				when IDLE  => if (VIN = '1') then
					STATE <= DATA_VALID;
				    else
					STATE <= IDLE;
			        end if;
             	when DATA_VALID => if (VIN = '1') then
		            STATE <= DATA_VALID;
	                else
					STATE <= IDLE;
					end if;	       
	                when others => STATE <= RST_S;
            end case;
        end if;
end process;

OUTPUT_P : process (STATE)
begin
	LOAD      <= '0';
	VOUT      <= '0';
	case STATE is
		when RST_S =>
			
		when IDLE =>
		
		when DATA_VALID =>
			VOUT <= '1';
			LOAD <= '1';
	end case;
end process;

end;