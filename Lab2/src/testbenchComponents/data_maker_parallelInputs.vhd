library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
--use work.array_std.all;

library std;
use std.textio.all;


-- This component feeds the testbench with N_input samples in parallel at each clock cycle.
-- The input file must be in binary form and all the parallel inputs must be written on the
-- same row, one after the other without any separator character; the parsing is done via
-- the N_bit parameter.
-- P.N.] It requires the N-input and N_bit constant modification in work.array_std package
--       (handmade library definition).

entity data_maker_parallelInputs is
  generic (
    N_input : integer := 1;
    N_bit : integer := 8;
    fileName : string := "" -- P.N. IT HAS TO CONTAIN ALSO THE RELATIVE PATH
  );
  port (
    STARTstimuli : in std_logic;
    ENDEDstimuli : out std_logic;
    CLK  : in  std_logic;
    DATA1 : out std_logic_vector (32 downto 0);
DATA1 : out std_logic_vector (32 downto 0);
DATA1 : out std_logic_vector (32 downto 0);
DATA1 : out std_logic_vector (32 downto 0);
DATA1 : out std_logic_vector (32 downto 0);
DATA1 : out std_logic_vector (32 downto 0);
DATA1 : out std_logic_vector (32 downto 0);
DATA1 : out std_logic_vector (32 downto 0);

    );
end data_maker_parallelInputs;

architecture beh of data_maker_parallelInputs is

    type parallel_inputs_type is array (N_input - 1 downto 0) of std_logic_vector(N_bit-1 downto 0);
    signal parallel_inputs : parallel_inputs_type;

begin  -- beh

  process (CLK,STARTstimuli)
    file fp : text open read_mode is fileName;
    variable ptr : line;
    variable line_tmp : std_logic_vector((N_input*N_bit)-1 downto 0);
  begin  -- process
  ENDEDstimuli <= '0';
    if (CLK'event and CLK = '1' and STARTstimuli = '1') then  -- rising clock edge
      if (not(endfile(fp))) then
        readline(fp, ptr);
        read(ptr, line_tmp);        
      end if;
      for i in 1 to N_input loop
        parallel_inputs(i-1) <= line_tmp(i*N_bit-1 downto (i-1)*N_bit);
      end loop;
    else
      ENDEDstimuli <= '1';
    end if;
  end process;

end beh;
