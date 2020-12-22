library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb_DADDA_stupid is
end tb_DADDA_stupid ;

architecture tb of tb_DADDA_stupid is

  component DADDA
generic (
  N    : integer := 33;
  N_PP : integer := 17
);
port (
  PP1     : in  std_logic_vector(N - 1 downto 0);
  PP2     : in  std_logic_vector(N - 1 downto 0);
  PP3     : in  std_logic_vector(N - 1 downto 0);
  PP4     : in  std_logic_vector(N - 1 downto 0);
  PP5     : in  std_logic_vector(N - 1 downto 0);
  PP6     : in  std_logic_vector(N - 1 downto 0);
  PP7     : in  std_logic_vector(N - 1 downto 0);
  PP8     : in  std_logic_vector(N - 1 downto 0);
  PP9     : in  std_logic_vector(N - 1 downto 0);
  PP10    : in  std_logic_vector(N - 1 downto 0);
  PP11    : in  std_logic_vector(N - 1 downto 0);
  PP12    : in  std_logic_vector(N - 1 downto 0);
  PP13    : in  std_logic_vector(N - 1 downto 0);
  PP14    : in  std_logic_vector(N - 1 downto 0);
  PP15    : in  std_logic_vector(N - 1 downto 0);
  PP16    : in  std_logic_vector(N - 1 downto 0);
  PP17    : in  std_logic_vector(N - 1 downto 0);
  PP_sign : in  std_logic_vector(N_PP downto 0);
  SUM     : out std_logic_vector(2 * N - 3 downto 0)
);
end component DADDA;

component fake_DADDA is
  generic(N : integer := 33; N_PP : integer := 17);
  port (
    	 PP1 : in std_logic_vector(N-1 downto 0);
         PP2 : in std_logic_vector(N-1 downto 0);
		 PP3 : in std_logic_vector(N-1 downto 0);
		 PP4 : in std_logic_vector(N-1 downto 0);
		 PP5 : in std_logic_vector(N-1 downto 0);
		 PP6 : in std_logic_vector(N-1 downto 0);
		 PP7 : in std_logic_vector(N-1 downto 0);
		 PP8 : in std_logic_vector(N-1 downto 0);
		 PP9 : in std_logic_vector(N-1 downto 0);
		 PP10: in std_logic_vector(N-1 downto 0);
		 PP11: in std_logic_vector(N-1 downto 0);
		 PP12: in std_logic_vector(N-1 downto 0);
		 PP13: in std_logic_vector(N-1 downto 0);
		 PP14: in std_logic_vector(N-1 downto 0);
		 PP15: in std_logic_vector(N-1 downto 0);
		 PP16: in std_logic_vector(N-1 downto 0);
		 PP17: in std_logic_vector(N-1 downto 0);
         PP_sign : in  std_logic_vector (N / 2 downto 0);
         SUM     : out std_logic_vector (2 * N - 2 downto 0)
  ) ;
end component; 

  signal PP1      : std_logic_vector (32 downto 0);
  signal PP2      : std_logic_vector (32 downto 0);
  signal PP3      : std_logic_vector (32 downto 0);
  signal PP4      : std_logic_vector (32 downto 0);
  signal PP5      : std_logic_vector (32 downto 0);
  signal PP6      : std_logic_vector (32 downto 0);
  signal PP7      : std_logic_vector (32 downto 0);
  signal PP8      : std_logic_vector (32 downto 0);
  signal PP9      : std_logic_vector (32 downto 0);
  signal PP10     : std_logic_vector (32 downto 0);
  signal PP11     : std_logic_vector (32 downto 0);
  signal PP12     : std_logic_vector (32 downto 0);
  signal PP13     : std_logic_vector (32 downto 0);
  signal PP14     : std_logic_vector (32 downto 0);
  signal PP15     : std_logic_vector (32 downto 0);
  signal PP16     : std_logic_vector (32 downto 0);
  signal PP17     : std_logic_vector (32 downto 0);
  signal PP_sign  : std_logic_vector (16 downto 0);
  signal SUM      : std_logic_vector (63 downto 0);
  signal SUM_fake : std_logic_vector (64 downto 0);
  signal SUM_fake_short : std_logic_vector (63 downto 0);
begin

  DADDA_i : DADDA generic map (  33,  16)
port map (
  PP1     => PP1,
  PP2     => PP2,
  PP3     => PP3,
  PP4     => PP4,
  PP5     => PP5,
  PP6     => PP6,
  PP7     => PP7,
  PP8     => PP8,
  PP9     => PP9,
  PP10    => PP10,
  PP11    => PP11,
  PP12    => PP12,
  PP13    => PP13,
  PP14    => PP14,
  PP15    => PP15,
  PP16    => PP16,
  PP17    => PP17,
  PP_sign => PP_sign,
  SUM     => SUM
);

DADDA_fake : fake_DADDA generic map (  33,  17)
port map (
PP1     => PP1,
PP2     => PP2,
PP3     => PP3,
PP4     => PP4,
PP5     => PP5,
PP6     => PP6,
PP7     => PP7,
PP8     => PP8,
PP9     => PP9,
PP10    => PP10,
PP11    => PP11,
PP12    => PP12,
PP13    => PP13,
PP14    => PP14,
PP15    => PP15,
PP16    => PP16,
PP17    => PP17,
PP_sign => PP_sign,
SUM     => SUM_Fake
);

PP1     <= "111111111111111111111111111111111";
PP2     <= "111111111111111111111111111111111";
PP3     <= "111111111111111111111111111111111";
PP4     <= "111111111111111111111111111111111";
PP5     <= "000000000000000000000000000000000";
PP6     <= "000000000000000000000000000000000";
PP7     <= "000000000000000000000000000000000";
PP8     <= "000000000000000000000000000000000";
PP9     <= "000000000000000000000000000000000";
PP10    <= "000000000000000000000000000000000";
PP11    <= "000000000000000000000000000000000";
PP12    <= "000000000000000000000000000000000";
PP13    <= "000000000000000000000000000000000";
PP14    <= "000000000000000000000000000000000";
PP15    <= "000000000000000000000000000000000";
PP16    <= "000000000000000000000000000000000";
PP17    <= "000000000000000000000000000000000";
PP_sign <= (others => '0');

sum_fake_short <= sum_fake(63 downto 0);

end architecture ;