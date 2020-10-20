library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_modulo_n is
generic (n: positive:=4;
         f: unsigned:="1111");
			
port ( enable: in std_logic;
				 clock_50 : in std_logic;
				 reset_0: in std_logic;
				 reset_1: in std_logic;
				 tc: out std_logic;
				 cnt: buffer unsigned (n-1 downto 0));
end entity;

architecture behavior of counter_modulo_n is

begin

counting: process(clock_50,reset_0,reset_1)
variable content : unsigned (n-1 downto 0);
variable terminal_cnt : std_logic;

begin 

if (reset_0 = '0') then
	content := (others=>'0');
	terminal_cnt := '0';
elsif (reset_1 = '1') then
	content := to_unsigned(1,n);
	terminal_cnt := '0';
elsif (clock_50'event and clock_50 ='1') then
  	if enable = '1' then
		if (content + 1 = (to_integer(f+1))) then
			content := to_unsigned(1,n);
		else
			content := content + 1;			
   		end if;
	else
		content := content;
	end if;
end if;

if content = f then
	terminal_cnt := '1';
else 
	terminal_cnt := '0';
end if;


cnt <= content;
tc <= terminal_cnt;

end process;


end architecture;