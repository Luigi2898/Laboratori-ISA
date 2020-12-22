library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ALU_CTRL is
  port (
    EN_IN    : in  std_logic;
    CTRL_IN  : in  std_logic;
    FUNC_IN  : in  std_logic_vector(2 downto 0);
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

  signal SEL  : std_logic_vector(3 downto 0);

begin

  SEL <= (CTRL_IN and EN_IN) & FUNC_IN;

  with SEL select CODE_OUT <= SUM_OP when "0000",
                              SHR_OP when "0101",
                              LT_OP  when "0010",
                              EQ_OP  when "1000",
                              AND_OP when "0111",
                              XOR_OP when "0100",
                              SUM_OP when others;

end architecture;
