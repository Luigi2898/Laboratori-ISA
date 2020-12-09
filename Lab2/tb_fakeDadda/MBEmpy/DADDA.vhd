library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.array_std.all;


entity DADDA is
  generic(N : integer := 32; N_PP : integer := 17);
  port (
    PP      : in  PP_array;
    PP_sign : in  std_logic_vector (N / 2 downto 0);
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
  
  signal PP_ext : PP_array_ext;

begin

  PP_ext(0)(N + 4 downto 1) <= not(PP_sign(0)) & PP_sign(0) & PP_sign(0) & PP(0)(N downto 0);

  sign_extender : for i in 1 to N_pp_array - 3 generate
    
    PP_ext(i)(0)              <= PP_sign(i - 1);
    PP_ext(i)(N + 2 downto 2) <= PP(i)(N downto 0);
    PP_ext(i)(N + 3)          <= not(PP_sign(i));
    PP_ext(i)(N + 4)          <= '1';
    
  end generate ; -- sign_extender
  
  PP_ext(N_PP_array - 2)(0)              <= PP_sign(N_PP_array - 3);
  PP_ext(N_PP_array - 2)(N + 2 downto 2) <= PP(N_PP_array - 2)(N downto 0);
  PP_ext(N_PP_array - 2)(N + 3)          <= not(PP_sign(N_PP_array - 2));


  PP_ext(N_PP_array - 1)(0)                  <= PP_sign(N_PP_array - 2);
  PP_ext(N_PP_array - 1)(N + 2 downto 2)     <= PP(N_PP_array - 1)(N downto 0);


end architecture ;