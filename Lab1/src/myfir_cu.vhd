library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity myfir_cu is
	port (
		CLK       : in std_logic;
		RST_N     : in std_logic;
		RST_N_FIR : out std_logic;
		VIN       : in std_logic;
		LOAD      : out std_logic;
		VOUT      : out std_logic;
		TC        : in std_logic;
		CNT_EN    : out std_logic
	);
end entity;
architecture beh of myfir_cu is

	type STATE_TYPE is (RST_S, IDLE, COUNT, DATA_VALID, WAIT_VIN);
	signal STATE : STATE_TYPE;

	component FF is
		port (
			FF_IN          : in STD_LOGIC;
			FF_OUT         : out STD_LOGIC;
			CLK, RST, LOAD : in STD_LOGIC
		);
	end component;

	signal vout_d : std_logic;

	signal d1 : std_logic := '1';

begin
	FSM_PROCESS : process (CLK, RST_N)
	begin
		if (RST_N = '0') then
			STATE <= RST_S;
		elsif (CLK'EVENT and CLK = '1') then
			case STATE is
				when RST_S => STATE <= IDLE;
				when IDLE  => if (VIN = '1') then
					STATE <= COUNT;
				else
					STATE <= IDLE;
			end if;
			when COUNT => if (VIN = '1') then
			if (TC = '1') then
				STATE <= DATA_VALID;
			else
				STATE <= COUNT;
			end if;
		else
			STATE <= IDLE;
		end if;
		when DATA_VALID => if (VIN = '1') then
		STATE <= DATA_VALID;
	else
		STATE <= WAIT_VIN;
	end if;
	when WAIT_VIN => if (VIN = '0') then
	STATE <= WAIT_VIN;
else
	STATE <= DATA_VALID;
end if;
when others => STATE <= RST_S;
end case;
end if;
end process;

OUTPUT_P : process (STATE)
begin
	CNT_EN    <= '0';
	RST_N_FIR <= '1';
	LOAD      <= '0';
	VOUT_d    <= '0';
	case STATE is
		when RST_S =>
			RST_N_FIR <= '0';
		when IDLE =>
			CNT_EN <= '0';
		when COUNT =>
			CNT_EN <= '1';
			LOAD   <= '1';
		when DATA_VALID =>
			VOUT_d <= '1';
			LOAD   <= '1';
		when WAIT_VIN =>
	end case;
end process;

FlipFlop : FF port map(vout_d, vout, clk, d1, d1);

end;