library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity JMP_ADD is
  port (
    IMM_GEN_IN : in  std_logic_vector(31 downto 0);
    PC_IF_ID   : in  std_logic_vector(31 downto 0);
    JMP_ADDR   : out std_logic_vector(31 downto 0)
  );
end entity JMP_ADD;

architecture arch of JMP_ADD is

  signal JMP_ADDR_EXT : std_logic_vector(32 downto 0);

begin

  JMP_ADDR_EXT <= std_logic_vector(signed('0' & PC_IF_ID) + signed(IMM_GEN_IN(31) & IMM_GEN_IN));
  JMP_ADDR <= JMP_ADDR_EXT(31 downto 0);

  end architecture;
