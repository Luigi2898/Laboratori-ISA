LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity mux3x11to1x11 is
	port(
	in_mux0,in_mux1,in_mux2 : in signed (10 downto 0);
	out_mux : out signed (10 downto 0);
	sel_mux : in unsigned (1 downto 0)
	);
end entity mux3x11to1x11;

architecture beh of mux3x11to1x11 is
begin

muxing_process : process (in_mux0,in_mux1,in_mux2,sel_mux)
begin
case sel_mux is
   when "00" =>
     out_mux <= in_mux0;
   when "01" =>
     out_mux <= in_mux1;
   when "10" =>
	 out_mux <= in_mux2;
   when others =>
     out_mux <= "UUUUUUUUUUU";
end case;
end process muxing_process;

end architecture beh;