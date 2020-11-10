
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_textio.all;
  use std.textio.all;

entity TB_MYFIR_UNFOLDED is
end entity TB_MYFIR_UNFOLDED;

architecture BEH of TB_MYFIR_UNFOLDED is

  component MYFIR_UNFOLDED is
    port (
      CLK              : in    std_logic;
      RST_N            : in    std_logic;
      DIN              : in    signed (10 downto 0);
      VIN              : in    std_logic;
      H0               : in    signed(10 downto 0);
      H1               : in    signed(10 downto 0);
      H2               : in    signed(10 downto 0);
      H3               : in    signed(10 downto 0);
      H4               : in    signed(10 downto 0);
      H5               : in    signed(10 downto 0);
      H6               : in    signed(10 downto 0);
      H7               : in    signed(10 downto 0);
      H8               : in    signed(10 downto 0);
      DOUT             : out   signed (10 downto 0);
      VOUT             : out   std_logic
    );
  end component;

  signal initialized                 : std_logic := '0';
  signal vout,             vin       : std_logic;
  signal dout,             din       : signed (10 downto 0);
  signal clk,              rst_n     : std_logic;
  signal h0                          : signed (10 downto 0);
  signal h1                          : signed (10 downto 0);
  signal h2                          : signed (10 downto 0);
  signal h3                          : signed (10 downto 0);
  signal h4                          : signed (10 downto 0);
  signal h5                          : signed (10 downto 0);
  signal h6                          : signed (10 downto 0);
  signal h7                          : signed (10 downto 0);
  signal h8                          : signed (10 downto 0);
  signal cnt_ins,          cnt_outs  : unsigned (7 downto 0);
  signal start_pipe_debug, state_ver : std_logic;            -- DEBUG SIGNAL
  signal state0_debug                : signed (10 downto 0); -- DEBUG
  signal state1_debug                : signed (10 downto 0); -- DEBUG
  signal state2_debug                : signed (10 downto 0); -- DEBUG

begin

  CLK_PROCESS : process
  begin

    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;

  end process CLK_PROCESS;

  RST_PROCESS : process
  begin

    rst_n       <= '1';
    wait for 5 ns;
    rst_n       <= '0';
    wait for 10 ns;
    rst_n       <= '1';
    initialized <= '1';
    wait for 1 sec;

  end process RST_PROCESS;

  --  ^^ initialization takes 3 clock cycles ^^

  h0 <= to_signed(- 7, 11);
  h1 <= to_signed(- 14, 11);
  h2 <= to_signed(52, 11);
  h3 <= to_signed(272, 11);
  h4 <= to_signed(415, 11);
  h5 <= to_signed(272, 11);
  h6 <= to_signed(52, 11);
  h7 <= to_signed(- 14, 11);
  h8 <= to_signed(- 7, 11);

  state_ver <= '0'; -- set to 1 in order to monitor state register contents

  DATA_GEN_PROCESS : process

    file     inFile : text is in "C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\tb\tb_unfolded\tb_vhdl\matlab\input_samples_straight.txt";
    variable l      : line;
    variable n      : std_logic_vector(11 downto 0);
    variable cnt_in : integer := 0;

  begin

    wait for 30 ns;
    while (endfile(inFile) = false) loop
            readline(inFile, l);
            read(l, n);
      din <= signed(n(10 downto 0));
      vin <= n(11);

      if (vin = '1') then
        cnt_in := cnt_in + 1;
      end if;

      cnt_ins <= to_unsigned(cnt_in, 8);
      wait for 10 ns;
    end loop;
    vin       <= '0';
    wait;

  end process DATA_GEN_PROCESS;

  DATA_SINK_PROCESS : process (clk) is

    file     outfile : text is out "C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\tb\tb_unfolded\tb_vhdl\matlab\output_samples_sim_random.txt";
    variable l       : line;
    variable n       : std_logic_vector(10 downto 0);
    variable i       : integer := 0;
    variable cnt_out : integer := 0;

  begin

    if (clk'event and clk = '1' and vout = '1') then
      n       := std_logic_vector(dout);
            write(l, n);
            writeline(outfile, l);
      cnt_out := cnt_out + 1;
      cnt_outs <= to_unsigned(cnt_out, 8);
    end if;

  end process DATA_SINK_PROCESS;

  STATE_REG_VERIFICATION_PROCESS : process (start_pipe_debug) is

    file     inFile : text is in "C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\tb\tb_unfolded\tb_vhdl\matlab\input_samples_triplets.txt";
    variable l      : line;
    variable n0     : std_logic_vector(10 downto 0);
    variable n1     : std_logic_vector(10 downto 0);
    variable n2     : std_logic_vector(10 downto 0);

  begin

    if (state_ver = '1') then
      if (start_pipe_debug'event and start_pipe_debug = '1') then
        if (endfile(inFile) = false) then
                readline(inFile, l);
                read(l, n0);
          assert (std_logic_vector(state0_debug) = n0)
            report "STATE 0 CONTENT IS WRONG - SHOULD BE" & integer'image(to_integer(signed(n0))) &
            "\t INSTEAD IS " & integer'image(to_integer(state0_debug))
            severity error;

                readline(inFile, l);
                read(l, n1);
          assert (std_logic_vector(state1_debug) = n1)
            report "STATE 1 CONTENT IS WRONG \t SHOULD BE " & integer'image(to_integer(signed(n1))) &
            "\t INSTEAD IS " & integer'image(to_integer(state1_debug))
            severity error;

                readline(inFile, l);
                read(l, n2);
          assert (std_logic_vector(state2_debug) = n2)
            report "STATE 2 CONTENT IS WRONG - SHOULD BE" & integer'image(to_integer(signed(n2))) &
            "\t INSTEAD IS " & integer'image(to_integer(state2_debug))
            severity error;
        end if;
      end if;
    end if;

  end process STATE_REG_VERIFICATION_PROCESS;

  OUTPUT_VERIFICATION_PROCESS : process (clk) is

    file     inFile  : text is in "C:\Users\Francesco\Desktop\POLITO\V_ANNO\Integrated_System_Architecture\Lab1\C\myfir_unfolded\resultC_unfolded8.txt";
    variable l       : line;
    variable n_sim   : integer;
    variable n_c     : integer;
    variable i       : integer := 0;
    variable cnt_out : integer := 0;
    variable cnt_err : integer := 0;
    variable end_sim : std_logic := '0';

  begin

    if (cnt_out = 201 and end_sim = '0') then
        report "SIMULATION ENDED WITH " & INTEGER'image(cnt_err) & " WRONG RESULTS."
            severity error;
      end_sim := '1';
    end if;

    if (clk'event and clk = '1' and vout = '1') then
      n_sim   := to_integer(dout);
      cnt_out := cnt_out + 1;

      if (endfile(inFile) = false) then
            readline(inFile, l);
            read(l, n_c);
        assert (n_sim = n_c)
          report "RESULT No" & integer'image(cnt_out) & " IS WRONG:      C] " &
          integer'image(n_c) & "      SIM] " & integer'image(n_sim)
          severity error;
        if (n_c /= n_sim) then
          cnt_err := cnt_err + 1;
        end if;
      end if;
    end if;

  end process OUTPUT_VERIFICATION_PROCESS;

  DUT : MYFIR_UNFOLDED
    port map (clk, rst_n, DIN, VIN, H0, H1, H2, H3, H4, H5, H6, H7, H8, DOUT, VOUT);

end architecture BEH;
