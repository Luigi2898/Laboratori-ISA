library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ALU is
  port (
    DATA1_IN   : in  std_logic_vector(31 downto 0);
    DATA2_IN   : in  std_logic_vector(31 downto 0);
    OPCODE_IN  : in  std_logic_vector(5 downto 0);
    RESULT_OUT : out std_logic_vector(31 downto 0)
  );
end entity;

architecture arch of ALU is

  constant SUM_OP : std_logic_vector(5 downto 0) := "000000";
  constant SHR_OP : std_logic_vector(5 downto 0) := "000010";
  constant LT_OP  : std_logic_vector(5 downto 0) := "000101"; -- MANCANO QUESTA
  constant EQ_OP  : std_logic_vector(5 downto 0) := "001001"; -- E QUESTA
  constant AND_OP : std_logic_vector(5 downto 0) := "010000";
  constant XOR_OP : std_logic_vector(5 downto 0) := "100000";

begin

  with OPCODE_IN select RESULT_OUT <= std_logic_vector(signed(DATA1_IN) + signed(DATA2_IN))                                                                    when SUM_OP,
                                      ((to_integer(unsigned(DATA2_IN)) - 1) downto 0 => DATA1_IN(31)) & DATA1_IN(31 downto to_integer(unsigned(DATA2_IN)) - 1) when SHR_OP,
                                      DATA1_IN and DATA2_IN                                                                                                    when AND_OP,
                                      DATA1_IN xor DATA2_IN                                                                                                    when XOR_OP,
                                      (others => '0')                                                                                                          when others;

end architecture;
