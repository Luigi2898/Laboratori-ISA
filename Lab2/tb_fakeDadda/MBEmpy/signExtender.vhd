library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.array_std.all;

entity signExtender is
  generic(N : integer := 32);
  port (
    PP      : in  PP_array;
    PP_sign : in  std_logic_vector (N / 2 downto 0);
    PP_ext  : out PP_array_ext
  ) ;
end signExtender ; 

architecture structural of signExtender is

  component HA is
    port(
		    A, B  : in  std_logic;
		    S, Co : out std_logic
    );
  end component HA;

begin

  PP_ext(0)(0)              <= '0';
  PP_ext(0)(N + 4 downto 1) <= not(PP_sign(0)) & PP_sign(0) & PP_sign(0) & PP(0)(N downto 0);

  sign_extender : for i in 1 to N_pp_array - 3 generate
    
    PP_ext(i)(0)              <= PP_sign(i - 1);
    PP_ext(i)(1)              <= '0';
    PP_ext(i)(N + 2 downto 2) <= PP(i)(N downto 0);
    PP_ext(i)(N + 3)          <= not(PP_sign(i));
    PP_ext(i)(N + 4)          <= '1';
    
  end generate ; -- sign_extender
  
  PP_ext(N_PP_array - 2)(0)              <= PP_sign(N_PP_array - 3);
  PP_ext(N_PP_array - 2)(1)              <= '0';
  PP_ext(N_PP_array - 2)(N + 2 downto 2) <= PP(N_PP_array - 2)(N downto 0);
  PP_ext(N_PP_array - 2)(N + 3)          <= not(PP_sign(N_PP_array - 2));
  PP_ext(N_PP_array - 2)(N + 4)          <= '0';

  PP_ext(N_PP_array - 1)(0)                  <= PP_sign(N_PP_array - 2);
  PP_ext(N_PP_array - 1)(1)                  <= '0';
  PP_ext(N_PP_array - 1)(N + 2 downto 2)     <= PP(N_PP_array - 1)(N downto 0);
  PP_ext(N_PP_array - 1)(N + 4 downto N + 3) <= "00";

end architecture ;
