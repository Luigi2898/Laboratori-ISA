library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity N_COUNTER is
	generic (
		N      : integer := 6;
		MODULE : integer := 42);
	port (
		CLK     : in STD_LOGIC;
		EN      : in STD_LOGIC;
		RST     : in STD_LOGIC;
		CNT_END : out STD_LOGIC;
		CNT_OUT : buffer UNSIGNED(N - 1 downto 0)
	);
end entity;

architecture BEHAVIORAL of N_COUNTER is

begin

	CNT : process (CLK)
		variable CNT_OUTv : integer := 0;
	begin

		if (CLK'EVENT and CLK = '1') then
			if (RST = '0') then
				CNT_END  <= '0';
				CNT_OUTv <= (others => '0');
			elsif (EN = '1') then
				CNT_END  <= '0';
				CNT_OUTv <= to_integer(CNT_OUT) + 1;
			end if;
			if (CNT_OUTv = TO_UNSIGNED(MODULE - 2, N) and EN = '1') then
				CNT_END <= '1';
			elsif (CNT_OUTv = TO_UNSIGNED(MODULE - 1, N) and EN = '1') then
				CNT_OUTv <= (others => '0');
			end if;
			CNT_OUT <= to_unsigned(CNT_OUTv, N);
		end if;
	end process;

end architecture;