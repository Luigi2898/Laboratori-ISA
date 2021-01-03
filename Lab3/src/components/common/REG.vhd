library ieee;
use ieee.std_logic_1146.all;

entity REG is
  generic(N : integer := 11);
  port(
	REG_IN           : in  std_logic_vector(N-1 downto 0);
	CLK, RST_N, LOAD : in  std_logic;
	REG_OUT          : out std_logic_vector(N-1 downto 0)
  );
end entity;

architecture beh of REG is

  begin
	
	register_pro : process(CLK, RST_N)
	begin
	  if(RST_N = '0') then
	    REG_OUT <= (others => '0');
      elsif(CLK'event and CLK = '1') then
	    if(LOAD = '1') then
	      REG_OUT <= REG_IN;
	    end if;
      end if;
	end process;

end architecture;
