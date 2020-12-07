library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;


entity DADDA is
  generic(N : integer := 32; N_PP : integer := 17);
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
    SUM      : out std_logic_vector(2 * N - 2 downto 0)
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
  signal level1 : level(0 to 12);



begin

  -- Sign extension -----------------------

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

  -- First level --------------------------

  HA_01  : HAbank generic map (2)
                  port map (level0(0)(26 downto 24), level0(1)(26 downto 24), level1(0)(26 downto 24), level1(1)(27 downto 25));
  CSA_01 : CSA    generic map (16)
                  port map (level0(0)(42 downto 26), level0(1)(42 downto 26), level0(2)(42 downto 26), level1(0)(42 downto 26), level1(1)(43 downto 27));
  HA_02  : HA     port map (level0(0)(42), level0(1)(42), level1(0)(42), level1(0)(43));

  HA_03  : HAbank generic map (2)
                  port map (level0(inc)(28 downto 26), level0(inc + 1)(28 downto 26), level1(2)(28 downto 26), level1(3)(29 downto 27));
  CSA_02 : CSA    generic map (12)
                  port map (level0(inc)(41 downto 28), level0(inc + 1)(41 downto 28), level0(inc + 2)(41 downto 28), level1(2)(41 downto 28), level1(3)(42 downto 29));
  HA_04  : HA     port map (level0(inc)(41), level0(inc + 1)(41), level1(2)(41), level1(2)(42));

  HA_05  : HAbank generic map (2)
                  port map (level0(2 * inc)(30 downto 28), level0(2 * inc + 1)(30 downto 28), level1(4)(30 downto 28), level1(5)(31 downto 29));
  CSA_03 : CSA    generic map (8)
                  port map (level0(2 * inc)(38 downto 30), level0(2 * inc + 1)(38 downto 30), level0(2 * inc + 2)(38 downto 30), level1(4)(38 downto 30), level1(5)(39 downto 31));
  HA_06  : HA     port map (level0(2 * inc)(38), level0(2 * inc + 1)(38), level1(4)(38), level1(4)(39));

  HA_07  : HAbank generic map (2)
                  port map (level0(3 * inc)(32 downto 30), level0(3 * inc + 1)(32 downto 30), level1(6)(32 downto 30), level1(7)(33 downto 31));
  CSA_04 : CSA    generic map (4)
                  port map (level0(3 * inc)(36 downto 32), level0(3 * inc + 1)(36 downto 32), level0(3 * inc + 2)(36 downto 32), level1(6)(36 downto 32), level1(7)(37 downto 33));
  HA_08  : HA     port map (level0(3 * inc)(36), level0(3 * inc + 1)(36), level1(6)(36), level1(6)(37));

  level1(0)(24 downto 0) <= level0(0)(24 downto 0);
  level1(0)(64 downto 44) <= level0(0)(64 downto 44);

  level1(1)(64 downto 43) <= level0(1)(64 downto 44) & level0(1)(43);
  level1(1)(25 downto 0) <= level0(13)(24) & level0(1)(24 downto 0);

  level1(2)(64 downto 42) <= level0(2)(64 downto 42);
  level1(2)(26 downto 0) <= level0(2)(26 downto 0);

  level1(3)(64 downto 41) <= level0(3)(64 downto 41);
  level1(3)(26) <= level0(14)(26);
  level1(3)(26 downto 0) <= level0(3)(26 downto 0);

  level1(4)(64 downto 57) <= level0(4)(64 downto 57);
  level1(4)(57 downto 40) <= level0(5)(57 downto 40);
  level1(4)(28 downto 10) <= level0(5)(28 downto 10);
  level1(4)(9) <= level0(4)(9);
  level1(4)(9 downto 7) <= level1(5)(9 downto 7);
  level1(4)(7 downto 0) <= level1(4)(7 downto 0);

  level1(5)(64 downto 55) <= level1(4)(64 downto 55);
  level1(5)(55 downto 39) <= level0(6)(55 downto 39);
  level1(5)(28) <= level0(15)(28);
  level1(5)(28 downto 12) <= level0(6)(28 downto 12);
  level1(5)(11) <= level0(4)(11);
  level1(5)(11 downto 9) <= level0(6)(11 downto 9);
  level1(5)(9 downto 0) <= level0(4)(9 downto 0);

  level1(6)(64 downto 51) <= level0(4)(64 downto 51);
  level1(6)(51 downto 38) <= level0(8)(51 downto 38);
  level1(6)(30 downto 16) <= level0(8)(30 downto 16);
  level1(6)(15) <= level0(4)(15);
  level1(6)(14) <= level0(8)(14);
  level1(6)(13 downto 0) <= level0(4)(13 downto 0);

  level1(7)(64 downto 51) <= level0(7)(64 downto 51);
  level1(7)(51 downto 49) <= level1(7)(51 downto 49);
  level1(7)(49 downto 37) <= level0(9)(49 downto 37);
  level1(7)(30) <= level0(16)(30);
  level1(7)(30 downto 18) <= level0(9)(30 downto 18);
  level1(7)(17) <= level0(7)(17);
  level1(7)(16) <= level0(9)(16);
  level1(7)(16 downto 0) <= level0(7)(16 downto 0);

  level1(8)(64 downto 39) <= level0(7)(64 downto 39);
  level1(8)(39 downto 28) <= level0(14)(39 downto 28);
  level1(8)(28 downto 26) <= level0(8)(28 downto 26);


end architecture ;
