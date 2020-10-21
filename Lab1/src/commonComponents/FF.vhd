library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity FF is
	port (
		FF_IN          : in STD_LOGIC;
		FF_OUT         : out STD_LOGIC;
		CLK, RST, LOAD : in STD_LOGIC
	);
end entity;

architecture BEH of FF is

begin
	REGPROC : process (CLK, RST)
	begin
		if (RST = '0') then
			FF_OUT <= '0';
		elsif (CLK'EVENT and CLK = '1') then
			if (LOAD = '1') then
				FF_OUT <= FF_IN;
			end if;
		end if;

	end process;

end architecture;