library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ALU_CTRL is
  port (
    EN_IN    : in  std_logic;
    CTRL_IN  : in  std_logic;
    FUNC_IN  : in  std_logic_vector(2 downto 0);
    AUIPC_MUX_OUT  : in std_logic;
    CODE_OUT : out std_logic_vector(5 downto 0)
  );
end entity;

architecture beh of ALU_CTRL is

  constant SUM_OP : std_logic_vector(5 downto 0) := "000000";
  constant SHR_OP : std_logic_vector(5 downto 0) := "000010";
  constant LT_OP  : std_logic_vector(5 downto 0) := "000101";
  constant EQ_OP  : std_logic_vector(5 downto 0) := "001001";
  constant AND_OP : std_logic_vector(5 downto 0) := "010000";
  constant XOR_OP : std_logic_vector(5 downto 0) := "100000";

  signal SEL  : std_logic_vector(4 downto 0);

begin

  SEL <= (CTRL_IN and EN_IN) & FUNC_IN & AUIPC_MUX_OUT;

  with SEL select CODE_OUT <= SUM_OP when "00000",
                              SHR_OP when "01010",
                              LT_OP  when "00100",
                              EQ_OP  when "10000",
                              AND_OP when "01110",
                              XOR_OP when "01000",
                              SUM_OP when "0---1",
                              SUM_OP when "10100",
                              SUM_OP when others;

end architecture;
