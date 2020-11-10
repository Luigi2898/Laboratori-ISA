library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity N_COUNTER is
	generic (
		N      : integer := 6;
		MODULE : integer := 42);
	port (
		CLK        : in std_logic;
		EN         : in std_logic;
		RST_N      : in std_logic;
		RST0_RST1N : in std_logic;
		CNT_END    : out std_logic;
		CNT_OUT    : buffer UNSIGNED(N - 1 downto 0)
	);
end entity;

architecture BEHAVIORAL of N_COUNTER is

begin

	CNT : process (CLK)
		variable CNT_OUTv : integer;
	begin

		if (CLK'EVENT and CLK = '1') then
			if (RST_N = '0') then
				CNT_END <= '0';
				CNT_OUTv := 0;
			elsif (EN = '1') then
				--CNT_END <= '0';
				CNT_OUTv := to_integer(CNT_OUT) + 1;
				if (CNT_OUTv = MODULE) then
					if (RST0_RST1N = '1') then
						CNT_OUTv := 0;
						CNT_END <= '0';
					else
						CNT_OUTv := 1;
						CNT_END <= '0';
					end if;
				elsif (CNT_OUTv = MODULE - 1) then
					CNT_END <= '1';
				end if;
				--end if;
			else
				CNT_OUTv := to_integer(CNT_OUT);
			end if;
		end if;
		CNT_OUT <= to_unsigned(CNT_OUTv, N);
	end process;

end architecture;