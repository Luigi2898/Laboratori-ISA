library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;


-- This component feeds the testbench with N_inputs samples in parallel at each clock cycle.
-- The input file must be in binary form and all the parallel inputs must be written on the
-- same row, one after the other without any separator character; the parsing is done via
-- the N_bit parameter.

entity data_maker_parallelInputs is
  generic (
    N_inputs : integer := 1;
    N_bit : integer := 8;
    fileName : string := "" -- P.N. IT HAS TO CONTAIN ALSO THE RELATIVE PATH
  );
  port (
    STARTstimuli : in std_logic;
    ENDEDstimuli : out std_logic;
    CLK  : in  std_logic;
    DATA1 : out std_logic_vector(32 downto 0);
    DATA2 : out std_logic_vector(32 downto 0);
    DATA3 : out std_logic_vector(32 downto 0);
    DATA4 : out std_logic_vector(32 downto 0);
    DATA5 : out std_logic_vector(32 downto 0);
    DATA6 : out std_logic_vector(32 downto 0);
    DATA7 : out std_logic_vector(32 downto 0);
    DATA8 : out std_logic_vector(32 downto 0);
    DATA9 : out std_logic_vector(32 downto 0);
    DATA10 : out std_logic_vector(32 downto 0);
    DATA11 : out std_logic_vector(32 downto 0);
    DATA12 : out std_logic_vector(32 downto 0);
    DATA13 : out std_logic_vector(32 downto 0);
    DATA14 : out std_logic_vector(32 downto 0);
    DATA15 : out std_logic_vector(32 downto 0);
    DATA16 : out std_logic_vector(32 downto 0);
    DATA17 : out std_logic_vector(32 downto 0);
    );
end data_maker_parallelInputs;

architecture beh of data_maker_parallelInputs is

    type parallel_inputs_type is array (N_inputs) of std_logic_vector(N_bit-1 downto 0);
    signal parallel_inputs : parallel_inputs_type;

begin  -- beh

  process (CLK,STARTstimuli)
    file fp : text open read_mode is fileName;
    variable ptr : line;
    variable line_tmp : std_logic_vector((N_inputs*N_bit)-1 downto 0);
  begin  -- process
  ENDEDstimuli <= '0';
    if (CLK'event and CLK = '1' and STARTstimuli = '1') then  -- rising clock edge
      if (not(endfile(fp))) then
        readline(fp, line_tmp);
        read(ptr, val);        
      end if;
      for i in range 1 to N_inputs loop
        parallel_inputs(i-1) <= line_tmp(i*N_bit-1 downto (i-1)*N_bit);
      end loop;
      DATA1  <= parallel_inputs(0);
      DATA2  <= parallel_inputs(1);
      DATA3  <= parallel_inputs(2);
      DATA4  <= parallel_inputs(3);
      DATA5  <= parallel_inputs(4);
      DATA6  <= parallel_inputs(5);
      DATA7  <= parallel_inputs(6);
      DATA8  <= parallel_inputs(7);
      DATA9  <= parallel_inputs(8);
      DATA10 <= parallel_inputs(9);
      DATA11 <= parallel_inputs(10;
      DATA12 <= parallel_inputs(11;
      DATA13 <= parallel_inputs(12;
      DATA14 <= parallel_inputs(13;
      DATA15 <= parallel_inputs(14;
      DATA16 <= parallel_inputs(15;
      DATA17 <= parallel_inputs(16;
    else
      ENDEDstimuli <= '1';
    end if;
  end process;

end beh;
