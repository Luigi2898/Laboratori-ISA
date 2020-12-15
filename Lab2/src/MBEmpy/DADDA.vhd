library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;


entity DADDA is
  generic(N : integer := 33; N_PP : integer := 17);
  port (
    PP1      : in  std_logic_vector(N - 1 downto 0);
    PP2      : in  std_logic_vector(N - 1 downto 0);
    PP3      : in  std_logic_vector(N - 1 downto 0);
    PP4      : in  std_logic_vector(N - 1 downto 0);
    PP5      : in  std_logic_vector(N - 1 downto 0);
    PP6      : in  std_logic_vector(N - 1 downto 0);
    PP7      : in  std_logic_vector(N - 1 downto 0);
    PP8      : in  std_logic_vector(N - 1 downto 0);
    PP9      : in  std_logic_vector(N - 1 downto 0);
    PP10     : in  std_logic_vector(N - 1 downto 0);
    PP11     : in  std_logic_vector(N - 1 downto 0);
    PP12     : in  std_logic_vector(N - 1 downto 0);
    PP13     : in  std_logic_vector(N - 1 downto 0);
    PP14     : in  std_logic_vector(N - 1 downto 0);
    PP15     : in  std_logic_vector(N - 1 downto 0);
    PP16     : in  std_logic_vector(N - 1 downto 0);
    PP17     : in  std_logic_vector(N - 1 downto 0);
    PP_sign  : in  std_logic_vector(N_PP downto 0);
    SUM      : out std_logic_vector(2 * N - 1 downto 0)
  ) ;
end DADDA;

architecture structural of DADDA is

  constant inc : integer := 3;

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

  component HAbank
    generic (N : integer := 1);
    port (
        in1  : in  unsigned(N - 1 downto 0);
        in2  : in  unsigned(N - 1 downto 0);
        outS : out unsigned(N - 1 downto 0);
        outC : out unsigned(N - 1 downto 0)
    );
  end component HAbank;

  component HA
    port (
        A, B  : IN  STD_LOGIC;
        S, Co : OUT STD_LOGIC
    );
  end component HA;

  type level is array (integer range <>) of unsigned(64 downto 0);
  signal level0 : level(0 to 16);

  -- OUTPUTS of different levels

  signal outS_01 : unsigned(19 downto 0);
  signal outC_01 : unsigned(17 downto 0);
  signal outS_02 : unsigned(15 downto 0);
  signal outC_02 : unsigned(13 downto 0);
  signal outS_03 : unsigned(11 downto 0);
  signal outC_03 : unsigned(9 downto 0);
  signal outS_04 : unsigned(7 downto 0);
  signal outC_04 : unsigned(5 downto 0);

  signal outS_11 : unsigned(35 downto 0);
  signal outC_11 : unsigned(33 downto 0);
  signal outS_12 : unsigned(31 downto 0);
  signal outC_12 : unsigned(29 downto 0);
  signal outS_13 : unsigned(27 downto 0);
  signal outC_13 : unsigned(25 downto 0);
  signal outS_14 : unsigned(23 downto 0);
  signal outC_14 : unsigned(21 downto 0);

  signal outS_21 : unsigned(47 downto 0);
  signal outC_21 : unsigned(45 downto 0);
  signal outS_22 : unsigned(43 downto 0);
  signal outC_22 : unsigned(41 downto 0);
  signal outS_23 : unsigned(39 downto 0);
  signal outC_23 : unsigned(37 downto 0);

  signal outS_31 : unsigned(55 downto 0);
  signal outC_31 : unsigned(53 downto 0);
  signal outS_32 : unsigned(51 downto 0);
  signal outC_32 : unsigned(49 downto 0);

  signal outS_41 : unsigned(59 downto 0);
  signal outC_41 : unsigned(57 downto 0);

  signal outS_51 : unsigned(61 downto 0);
  signal outC_51 : unsigned(61 downto 0);

-- INPUTS of different CSA

  signal in11_1 : unsigned(31 downto 0);
  signal in11_2 : unsigned(31 downto 0);
  signal in11_3 : unsigned(31 downto 0);

  signal in12_1 : unsigned(27 downto 0);
  signal in12_2 : unsigned(27 downto 0);
  signal in12_3 : unsigned(27 downto 0);

  signal in13_1 : unsigned(23 downto 0);
  signal in13_2 : unsigned(23 downto 0);
  signal in13_3 : unsigned(23 downto 0);

  signal in14_1 : unsigned(19 downto 0);
  signal in14_2 : unsigned(19 downto 0);
  signal in14_3 : unsigned(19 downto 0);

  signal in21_1 : unsigned(43 downto 0);
  signal in21_2 : unsigned(43 downto 0);
  signal in21_3 : unsigned(43 downto 0);

  signal in22_1 : unsigned(39 downto 0);
  signal in22_2 : unsigned(39 downto 0);
  signal in22_3 : unsigned(39 downto 0);

  signal in23_1 : unsigned(35 downto 0);
  signal in23_2 : unsigned(35 downto 0);
  signal in23_3 : unsigned(35 downto 0);

  signal in31_1 : unsigned(51 downto 0);
  signal in31_2 : unsigned(51 downto 0);
  signal in31_3 : unsigned(51 downto 0);

  signal in32_1 : unsigned(47 downto 0);
  signal in32_2 : unsigned(47 downto 0);
  signal in32_3 : unsigned(47 downto 0);

  signal in41_1 : unsigned(55 downto 0);
  signal in41_2 : unsigned(55 downto 0);
  signal in41_3 : unsigned(55 downto 0);

  signal in51_1 : unsigned(59 downto 0);
  signal in51_2 : unsigned(59 downto 0);
  signal in51_3 : unsigned(59 downto 0);

  -- SUM inputs

  signal inSUM_1 : unsigned(64 downto 0);
  signal inSUM_2 : unsigned(64 downto 0);
  signal SUM_long : unsigned(64 downto 0);

begin

  -- Sign extension --------------------------

  level0(0) <= '0' & not(PP_sign(15)) & '1' & not(PP_sign(14)) & '1' & not(PP_sign(13)) & '1' & not(PP_sign(12)) & '1' & not(PP_sign(11)) & '1' & not(PP_sign(10)) & '1' & not(PP_sign(9)) & '1' & not(PP_sign(8)) & '1' & not(PP_sign(7)) & '1' & not(PP_sign(6)) & '1' & not(PP_sign(5)) & '1' & not(PP_sign(4)) & '1' & not(PP_sign(3)) & '1' & not(PP_sign(2)) & '1' & not(PP_sign(0)) & PP_sign(0) & PP_sign(0) & PP1(32) & PP1(31) & PP1(30) & PP1(29) & PP1(28) & PP1(27) & PP1(26) & PP1(25) & PP1(24) & PP1(23) & PP1(22) & PP1(21) & PP1(20) & PP1(19) & PP1(18) & PP1(17) & PP1(16) & PP1(15) & PP1(14) & PP1(13) & PP1(12) & PP1(11) & PP1(10) & PP1(9) & PP1(8) & PP1(7) & PP1(6) & PP1(5) & PP1(4) & PP1(3) & PP1(2) & PP1(1) & PP1(0) ;
  level0(1) <= '0' & PP17(31) & PP16(32) & PP16(31) & PP15(32) & PP15(31) & PP14(32) & PP14(31) & PP13(32) & PP13(31) & PP12(32) & PP12(31) & PP11(32) & PP11(31) & PP10(32) & PP10(31) & PP9(32) & PP9(31) & PP8(32) & PP8(31) & PP7(32) & PP7(31) & PP6(32) & PP6(31) & PP5(32) & PP5(31) & PP4(32) & PP4(31) & PP3(32) & not(PP_sign(1)) & PP2(32) & PP2(31) & PP2(30) & PP2(29) & PP2(28) & PP2(27) & PP2(26) & PP2(25) & PP2(24) & PP2(23) & PP2(22) & PP2(21) & PP2(20) & PP2(19) & PP2(18) & PP2(17) & PP2(16) & PP2(15) & PP2(14) & PP2(13) & PP2(12) & PP2(11) & PP2(10) & PP2(9) & PP2(8) & PP2(7) & PP2(6) & PP2(5) & PP2(4) & PP2(3) & PP2(2) & PP2(1) & PP2(0) & '0' & PP_sign(0) ;
  level0(2) <= '0' & '0' & PP17(30) & PP17(29) & PP16(30) & PP16(29) & PP15(30) & PP15(29) & PP14(30) & PP14(29) & PP13(30) & PP13(29) & PP12(30) & PP12(29) & PP11(30) & PP11(29) & PP10(30) & PP10(29) & PP9(30) & PP9(29) & PP8(30) & PP8(29) & PP7(30) & PP7(29) & PP6(30) & PP6(29) & PP5(30) & PP5(29) & PP4(30) & PP3(31) & PP3(30) & PP3(29) & PP3(28) & PP3(27) & PP3(26) & PP3(25) & PP3(24) & PP3(23) & PP3(22) & PP3(21) & PP3(20) & PP3(19) & PP3(18) & PP3(17) & PP3(16) & PP3(15) & PP3(14) & PP3(13) & PP3(12) & PP3(11) & PP3(10) & PP3(9) & PP3(8) & PP3(7) & PP3(6) & PP3(5) & PP3(4) & PP3(3) & PP3(2) & PP3(1) & PP3(0) & '0' & PP_sign(1) & '0' & '0' ;
  level0(3) <= '0' & '0' & '0' & '0' & PP17(28) & PP17(27) & PP16(28) & PP16(27) & PP15(28) & PP15(27) & PP14(28) & PP14(27) & PP13(28) & PP13(27) & PP12(28) & PP12(27) & PP11(28) & PP11(27) & PP10(28) & PP10(27) & PP9(28) & PP9(27) & PP8(28) & PP8(27) & PP7(28) & PP7(27) & PP6(28) & PP6(27) & PP5(28) & PP4(29) & PP4(28) & PP4(27) & PP4(26) & PP4(25) & PP4(24) & PP4(23) & PP4(22) & PP4(21) & PP4(20) & PP4(19) & PP4(18) & PP4(17) & PP4(16) & PP4(15) & PP4(14) & PP4(13) & PP4(12) & PP4(11) & PP4(10) & PP4(9) & PP4(8) & PP4(7) & PP4(6) & PP4(5) & PP4(4) & PP4(3) & PP4(2) & PP4(1) & PP4(0) & '0' & PP_sign(2) & '0' & '0' & '0' & '0' ;
  level0(4) <= '0' & '0' & '0' & '0' & '0' & '0' & PP17(26) & PP17(25) & PP16(26) & PP16(25) & PP15(26) & PP15(25) & PP14(26) & PP14(25) & PP13(26) & PP13(25) & PP12(26) & PP12(25) & PP11(26) & PP11(25) & PP10(26) & PP10(25) & PP9(26) & PP9(25) & PP8(26) & PP8(25) & PP7(26) & PP7(25) & PP6(26) & PP5(27) & PP5(26) & PP5(25) & PP5(24) & PP5(23) & PP5(22) & PP5(21) & PP5(20) & PP5(19) & PP5(18) & PP5(17) & PP5(16) & PP5(15) & PP5(14) & PP5(13) & PP5(12) & PP5(11) & PP5(10) & PP5(9) & PP5(8) & PP5(7) & PP5(6) & PP5(5) & PP5(4) & PP5(3) & PP5(2) & PP5(1) & PP5(0) & '0' & PP_sign(3) & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(5) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(24) & PP17(23) & PP16(24) & PP16(23) & PP15(24) & PP15(23) & PP14(24) & PP14(23) & PP13(24) & PP13(23) & PP12(24) & PP12(23) & PP11(24) & PP11(23) & PP10(24) & PP10(23) & PP9(24) & PP9(23) & PP8(24) & PP8(23) & PP7(24) & PP6(25) & PP6(24) & PP6(23) & PP6(22) & PP6(21) & PP6(20) & PP6(19) & PP6(18) & PP6(17) & PP6(16) & PP6(15) & PP6(14) & PP6(13) & PP6(12) & PP6(11) & PP6(10) & PP6(9) & PP6(8) & PP6(7) & PP6(6) & PP6(5) & PP6(4) & PP6(3) & PP6(2) & PP6(1) & PP6(0) & '0' & PP_sign(4) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(6) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(22) & PP17(21) & PP16(22) & PP16(21) & PP15(22) & PP15(21) & PP14(22) & PP14(21) & PP13(22) & PP13(21) & PP12(22) & PP12(21) & PP11(22) & PP11(21) & PP10(22) & PP10(21) & PP9(22) & PP9(21) & PP8(22) & PP7(23) & PP7(22) & PP7(21) & PP7(20) & PP7(19) & PP7(18) & PP7(17) & PP7(16) & PP7(15) & PP7(14) & PP7(13) & PP7(12) & PP7(11) & PP7(10) & PP7(9) & PP7(8) & PP7(7) & PP7(6) & PP7(5) & PP7(4) & PP7(3) & PP7(2) & PP7(1) & PP7(0) & '0' & PP_sign(5) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(7) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(20) & PP17(19) & PP16(20) & PP16(19) & PP15(20) & PP15(19) & PP14(20) & PP14(19) & PP13(20) & PP13(19) & PP12(20) & PP12(19) & PP11(20) & PP11(19) & PP10(20) & PP10(19) & PP9(20) & PP8(21) & PP8(20) & PP8(19) & PP8(18) & PP8(17) & PP8(16) & PP8(15) & PP8(14) & PP8(13) & PP8(12) & PP8(11) & PP8(10) & PP8(9) & PP8(8) & PP8(7) & PP8(6) & PP8(5) & PP8(4) & PP8(3) & PP8(2) & PP8(1) & PP8(0) & '0' & PP_sign(6) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(8) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(18) & PP17(17) & PP16(18) & PP16(17) & PP15(18) & PP15(17) & PP14(18) & PP14(17) & PP13(18) & PP13(17) & PP12(18) & PP12(17) & PP11(18) & PP11(17) & PP10(18) & PP9(19) & PP9(18) & PP9(17) & PP9(16) & PP9(15) & PP9(14) & PP9(13) & PP9(12) & PP9(11) & PP9(10) & PP9(9) & PP9(8) & PP9(7) & PP9(6) & PP9(5) & PP9(4) & PP9(3) & PP9(2) & PP9(1) & PP9(0) & '0' & PP_sign(7) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(9) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(16) & PP17(15) & PP16(16) & PP16(15) & PP15(16) & PP15(15) & PP14(16) & PP14(15) & PP13(16) & PP13(15) & PP12(16) & PP12(15) & PP11(16) & PP10(17) & PP10(16) & PP10(15) & PP10(14) & PP10(13) & PP10(12) & PP10(11) & PP10(10) & PP10(9) & PP10(8) & PP10(7) & PP10(6) & PP10(5) & PP10(4) & PP10(3) & PP10(2) & PP10(1) & PP10(0) & '0' & PP_sign(8) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(10) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(14) & PP17(13) & PP16(14) & PP16(13) & PP15(14) & PP15(13) & PP14(14) & PP14(13) & PP13(14) & PP13(13) & PP12(14) & PP11(15) & PP11(14) & PP11(13) & PP11(12) & PP11(11) & PP11(10) & PP11(9) & PP11(8) & PP11(7) & PP11(6) & PP11(5) & PP11(4) & PP11(3) & PP11(2) & PP11(1) & PP11(0) & '0' & PP_sign(9) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(11) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(12) & PP17(11) & PP16(12) & PP16(11) & PP15(12) & PP15(11) & PP14(12) & PP14(11) & PP13(12) & PP12(13) & PP12(12) & PP12(11) & PP12(10) & PP12(9) & PP12(8) & PP12(7) & PP12(6) & PP12(5) & PP12(4) & PP12(3) & PP12(2) & PP12(1) & PP12(0) & '0' & PP_sign(10) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(12) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(10) & PP17(9) & PP16(10) & PP16(9) & PP15(10) & PP15(9) & PP14(10) & PP13(11) & PP13(10) & PP13(9) & PP13(8) & PP13(7) & PP13(6) & PP13(5) & PP13(4) & PP13(3) & PP13(2) & PP13(1) & PP13(0) & '0' & PP_sign(11) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(13) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(8) & PP17(7) & PP16(8) & PP16(7) & PP15(8) & PP14(9) & PP14(8) & PP14(7) & PP14(6) & PP14(5) & PP14(4) & PP14(3) & PP14(2) & PP14(1) & PP14(0) & '0' & PP_sign(12) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(14) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(6) & PP17(5) & PP16(6) & PP15(7) & PP15(6) & PP15(5) & PP15(4) & PP15(3) & PP15(2) & PP15(1) & PP15(0) & '0' & PP_sign(13) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(15) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(4) & PP16(5) & PP16(4) & PP16(3) & PP16(2) & PP16(1) & PP16(0) & '0' & PP_sign(14) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;
  level0(16) <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & PP17(3) & PP17(2) & PP17(1) & PP17(0) & '0' & PP_sign(15) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' ;

  -- First level -----------------------------

  HA_01  : HAbank generic map (2)
                port map (level0(0)(25 downto 24), level0(1)(25 downto 24), outS_01(1 downto 0), outC_01(1 downto 0));
  CSA_01 : CSA    generic map (16)
                port map (level0(0)(41 downto 26), level0(1)(41 downto 26), level0(2)(41 downto 26), outS_01(17 downto 2), outC_01(17 downto 2));
  HA_02  : HA     port map (level0(0)(42), level0(1)(42), outS_01(18), outS_01(19));

  HA_03  : HAbank generic map (2)
                port map (level0(inc)(27 downto 26), level0(inc + 1)(27 downto 26), outS_02(1 downto 0), outC_02(1 downto 0));
  CSA_02 : CSA    generic map (12)
                port map (level0(inc)(39 downto 28), level0(inc + 1)(39 downto 28), level0(inc + 2)(39 downto 28), outS_02(13 downto 2), outC_02(13 downto 2));
  HA_04  : HA     port map (level0(inc)(40), level0(inc + 1)(40), outS_02(14), outS_02(15));

  HA_05  : HAbank generic map (2)
                port map (level0(2 * inc)(29 downto 28), level0(2 * inc + 1)(29 downto 28), outS_03(1 downto 0), outC_03(1 downto 0));
  CSA_03 : CSA    generic map (8)
                port map (level0(2 * inc)(37 downto 30), level0(2 * inc + 1)(37 downto 30), level0(2 * inc + 2)(37 downto 30), outS_03(9 downto 2), outC_03(9 downto 2));
  HA_06  : HA     port map (level0(2 * inc)(38), level0(2 * inc + 1)(38), outS_03(10), outS_03(11));

  HA_07  : HAbank generic map (2)
                port map (level0(3 * inc)(31 downto 30), level0(3 * inc + 1)(31 downto 30), outS_04(1 downto 0), outC_04(1 downto 0));
  CSA_04 : CSA    generic map (4)
                port map (level0(3 * inc)(35 downto 32), level0(3 * inc + 1)(35 downto 32), level0(3 * inc + 2)(35 downto 32), outS_04(5 downto 2), outC_04(5 downto 2));
  HA_08  : HA     port map (level0(3 * inc)(36), level0(3 * inc + 1)(36), outS_04(6), outS_04(7));

-- Second level ----------------------------

  HA_11  : HAbank generic map (2)
                port map (level0(0)(17 downto 16), level0(1)(17 downto 16), outS_11(1 downto 0), outC_11(1 downto 0));
  in11_1 <= level0(0)(49 downto 44) & outS_01 & level0(0)(23 downto 18);
  in11_2 <= level0(1)(49 downto 44) & level0(0)(43) & outC_01 & level0(13)(24) & level0(1)(23 downto 18);
  in11_3 <= level0(2)(49 downto 42) & outS_02 & level0(2)(25 downto 18);
  CSA_11 : CSA    generic map (32)
                port map (in11_1, in11_2, in11_3, outS_11(33 downto 2), outC_11(33 downto 2));
  HA_12  : HA     port map (level0(0)(50), level0(1)(50), outS_11(34), outS_11(35));

  HA_13  : HAbank generic map (2)
                port map (level0(3)(19 downto 18), level0(5)(19 downto 18), outS_12(1 downto 0), outC_12(1 downto 0));
  in12_1 <= level0(3)(47 downto 41) & outC_02 & level0(14)(26) & level0(3)(25 downto 20);
  in12_2 <= level0(5)(47 downto 40) & outS_03 & level0(5)(27 downto 20);
  in12_3 <= level0(6)(47 downto 39) & outC_03 & level0(15)(28) & level0(6)(27 downto 20);
  CSA_12 : CSA    generic map (28)
                port map (in12_1, in12_2, in12_3, outS_12(29 downto 2), outC_12(29 downto 2));
  HA_14  : HA     port map (level0(3)(48), level0(5)(48), outS_12(30), outS_12(31));

  HA_15  : HAbank generic map (2)
                port map (level0(8)(21 downto 20), level0(9)(21 downto 20), outS_13(1 downto 0), outC_13(1 downto 0));
  in13_1 <= level0(8)(45 downto 38) & outS_04 & level0(8)(29 downto 22);
  in13_2 <= level0(9)(45 downto 37) & outC_04 & level0(16)(30) & level0(9)(29 downto 22);
  in13_3 <= level0(3)(45 downto 39) & level0(14)(38 downto 28) & level0(3)(27 downto 26) & level0(4)(25 downto 22);
  CSA_13 : CSA    generic map (24)
                port map (in13_1, in13_2, in13_3, outS_13(25 downto 2), outC_13(25 downto 2));
  HA_16  : HA     port map (level0(8)(46), level0(9)(46), outS_13(26), outS_13(27));

  HA_17  : HAbank generic map (2)
                port map (level0(7)(23 downto 22), level0(10)(23 downto 22), outS_14(1 downto 0), outC_14(1 downto 0));
  in14_1 <= level0(4)(43 downto 41) & level0(13)(40 downto 26) & level0(7)(25 downto 24);
  in14_2 <= level0(10)(43 downto 37) & level0(15)(36 downto 30) & level0(10)(29 downto 24);
  in14_3 <= level0(11)(43 downto 36) & level0(16)(35 downto 32) & level0(11)(31 downto 24);
  CSA_14 : CSA    generic map (20)
                port map (in14_1, in14_2, in14_3, outS_14(21 downto 2), outC_14(21 downto 2));
  HA_18  : HA     port map (level0(4)(44), level0(10)(44), outS_14(22), outS_14(23));

-- Third level ----------------------------

  HA_21  : HAbank generic map (2)
                  port map (level0(0)(11 downto 10), level0(1)(11 downto 10), outS_21(1 downto 0), outC_21(1 downto 0));
  in21_1 <= level0(0)(55 downto 52) & outS_11 & level0(0)(15 downto 12);
  in21_2 <= level0(1)(55 downto 52) & level0(0)(51) & outC_11 & level0(7)(16) & level0(1)(15 downto 12);
  in21_3 <= level0(2)(55 downto 50) & outS_12 & level0(2)(17 downto 12);
  CSA_21 : CSA    generic map (44)
                  port map (in21_1, in21_2, in21_3, outS_21(45 downto 2), outC_21(45 downto 2));
  HA_22  : HA     port map (level0(0)(56), level0(1)(56), outS_21(46), outS_21(47));

  HA_23  : HAbank generic map (2)
                  port map (level0(3)(13 downto 12), level0(6)(13 downto 12), outS_22(1 downto 0), outC_22(1 downto 0));
  in22_1 <= level0(3)(53 downto 49) & outC_12 & level0(10)(18) & level0(3)(17 downto 14);
  in22_2 <= level0(6)(53 downto 48) & outS_13 & level0(6)(19 downto 14);
  in22_3 <= level0(4)(53) & level0(7)(52 downto 51) & level0(4)(50 downto 49) & level0(9)(48 downto 47) & outC_13 & level0(4)(20 downto 14);
  CSA_22 : CSA    generic map (40)
                  port map (in22_1, in22_2, in22_3, outS_22(41 downto 2), outC_22(41 downto 2));
  HA_24  : HA     port map (level0(3)(54), level0(6)(54), outS_22(42), outS_22(43));

  HA_25  : HAbank generic map (2)
                  port map (level0(5)(15 downto 14), level0(7)(15 downto 14), outS_23(1 downto 0), outC_23(1 downto 0));
  in23_1 <= level0(4)(51) & level0(7)(50 downto 46) & outS_14 & level0(7)(21 downto 18) & level0(5)(17 downto 16);
  in23_2 <= level0(5)(51 downto 49) & level0(4)(48 downto 45) & outC_14 & level0(11)(22) & level0(10)(21 downto 20) & level0(9)(19 downto 18) & level0(7)(17) & level0(9)(16);
  in23_3 <= level0(1)(51) & level0(8)(50 downto 47) & level0(10)(46 downto 45) & level0(11)(44) & level0(1)(43) & level0(13)(42 downto 24) & level0(11)(23) & level0(13)(22) & level0(4)(21) & level0(11)(20) & level0(8)(19 downto 16);
  CSA_23 : CSA    generic map (36)
                  port map (in23_1, in23_2, in23_3, outS_23(37 downto 2), outC_23(37 downto 2));
  HA_26  : HA     port map (level0(4)(52), level0(5)(52), outS_23(38), outS_23(39));

-- Fourth level ----------------------------

  HA_31  : HAbank generic map (2)
                  port map (level0(0)(7 downto 6), level0(1)(7 downto 6), outS_31(1 downto 0), outC_31(1 downto 0));
  in31_1 <= level0(0)(59 downto 58) & outS_21 & level0(0)(9 downto 8);
  in31_2 <= level0(1)(59 downto 57) & outC_21 & level0(6)(10) & level0(1)(9 downto 8);
  in31_3 <= level0(2)(59 downto 56) & outS_22 & level0(2)(11 downto 8);
  CSA_31 : CSA    generic map (52)
                  port map (in31_1, in31_2, in31_3, outS_31(53 downto 2), outC_31(53 downto 2));
  HA_32  : HA     port map (level0(0)(60), level0(1)(60), outS_31(54), outS_31(55));

  HA_33  : HAbank generic map (2)
                  port map (level0(3)(9 downto 8), level0(4)(9 downto 8), outS_32(1 downto 0), outC_32(1 downto 0));
  in32_1 <= level0(3)(57 downto 55) & outC_22 & level0(7)(12) & level0(3)(11 downto 10);
  in32_2 <= level0(4)(57 downto 54) & outS_23 & level0(4)(13 downto 10);
  in32_3 <= level0(0)(57) & level0(5)(56 downto 53) & outC_23 & level0(8)(14) & level0(5)(13 downto 10);
  CSA_32 : CSA    generic map (48)
                  port map (in32_1, in32_2, in32_3, outS_32(49 downto 2), outC_32(49 downto 2));
  HA_34  : HA     port map (level0(3)(58), level0(4)(58), outS_32(50), outS_32(51));

-- Fifth level ----------------------------

  HA_41  : HAbank generic map (2)
                  port map (level0(0)(5 downto 4), level0(1)(5 downto 4), outS_41(1 downto 0), outC_41(1 downto 0));
  in41_1 <= outS_31;
  in41_2 <= level0(1)(61) & outC_31 & level0(3)(6);
  in41_3 <= level0(2)(61 downto 60) & outS_32 & level0(2)(7 downto 6);
  CSA_41 : CSA    generic map (56)
                  port map (in41_1, in41_2, in41_3, outS_41(57 downto 2), outC_41(57 downto 2));
  HA_42  : HA     port map (level0(0)(60), level0(1)(60), outS_41(58), outS_41(59));

-- Sixth level ----------------------------

  HA_51  : HAbank generic map (2)
                  port map (level0(0)(3 downto 2), level0(1)(3 downto 2), outS_51(1 downto 0), outC_51(1 downto 0));
  in51_1 <= outS_41;
  in51_2 <= level0(0)(63) & outC_41 & level0(2)(4);
  in51_3 <= level0(1)(63) & level0(2)(62) & level0(0)(61) & level0(3)(60 downto 59) & outC_32 & level0(5)(8) & level0(3)(7) & level0(4)(6) & level0(2)(5) & level0(3)(4);
  CSA_51 : CSA    generic map (60)
                  port map (in51_1, in51_2, in51_3, outS_51(61 downto 2), outC_51(61 downto 2));

-- Seventh level aka the behavioural adder --

  inSUM_1 <= '0' & outS_51 & level0(0)(1 downto 0);
  inSUM_2 <= outC_51 & level0(2)(2) & '0' & level0(1)(0);
  SUM_long <= std_logic_vector(inSUM_1 + inSUM_2);
  SUM <= SUM_long(63 downto 0);
end architecture ;
