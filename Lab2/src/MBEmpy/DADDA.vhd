library ieee ;
library ieee_proposed;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use ieee_proposed.array_std.all;


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

  component signExtender is
    generic(N : integer := 32);
    port (
      PP      : in  PP_array;
      PP_sign : in  std_logic_vector (N / 2 downto 0);
      PP_ext  : out PP_array_ext
    ) ;
  end component signExtender ; 
  
  signal PP_in : PP_array_ext;

begin

  SE : signExtender generic map (N)
                    port map (PP, PP_sign, PP_in);

end architecture ;