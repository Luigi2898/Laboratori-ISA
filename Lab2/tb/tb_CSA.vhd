
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity TB_CSA is
end entity TB_CSA;

architecture BEH of TB_CSA is

component CSA 
  generic (N : integer := 32);
  port (
      IN0 : in unsigned (N-1 downto 0);
      IN1 : in unsigned (N-1 downto 0);
      IN2 : in unsigned (N-1 downto 0); 
      S : out unsigned (N-1 downto 0);
      C : out unsigned (N-1 downto 0)
  );
end component CSA;

signal din0,din1,din2,dout_S,dout_C : unsigned (31 downto 0);
signal clk : std_logic;

begin

CLK_PROCESS : process
begin

  clk <= '0';
  wait for 5 ns;
  clk <= '1';
  wait for 5 ns;

end process CLK_PROCESS;


DATA_GEN_PROCESS : process

  file     inFile : text is in "C:\Users\Francesco\Desktop\POLITO\V_ANNO\Integrated_System_Architecture\Lab2\CSA_test\matlab\CSA_inputs.txt";
  variable l      : line;
  variable n      : std_logic_vector(95 downto 0);
  variable cnt_in : integer := 0;

begin

  while (endfile(inFile) = false) loop
          readline(inFile, l);
          read(l, n);
    din0 <= unsigned(n(95 downto 64));
    din1 <= unsigned(n(63 downto 32));
    din2 <= unsigned(n(31 downto 0));

    cnt_in := cnt_in + 1;

    wait for 10 ns;

  end loop;

  wait;

end process DATA_GEN_PROCESS;



OUTPUT_VERIFICATION_PROCESS : process (clk) is

  variable n_sim_S, n_sim_C  : unsigned (31 downto 0);
  variable n_sim : unsigned (32 downto 0);
  variable n_c     : integer;
  variable i       : integer := 0;
  variable cnt_out_S, cnt_out_C : integer := 0;
  variable cnt_err : integer := 0;
  variable end_sim : std_logic := '0';

begin

  n_sim_S := (others=>'0');
  n_sim_C := (others=>'0');

  if clk'event and clk = '0' then

  if (cnt_out_S = 100 and end_sim = '0') then
      report "SIMULATION ENDED WITH " & INTEGER'image(cnt_err) & " WRONG RESULTS."
          severity error;
    end_sim := '1';
  end if;

  
  
  n_sim := dout_S  + (dout_C & '0');

    if (end_sim = '0') then
      assert (n_sim = (din0+din1+din2))
        report "RESULT " & integer'image(cnt_out_S) & " IS WRONG"
        severity error;
      if (n_c /= n_sim) then
        cnt_err := cnt_err + 1;
      end if;
  
    end if;
  end if;

end process OUTPUT_VERIFICATION_PROCESS;

DUT : CSA
  port map (din0, din1, din2, dout_S, dout_C);

end architecture BEH;