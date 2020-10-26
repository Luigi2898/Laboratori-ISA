library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Cmult is
    generic (N : integer := 8);
    port (
        in1 : in signed(N - 1 downto 0);
        in2 : in signed(N - 1 downto 0);
        res : out signed(N - 1 downto 0)
    );
end Cmult;

architecture beh of Cmult is

    signal bothNeg  : std_logic;
    signal temp     : signed(N - 1 downto 0);
    signal multTemp : signed(2 * N - 1 downto 0);
    signal mult     : signed(2 * N - 1 downto 0);

begin
    bothNeg  <= in1(N - 1) and in2(N - 1);
    temp     <= (in1 xor (in1'range => bothNeg)) + ((10 downto 1 => '0') & bothNeg);
    multTemp <= temp * in2;
    mult     <= (multTemp xor (multTemp'range => bothNeg)) + ((10 downto 1 => '0') & bothNeg);
    res      <= mult(20 downto 10);
end architecture;