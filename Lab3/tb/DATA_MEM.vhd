library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity DATA_MEM is
	generic( word_size     : integer := 32;
	         filename      : string := "");
    port(
        CLK			: in std_logic;
        RSTN		: in std_logic;
        DATA_IN		: in std_logic_vector(word_size-1 downto 0);
		DATA_OUT	: out std_logic_vector(word_size-1 downto 0);
		ADDR		: in std_logic_vector(word_size-1 downto 0);
        WR_EN		: in std_logic;	
        RD_EN       : in std_logic		
	);
end entity DATA_MEM;

architecture beh of DATA_MEM is
	
	type MEM_TYPE is array (0 to (2**word_size)-1) of std_logic_vector(word_size-1 downto 0);

	signal MEM: MEM_TYPE;
begin

	file_proc: process(CLK)
	file FILE_TO_READ: text;
	variable FILE_LINE : line;
	variable ADDR_VAR : integer := 0;
	variable init : boolean := true;
	variable INSTR : std_logic_vector(word_size-1 downto 0);
    begin
	if (init = true) then
		init := false;
        file_open(FILE_TO_READ,filename,READ_MODE);
        while (not endfile(FILE_TO_READ)) loop
              readline(FILE_TO_READ,FILE_LINE);
              hread(FILE_LINE,INSTR);
			  MEM(ADDR_VAR) <= INSTR;
			  ADDR_VAR := ADDR_VAR+1;
              end loop;    
		elsif (CLK'EVENT AND CLK = '1') then			
			    if WR_EN='1' then
				   MEM(to_integer(unsigned(ADDR))) <= DATA_IN;
				end if;
				if RD_EN='1' then
				   DATA_OUT <= MEM(to_integer(unsigned(ADDR)));	
				end if;   
		end if;
	end process file_proc;
	
end architecture beh;