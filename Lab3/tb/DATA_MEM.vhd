library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

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
	
	impure function initromfromfile return MEM_TYPE is
        file DATA_FILE : text open read_mode is filename;
        variable DATA_LINE : line;
        variable TEMP_BV : bit_vector(word_size - 1 downto 0);
        variable MEM_CONTENT : MEM_TYPE;
    begin
        for i in 0 to (2 ** word_size)-1 loop
            readline(data_file, data_line);
            read(data_line, temp_bv);
            MEM_CONTENT(i) := to_stdlogicvector(temp_bv);
        end loop;
        return MEM_CONTENT;
    end function;

    signal MEM : MEM_TYPE := initromfromfile;

begin


	file_proc: process(CLK)
	file FILE_TO_READ: text;
	variable FILE_LINE : line;
	variable init : boolean := true;
	variable INSTR : std_logic_vector(word_size-1 downto 0);
    begin  
		if (CLK'EVENT AND CLK = '1') then			
			if WR_EN='1' then
			   MEM(to_integer(unsigned(ADDR))) <= DATA_IN;
			end if;
			if RD_EN='1' then
			   DATA_OUT <= MEM(to_integer(unsigned(ADDR)));	
			end if;   
		end if;
	end process file_proc;
	
end architecture beh;