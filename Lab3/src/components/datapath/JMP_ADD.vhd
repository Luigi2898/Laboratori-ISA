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

begin

  ADDITION : process( IMM_GEN_IN, PC_IF_ID )
  begin
    if to_integer(signed(IMM_GEN_IN)) < 0 then
      JMP_ADDR <= std_logic_vector(unsigned(PC_IF_ID) - to_unsigned(to_integer(unsigned(not(IMM_GEN_IN))) - 1, 32));
    else
    JMP_ADDR <= std_logic_vector(unsigned(PC_IF_ID) + unsigned(IMM_GEN_IN));
    end if ;

  end process ; -- ADDITION

  

end architecture;
