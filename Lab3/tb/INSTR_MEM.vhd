library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity instr_mem is
    generic (
        INITFILE : string := "";
        ADDR_N   : integer := 32;
        DATA_WIDTH : integer := 32;
        NEL       : integer := 12);
    port (
        INSTR_ADDR : in std_logic_vector(ADDR_N - 1 downto 0);
        INSTR      : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end entity;

architecture behavioural of instr_mem is

    type rom_type is array (0 to NEL-1) of std_logic_vector(INSTR'length - 1 downto 0);

    impure function initromfromfile return rom_type is
        file DATA_FILE : text open read_mode is initfile;
        variable DATA_LINE : line;
        variable TEMP_BV : bit_vector(INSTR'length - 1 downto 0);
        variable ROM_CONTENT : rom_type;
    begin
        for i in 0 to NEL-1 loop
            readline(data_file, data_line);
            read(data_line, temp_bv);
            ROM_CONTENT(i) := to_stdlogicvector(temp_bv);
        end loop;
        return ROM_CONTENT;
    end function;

    signal ROM : rom_type := initromfromfile;

begin

    INADD : process( INSTR_ADDR )
    begin
        if not(INSTR_ADDR = (INSTR_ADDR'length - 1 downto 0 => 'U') or INSTR_ADDR = (INSTR_ADDR'length - 1 downto 0 => 'X')) then
            INSTR <= ROM(to_integer(unsigned(INSTR_ADDR(15 downto 0))));
        end if;
    end process ; -- INADD

    
end architecture;