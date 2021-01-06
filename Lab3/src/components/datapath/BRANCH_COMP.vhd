library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity BRANCH_COMP is
	generic(word_size: integer:= 32);	
	port(
	    IMM_CODE		: in std_logic_vector(2 downto 0);			    --condition to take branch
		DATA_IN1		: in std_logic_vector(word_size-1 downto 0);	--data to test
		DATA_IN2		: in std_logic_vector(word_size-1 downto 0);	--data to test
        BRANCH_IS_TAKEN	: out std_logic
    );						
end entity BRANCH_COMP;

architecture beh of BRANCH_COMP is

constant JAL  : std_logic_vector(2 downto 0) := "100";
constant BEQ  : std_logic_vector(2 downto 0) := "010";    

begin

--BRANCH IS TAKEN IF INSTR IS JAL OR (BEQ AND RS1=RS2)
BRANCH_IS_TAKEN <= AND_REDUCE(IMM_CODE XNOR JAL) OR (AND_REDUCE(IMM_CODE XNOR BEQ) AND AND_REDUCE(DATA_IN1 XNOR DATA_IN2));    


end architecture beh;