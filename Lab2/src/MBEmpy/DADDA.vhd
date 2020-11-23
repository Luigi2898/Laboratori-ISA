library ieee ;
library ieee_proposed;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use ieee_proposed.array_std.all;


entity DADDA is
  generic(N : integer := 32; N_PP : integer := 17);
  port (
    PP      : in  PP_array;
    PP_sign : in  std_logic_vector (N / 2 downto 0); -- Last one is 0, please give me a 0
    SUM     : out std_logic_vector (2 * N - 1 downto 0)
  ) ;
end DADDA;

architecture structural of DADDA is
  
  component CSA is
    generic (N : integer := 32);
      port (
          IN0 : in  unsigned (N-1 downto 0);
          IN1 : in  unsigned (N-1 downto 0);
          IN2 : in  unsigned (N-1 downto 0);
          S   : out unsigned (N-1 downto 0);
          C   : out unsigned (N-1 downto 0)
      );
  end component CSA;

  component HA is
    port(
		    A, B  : in  std_logic;
		    S, Co : out std_logic
    );
  end component HA;

  type extd_PP is array(N_PP downto 0) of std_logic_vector(N + 3 downto 0);
  
  signal PP_in : extd_PP;

begin

  -- SIGN EXTENSION

  first_LSB_half_adder : HA port map(PP(0)(0), PP_sign(0), PP_in(0)(0), PP_in(1)(0));
  PP_in(0)(N + 3 downto 1) <= not(PP_sign(0)) & PP_sign(0) & PP_sign(0) & PP(0)(N downto 1);

  sign_extender : for i in 1 to N_PP - 3 generate

    LSB_half_adder : HA port map(PP(i)(0), PP_sign(i), PP_in(i)(0), PP_in(i + 1)(0));
    PP_in(i)(N + 2) <= '1';
    PP_in(i)(N + 1) <= PP_sign(i);
    PP_in(i)(N downto 1) <= PP(i)(N downto 1);
  
  end generate ; -- sign_extender
  
  almost_last_LSB_half_adder : HA port map(PP(N_PP - 2)(0), PP_sign(N_PP - 2), PP_in(N_PP - 2)(0), PP_in(N_PP - 2)(0));
  PP_in(N_PP - 2)(N + 2) <= '0';
  PP_in(N_PP - 2)(N + 1) <= PP_sign(N_PP - 2);
  PP_in(N_PP - 2)(N downto 1) <= PP(N_PP - 2)(N downto 1);

  last_LSB_half_adder : HA port map(PP(N_PP - 1)(0), PP_sign(N_PP - 1), PP_in(N_PP - 1)(0), open);
  PP_in(N_PP - 1)(N + 2) <= '0';
  PP_in(N_PP - 1)(N + 1) <= '0';
  PP_in(N_PP - 1)(N downto 1) <= PP(N_PP - 2)(N downto 1);

  -- PYRAMID REPRESENTATION



end architecture ;