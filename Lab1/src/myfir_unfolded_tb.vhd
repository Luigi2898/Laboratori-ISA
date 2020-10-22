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
    H8 <= to_signed(7, 11);


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

    DUT : myfir_unfolded port map (clk,rst_n,DIN,VIN,H0,H1,H2,
                                    H3,H4,H5,H6,H7,H8,DOUT,VOUT);

end architecture beh;