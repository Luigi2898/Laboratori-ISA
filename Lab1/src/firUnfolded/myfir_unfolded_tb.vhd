library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tb_myfir_unfolded is
end entity tb_myfir_unfolded;

architecture beh of tb_myfir_unfolded is

    component myfir_unfolded is
        port (
            clk : in std_logic;
            rst_n : in std_logic;
            DIN : in signed (10 downto 0);
            VIN : in std_logic;
            H0: in signed(10 downto 0);
            H1: in signed(10 downto 0);
            H2: in signed(10 downto 0);
            H3: in signed(10 downto 0);
            H4: in signed(10 downto 0);
            H5: in signed(10 downto 0);
            H6: in signed(10 downto 0);
            H7: in signed(10 downto 0);
            H8: in signed(10 downto 0);
            --STATE0_DEBUG,STATE1_DEBUG,STATE2_DEBUG : out signed (10 downto 0); -- DEBUG SIGNALS
            start_pipe_debug : out std_logic; -- DEBUG SIGNAL
            DOUT : out signed (10 downto 0);
            VOUT : out std_logic             
        );
    end component myfir_unfolded;
    
    signal initialized : std_logic := '0';
    signal vout,vin : std_logic;
    signal dout,din : signed (10 downto 0);
    signal clk, rst_n : std_logic;
    signal H0,H1,H2,H3,H4,H5,H6,H7,H8 : signed (10 downto 0);
    signal cnt_ins, cnt_outs : unsigned (7 downto 0);
    signal start_pipe_debug, state_ver : std_logic; -- DEBUG SIGNAL
    signal STATE0_DEBUG,STATE1_DEBUG,STATE2_DEBUG : signed (10 downto 0); -- DEBUG
begin

    clk_process: process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;        
    end process clk_process;
    
    rst_process: process
    begin
        rst_n <= '1';
        wait for 5 ns;
        rst_n <= '0';
        wait for 10 ns;
        rst_n <= '1';
        initialized <= '1';
        wait for 1 sec;        
    end process rst_process;

    --  ^^ initialization takes 3 clock cycles ^^

    H0 <= to_signed(-7, 11);
    H1 <= to_signed(-14, 11);
    H2 <= to_signed(52, 11);
    H3 <= to_signed(272, 11);
    H4 <= to_signed(415, 11);
    H5 <= to_signed(272, 11);
    H6 <= to_signed(52, 11);
    H7 <= to_signed(-14, 11);
    H8 <= to_signed(-7, 11);

    state_ver <= '0'; -- set to 1 in order to monitor state register contents


    data_gen_process : process

        file inFile : text is in "C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\tb\tb_unfolded\tb_vhdl\matlab\input_samples_random.txt";
        variable l : line;
        variable n : std_logic_vector (11 downto 0);
        variable cnt_in : integer := 0;

        begin
            wait for 30 ns;
            while (endfile(inFile) = false) loop
            readline(inFile, l);
            read(l,n);
            DIN <= signed(n(10 downto 0));
            VIN <= n(11);
            if VIN = '1' then
                cnt_in := cnt_in + 1;
            end if;
            cnt_ins <= to_unsigned(cnt_in,8);
            wait for 10 ns;
            end loop;
            VIN <= '0';
            wait;

    end process;

    data_sink_process : process (clk)
        file outfile : text is out "C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\tb\tb_unfolded\tb_vhdl\matlab\output_samples_sim_random.txt";
        variable l : line;
        variable n : std_logic_vector (10 downto 0) ;
        variable i : integer := 0;
        variable cnt_out : integer := 0;	
        begin
        if (clk'event and clk = '1' and VOUT = '1') then
            n := std_logic_vector(DOUT);
            write(l,n);
            writeline(outfile, l);
            cnt_out := cnt_out + 1;
            cnt_outs <= to_unsigned(cnt_out,8);
            end if;
    end process;

    state_reg_verification_process : process (start_pipe_debug)

    file inFile : text is in "C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\tb\tb_unfolded\tb_vhdl\matlab\input_samples_triplets.txt";
    variable l : line;
    variable n0 : std_logic_vector (10 downto 0);
    variable n1 : std_logic_vector (10 downto 0);
    variable n2 : std_logic_vector (10 downto 0);

    begin
    if (state_ver = '1') then    
        if (start_pipe_debug'event and start_pipe_debug = '1') then
            if (endfile(inFile) = false) then

                readline(inFile, l);
                read(l,n0);                
                assert (std_logic_vector(STATE0_DEBUG) = n0)
                    report "STATE 0 CONTENT IS WRONG - SHOULD BE" & integer'image(to_integer(signed(n0))) &
                           "\t INSTEAD IS " & integer'image(to_integer(STATE0_DEBUG)) 
                    severity error;  

                readline(inFile, l);
                read(l,n1);
                assert (std_logic_vector(STATE1_DEBUG) = n1)
                    report "STATE 1 CONTENT IS WRONG \t SHOULD BE " & integer'image(to_integer(signed(n1))) &
                           "\t INSTEAD IS " & integer'image(to_integer(STATE1_DEBUG)) 
                    severity error;  

                readline(inFile, l);
                read(l,n2);   
                assert (std_logic_vector(STATE2_DEBUG) = n2)
                    report "STATE 2 CONTENT IS WRONG - SHOULD BE" & integer'image(to_integer(signed(n2))) &
                           "\t INSTEAD IS " & integer'image(to_integer(STATE2_DEBUG)) 
                    severity error;  

            end if;
        end if;
    end if;      
    end process;

    output_verification_process : process (clk)

    file inFile : text is in "C:\Users\Francesco\Desktop\POLITO\V_ANNO\Integrated_System_Architecture\Lab1\C\myfir_unfolded\resultC_unfolded8.txt";
    variable l : line;
    variable n_sim : integer;
    variable n_C : integer;
    variable i : integer := 0;
    variable cnt_out : integer := 0;
    variable cnt_err : integer := 0;
    variable end_sim : std_logic := '0';	
    begin
    
    if (cnt_out = 201 and end_sim = '0') then
        report "SIMULATION ENDED WITH " & INTEGER'image(cnt_err) & " WRONG RESULTS."
            severity error;  
    end_sim := '1';
    end if;

    if (clk'event and clk = '1' and VOUT = '1') then

        n_sim := to_integer(DOUT);
        cnt_out := cnt_out + 1;

        if (endfile(inFile) = false) then

            readline(inFile, l);
            read(l,n_C);                
            assert (n_sim = n_C)
                report "RESULT No" & integer'image(cnt_out) & " IS WRONG:      C] " &
                 integer'image(n_C) & "      SIM] " & integer'image(n_sim) 
                severity error;  
            if (n_C /= n_sim) then
                cnt_err := cnt_err+1;
            end if;               
        end if;
    end if;      
    end process;

    DUT : myfir_unfolded port map (clk,rst_n,DIN,VIN,H0,H1,H2,
                                    H3,H4,H5,H6,H7,H8,start_pipe_debug,DOUT,VOUT);

end architecture beh;