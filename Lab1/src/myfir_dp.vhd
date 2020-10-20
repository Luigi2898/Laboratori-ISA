library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myfir_dp is
	port (
		RST_N    : in std_logic;            -- Control unit
		ctrl_in  : in std_logic;            -- Control unit
		ctrl_out : in std_logic;            -- Control Unit
		CNT_EN   : in std_logic;            -- Control unit
		CLK      : in std_logic;            -- External
		DIN      : in signed(10 downto 0);  -- External
		H0       : in signed(10 downto 0);  -- External
		H1       : in signed(10 downto 0);  -- External
		H2       : in signed(10 downto 0);  -- External
		H3       : in signed(10 downto 0);  -- External
		H4       : in signed(10 downto 0);  -- External
		H5       : in signed(10 downto 0);  -- External
		H6       : in signed(10 downto 0);  -- External
		H7       : in signed(10 downto 0);  -- External
		H8       : in signed(10 downto 0);  -- External
		DOUT     : out signed(10 downto 0); -- External
		TC       : out std_logic            -- Control unit
	);
end entity;

architecture beh of myfir_dp is

	component REG is
		port (
			REG_IN           : in signed(10 downto 0);
			REG_OUT          : out signed(10 downto 0);
			CLK, RST_N, LOAD : in std_logic
		);
	end component;
	component N_COUNTER is
		generic (
			N      : integer := 6;
			MODULE : integer := 42);
		port (
			CLK     : in std_logic;
			EN      : in std_logic;
			RST     : in std_logic;
			CNT_END : out std_logic;
			CNT_OUT : buffer unsigned(n - 1 downto 0)
		);
	end component;

	type registers_array is array (8 downto 0) of signed(10 downto 0); -- Array for the delay line
	type coeff_array is array (8 downto 0) of signed(10 downto 0);     -- Array for the coefficients
	type mult_array is array (8 downto 0) of signed(21 downto 0);      -- Array for the results of multiplications
	type sum_array is array (7 downto 0) of signed(11 downto 0);       -- Array for the results of additions

	signal coeff      : coeff_array;
	signal delay_line : registers_array;
	signal mult       : mult_array;
	signal sum        : sum_array;

	signal cnt_out  : unsigned(2 downto 0);
	signal buff_out : signed(10 downto 0);
	signal sum_out  : signed(10 downto 0);

	signal dumb_one : std_logic := '1';
begin

	coeff(0) <= H0;
	coeff(1) <= H1;
	coeff(2) <= H2;
	coeff(3) <= H3;
	coeff(4) <= H4;
	coeff(5) <= H5;
	coeff(6) <= H6;
	coeff(7) <= H7;
	coeff(8) <= H8;

	input_register : reg port map(reg_in => DIN, reg_out => delay_line(0), clk => clk, rst_n => rst_n, load => dumb_one); --input register, always enabled

	registers : for i in 1 to 8 generate
		i_register : reg port map(reg_in => delay_line(i - 1), reg_out => delay_line(i), clk => clk, rst_n => rst_n, load => ctrl_in);
	end generate; -- registers

	multiplier : for i in 0 to 8 generate
		mult(i) <= coeff(i) * delay_line(i);
	end generate; -- multipliers

	sum(0) <= mult(0)(21 downto 10) + mult(1)(21 downto 10);

	adder : for i in 1 to 7 generate
		sum(i) <= mult(i + 1)(21 downto 10) + sum(i - 1);
	end generate; -- adders

	sum_out <= sum(7)(10) & sum(7)(9 downto 0);

	--output_buffer   : reg port map(reg_in => sum(7)(21 downto 11), reg_out => buff_out, clk => clk, rst_n => rst_n, load => ctrl_out); --output register, enabled when an output is ready
	output_register : reg port map(reg_in => sum_out, reg_out => dout, clk => clk, rst_n => rst_n, load => ctrl_out); --output register, enabled when an output is ready

	counter : N_COUNTER generic map(N => 3, MODULE => 9)
	port map(clk => clk, en => cnt_en, rst => rst_n, cnt_end => TC, cnt_out => cnt_out);
end architecture;