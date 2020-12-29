library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity JMP_ADD is
  port (
    IMM_GEN_IN  : in std_logic_vector(31 downto 0);
    PC_IF_ID : in std_logic_vector(31 downto 0);
    JMP_ADDR    : out std_logic_vector(31 downto 0)
  );
end entity JMP_ADD;

architecture arch of JMP_ADD is

signal    

begin

  JMP_ADDR <= std_logic_vector(unsigned(PC_IF_ID) + unsigned(IMM_GEN_IN));

end architecture;
