library ieee ;
library ieee_proposed;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use ieee_proposed.array_std.all;

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

  first_LSB_half_adder : HA port map(PP(0)(0), PP_sign(0), PP_ext(0)(0), PP_ext(1)(1));
  PP_ext(0)(N + 3 downto 1) <= not(PP_sign(0)) & PP_sign(0) & PP_sign(0) & PP(0)(N downto 1);

  sign_extender : for i in 1 to N_pp_array - 3 generate

    LSB_half_adder : HA port map(PP(i)(0), PP_sign(i), PP_ext(i)(0), PP_ext(i + 1)(1));
    PP_ext(i)(N + 2) <= '1';
    PP_ext(i)(N + 1) <= PP_sign(i);
    PP_ext(i)(N downto 1) <= PP(i)(N downto 1);
  
  end generate ; -- sign_extender
  
  almost_last_LSB_half_adder : HA port map(PP(N_PP_array - 2)(0), PP_sign(N_PP_array - 2), PP_ext(N_PP_array - 2)(0), PP_ext(N_PP_array - 2)(1));
  PP_ext(N_PP_array - 2)(N + 2) <= '0';
  PP_ext(N_PP_array - 2)(N + 1) <= PP_sign(N_PP_array - 2);
  PP_ext(N_PP_array - 2)(N downto 1) <= PP(N_PP_array - 2)(N downto 1);

  last_LSB_half_adder : HA port map(PP(N_PP_array - 1)(0), PP_sign(N_PP_array - 1), PP_ext(N_PP_array - 1)(0), open);
  PP_ext(N_PP_array - 1)(N + 2) <= '0';
  PP_ext(N_PP_array - 1)(N + 1) <= '0';
  PP_ext(N_PP_array - 1)(N downto 1) <= PP(N_PP_array - 2)(N downto 1);

end architecture ;