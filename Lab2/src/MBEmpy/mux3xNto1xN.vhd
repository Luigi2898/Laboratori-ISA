
library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;

entity MUX3XNTO1XN is
  generic (
    N : integer := 32
  );
  port (
    IN_MUX0 : in    std_logic_vector (N downto 0);
    IN_MUX1 : in    std_logic_vector (N downto 0);
    IN_MUX2 : in    std_logic_vector (N downto 0);
    OUT_MUX : out   std_logic_vector (N downto 0);
    SEL_MUX : in    std_logic_vector (2 downto 0)
  );
end entity MUX3XNTO1XN;

architecture BEH of MUX3XNTO1XN is

begin

  MUXING_PROCESS : process (in_mux0, in_mux1, in_mux2, sel_mux) is
  begin

    case sel_mux is

      when "001" =>
        out_mux <= in_mux0;
      when "010" =>
        out_mux <= in_mux1;
      when "100" =>
        out_mux <= in_mux2;
      when others =>
        out_mux <= (others => 'U');

    end case;

  end process MUXING_PROCESS;

end architecture BEH;
