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
          IN0 : in  std_logic_vector (N-1 downto 0);
          IN1 : in  std_logic_vector (N-1 downto 0);
          IN2 : in  std_logic_vector (N-1 downto 0);
          S   : out std_logic_vector (N-1 downto 0);
          C   : out std_logic_vector (N-1 downto 0)
      );
  end component CSA;

  component HA is
    port(
		    A, B  : in  std_logic;
		    S, Co : out std_logic
    );
  end component HA;
signal internal_0_0 : std_logic_vector(63 downto 0);
signal internal_0_1 : std_logic_vector(62 downto 0);
signal internal_0_2 : std_logic_vector(59 downto 0);
signal internal_0_3 : std_logic_vector(55 downto 0);
signal internal_0_4 : std_logic_vector(51 downto 0);
signal internal_0_5 : std_logic_vector(47 downto 0);
signal internal_0_6 : std_logic_vector(43 downto 0);
signal internal_0_7 : std_logic_vector(39 downto 0);
signal internal_0_8 : std_logic_vector(35 downto 0);
signal internal_0_9 : std_logic_vector(31 downto 0);
signal internal_0_10 : std_logic_vector(27 downto 0);
signal internal_0_11 : std_logic_vector(23 downto 0);
signal internal_0_12 : std_logic_vector(19 downto 0);
signal internal_0_13 : std_logic_vector(15 downto 0);
signal internal_0_14 : std_logic_vector(11 downto 0);
signal internal_0_15 : std_logic_vector(7 downto 0);
signal internal_0_16 : std_logic_vector(4 downto 0);
signal internal_1_0 : std_logic_vector(63 downto 0);
signal internal_1_1 : std_logic_vector(62 downto 0);
signal internal_1_2 : std_logic_vector(59 downto 0);
signal internal_1_3 : std_logic_vector(55 downto 0);
signal internal_1_4 : std_logic_vector(51 downto 0);
signal internal_1_5 : std_logic_vector(47 downto 0);
signal internal_1_6 : std_logic_vector(43 downto 0);
signal internal_1_7 : std_logic_vector(39 downto 0);
signal internal_1_8 : std_logic_vector(35 downto 0);
signal internal_1_9 : std_logic_vector(31 downto 0);
signal internal_1_10 : std_logic_vector(27 downto 0);
signal internal_1_11 : std_logic_vector(23 downto 0);
signal internal_1_12 : std_logic_vector(19 downto 0);
signal internal_2_0 : std_logic_vector(63 downto 0);
signal internal_2_1 : std_logic_vector(62 downto 0);
signal internal_2_2 : std_logic_vector(59 downto 0);
signal internal_2_3 : std_logic_vector(55 downto 0);
signal internal_2_4 : std_logic_vector(51 downto 0);
signal internal_2_5 : std_logic_vector(47 downto 0);
signal internal_2_6 : std_logic_vector(43 downto 0);
signal internal_2_7 : std_logic_vector(39 downto 0);
signal internal_2_8 : std_logic_vector(35 downto 0);
signal internal_3_0 : std_logic_vector(63 downto 0);
signal internal_3_1 : std_logic_vector(62 downto 0);
signal internal_3_2 : std_logic_vector(59 downto 0);
signal internal_3_3 : std_logic_vector(55 downto 0);
signal internal_3_4 : std_logic_vector(51 downto 0);
signal internal_3_5 : std_logic_vector(47 downto 0);
signal internal_4_0 : std_logic_vector(63 downto 0);
signal internal_4_1 : std_logic_vector(62 downto 0);
signal internal_4_2 : std_logic_vector(59 downto 0);
signal internal_4_3 : std_logic_vector(55 downto 0);
signal internal_5_0 : std_logic_vector(63 downto 0);
signal internal_5_1 : std_logic_vector(62 downto 0);
signal internal_5_2 : std_logic_vector(59 downto 0);
signal internal_6_0 : std_logic_vector(63 downto 0);
signal internal_6_1 : std_logic_vector(62 downto 0);




begin

internal_0_0 <= '1' & '1' & not(PP_sign(14)) & '1' & not(PP_sign(13)) & '1' & not(PP_sign(12)) & '1' & not(PP_sign(11)) & '1' & not(PP_sign(10)) & '1' & not(PP_sign(9)) & '1' & not(PP_sign(8)) & '1' & not(PP_sign(7)) & '1' & not(PP_sign(6)) & '1' & not(PP_sign(5)) & '1' & not(PP_sign(4)) & '1' & not(PP_sign(3)) & '1' & not(PP_sign(2)) & '1' & not(PP_sign(0)) & PP_sign(0) & PP_sign(0) & PP(0)(32) & PP(0)(31) & PP(0)(30) & PP(0)(29) & PP(0)(28) & PP(0)(27) & PP(0)(26) & PP(0)(25) & PP(0)(24) & PP(0)(23) & PP(0)(22) & PP(0)(21) & PP(0)(20) & PP(0)(19) & PP(0)(18) & PP(0)(17) & PP(0)(16) & PP(0)(15) & PP(0)(14) & PP(0)(13) & PP(0)(12) & PP(0)(11) & PP(0)(10) & PP(0)(9) & PP(0)(8) & PP(0)(7) & PP(0)(6) & PP(0)(5) & PP(0)(4) & PP(0)(3) & PP(0)(2) & PP(0)(1) & PP(0)(0) ;
internal_0_1 <= PP(16)(0) & PP(15)(0) & PP(15)(1) & PP(14)(32) & PP(14)(31) & PP(13)(32) & PP(13)(31) & PP(12)(32) & PP(12)(31) & PP(11)(32) & PP(11)(31) & PP(10)(32) & PP(10)(31) & PP(9)(32) & PP(9)(31) & PP(8)(32) & PP(8)(31) & PP(7)(32) & PP(7)(31) & PP(6)(32) & PP(6)(31) & PP(5)(32) & PP(5)(31) & PP(4)(32) & PP(4)(31) & PP(3)(32) & PP(3)(31) & PP(2)(32) & not(PP_sign(1)) & PP(1)(32) & PP(1)(31) & PP(1)(30) & PP(1)(29) & PP(1)(28) & PP(1)(27) & PP(1)(26) & PP(1)(25) & PP(1)(24) & PP(1)(23) & PP(1)(22) & PP(1)(21) & PP(1)(20) & PP(1)(19) & PP(1)(18) & PP(1)(17) & PP(1)(16) & PP(1)(15) & PP(1)(14) & PP(1)(13) & PP(1)(12) & PP(1)(11) & PP(1)(10) & PP(1)(9) & PP(1)(8) & PP(1)(7) & PP(1)(6) & PP(1)(5) & PP(1)(4) & PP(1)(3) & PP(1)(2) & PP(1)(1) & PP(1)(0) & PP_sign(0) ;
internal_0_2 <= PP(16)(1) & PP(16)(2) & PP(15)(2) & PP(15)(3) & PP(14)(30) & PP(14)(29) & PP(13)(30) & PP(13)(29) & PP(12)(30) & PP(12)(29) & PP(11)(30) & PP(11)(29) & PP(10)(30) & PP(10)(29) & PP(9)(30) & PP(9)(29) & PP(8)(30) & PP(8)(29) & PP(7)(30) & PP(7)(29) & PP(6)(30) & PP(6)(29) & PP(5)(30) & PP(5)(29) & PP(4)(30) & PP(4)(29) & PP(3)(30) & PP(2)(31) & PP(2)(30) & PP(2)(29) & PP(2)(28) & PP(2)(27) & PP(2)(26) & PP(2)(25) & PP(2)(24) & PP(2)(23) & PP(2)(22) & PP(2)(21) & PP(2)(20) & PP(2)(19) & PP(2)(18) & PP(2)(17) & PP(2)(16) & PP(2)(15) & PP(2)(14) & PP(2)(13) & PP(2)(12) & PP(2)(11) & PP(2)(10) & PP(2)(9) & PP(2)(8) & PP(2)(7) & PP(2)(6) & PP(2)(5) & PP(2)(4) & PP(2)(3) & PP(2)(2) & PP(2)(1) & PP(2)(0) & PP_sign(1) ;
internal_0_3 <= PP(16)(3) & PP(16)(4) & PP(15)(4) & PP(15)(5) & PP(14)(28) & PP(14)(27) & PP(13)(28) & PP(13)(27) & PP(12)(28) & PP(12)(27) & PP(11)(28) & PP(11)(27) & PP(10)(28) & PP(10)(27) & PP(9)(28) & PP(9)(27) & PP(8)(28) & PP(8)(27) & PP(7)(28) & PP(7)(27) & PP(6)(28) & PP(6)(27) & PP(5)(28) & PP(5)(27) & PP(4)(28) & PP(3)(29) & PP(3)(28) & PP(3)(27) & PP(3)(26) & PP(3)(25) & PP(3)(24) & PP(3)(23) & PP(3)(22) & PP(3)(21) & PP(3)(20) & PP(3)(19) & PP(3)(18) & PP(3)(17) & PP(3)(16) & PP(3)(15) & PP(3)(14) & PP(3)(13) & PP(3)(12) & PP(3)(11) & PP(3)(10) & PP(3)(9) & PP(3)(8) & PP(3)(7) & PP(3)(6) & PP(3)(5) & PP(3)(4) & PP(3)(3) & PP(3)(2) & PP(3)(1) & PP(3)(0) & PP_sign(2) ;
internal_0_4 <= PP(16)(5) & PP(16)(6) & PP(15)(6) & PP(15)(7) & PP(14)(26) & PP(14)(25) & PP(13)(26) & PP(13)(25) & PP(12)(26) & PP(12)(25) & PP(11)(26) & PP(11)(25) & PP(10)(26) & PP(10)(25) & PP(9)(26) & PP(9)(25) & PP(8)(26) & PP(8)(25) & PP(7)(26) & PP(7)(25) & PP(6)(26) & PP(6)(25) & PP(5)(26) & PP(4)(27) & PP(4)(26) & PP(4)(25) & PP(4)(24) & PP(4)(23) & PP(4)(22) & PP(4)(21) & PP(4)(20) & PP(4)(19) & PP(4)(18) & PP(4)(17) & PP(4)(16) & PP(4)(15) & PP(4)(14) & PP(4)(13) & PP(4)(12) & PP(4)(11) & PP(4)(10) & PP(4)(9) & PP(4)(8) & PP(4)(7) & PP(4)(6) & PP(4)(5) & PP(4)(4) & PP(4)(3) & PP(4)(2) & PP(4)(1) & PP(4)(0) & PP_sign(3) ;
internal_0_5 <= PP(16)(7) & PP(16)(8) & PP(15)(8) & PP(15)(9) & PP(14)(24) & PP(14)(23) & PP(13)(24) & PP(13)(23) & PP(12)(24) & PP(12)(23) & PP(11)(24) & PP(11)(23) & PP(10)(24) & PP(10)(23) & PP(9)(24) & PP(9)(23) & PP(8)(24) & PP(8)(23) & PP(7)(24) & PP(7)(23) & PP(6)(24) & PP(5)(25) & PP(5)(24) & PP(5)(23) & PP(5)(22) & PP(5)(21) & PP(5)(20) & PP(5)(19) & PP(5)(18) & PP(5)(17) & PP(5)(16) & PP(5)(15) & PP(5)(14) & PP(5)(13) & PP(5)(12) & PP(5)(11) & PP(5)(10) & PP(5)(9) & PP(5)(8) & PP(5)(7) & PP(5)(6) & PP(5)(5) & PP(5)(4) & PP(5)(3) & PP(5)(2) & PP(5)(1) & PP(5)(0) & PP_sign(4) ;
internal_0_6 <= PP(16)(9) & PP(16)(10) & PP(15)(10) & PP(15)(11) & PP(14)(22) & PP(14)(21) & PP(13)(22) & PP(13)(21) & PP(12)(22) & PP(12)(21) & PP(11)(22) & PP(11)(21) & PP(10)(22) & PP(10)(21) & PP(9)(22) & PP(9)(21) & PP(8)(22) & PP(8)(21) & PP(7)(22) & PP(6)(23) & PP(6)(22) & PP(6)(21) & PP(6)(20) & PP(6)(19) & PP(6)(18) & PP(6)(17) & PP(6)(16) & PP(6)(15) & PP(6)(14) & PP(6)(13) & PP(6)(12) & PP(6)(11) & PP(6)(10) & PP(6)(9) & PP(6)(8) & PP(6)(7) & PP(6)(6) & PP(6)(5) & PP(6)(4) & PP(6)(3) & PP(6)(2) & PP(6)(1) & PP(6)(0) & PP_sign(5) ;
internal_0_7 <= PP(16)(11) & PP(16)(12) & PP(15)(12) & PP(15)(13) & PP(14)(20) & PP(14)(19) & PP(13)(20) & PP(13)(19) & PP(12)(20) & PP(12)(19) & PP(11)(20) & PP(11)(19) & PP(10)(20) & PP(10)(19) & PP(9)(20) & PP(9)(19) & PP(8)(20) & PP(7)(21) & PP(7)(20) & PP(7)(19) & PP(7)(18) & PP(7)(17) & PP(7)(16) & PP(7)(15) & PP(7)(14) & PP(7)(13) & PP(7)(12) & PP(7)(11) & PP(7)(10) & PP(7)(9) & PP(7)(8) & PP(7)(7) & PP(7)(6) & PP(7)(5) & PP(7)(4) & PP(7)(3) & PP(7)(2) & PP(7)(1) & PP(7)(0) & PP_sign(6) ;
internal_0_8 <= PP(16)(13) & PP(16)(14) & PP(15)(14) & PP(15)(15) & PP(14)(18) & PP(14)(17) & PP(13)(18) & PP(13)(17) & PP(12)(18) & PP(12)(17) & PP(11)(18) & PP(11)(17) & PP(10)(18) & PP(10)(17) & PP(9)(18) & PP(8)(19) & PP(8)(18) & PP(8)(17) & PP(8)(16) & PP(8)(15) & PP(8)(14) & PP(8)(13) & PP(8)(12) & PP(8)(11) & PP(8)(10) & PP(8)(9) & PP(8)(8) & PP(8)(7) & PP(8)(6) & PP(8)(5) & PP(8)(4) & PP(8)(3) & PP(8)(2) & PP(8)(1) & PP(8)(0) & PP_sign(7) ;
internal_0_9 <= PP(16)(15) & PP(16)(16) & PP(15)(16) & PP(15)(17) & PP(14)(16) & PP(14)(15) & PP(13)(16) & PP(13)(15) & PP(12)(16) & PP(12)(15) & PP(11)(16) & PP(11)(15) & PP(10)(16) & PP(9)(17) & PP(9)(16) & PP(9)(15) & PP(9)(14) & PP(9)(13) & PP(9)(12) & PP(9)(11) & PP(9)(10) & PP(9)(9) & PP(9)(8) & PP(9)(7) & PP(9)(6) & PP(9)(5) & PP(9)(4) & PP(9)(3) & PP(9)(2) & PP(9)(1) & PP(9)(0) & PP_sign(8) ;
internal_0_10 <= PP(16)(17) & PP(16)(18) & PP(15)(18) & PP(15)(19) & PP(14)(14) & PP(14)(13) & PP(13)(14) & PP(13)(13) & PP(12)(14) & PP(12)(13) & PP(11)(14) & PP(10)(15) & PP(10)(14) & PP(10)(13) & PP(10)(12) & PP(10)(11) & PP(10)(10) & PP(10)(9) & PP(10)(8) & PP(10)(7) & PP(10)(6) & PP(10)(5) & PP(10)(4) & PP(10)(3) & PP(10)(2) & PP(10)(1) & PP(10)(0) & PP_sign(9) ;
internal_0_11 <= PP(16)(19) & PP(16)(20) & PP(15)(20) & PP(15)(21) & PP(14)(12) & PP(14)(11) & PP(13)(12) & PP(13)(11) & PP(12)(12) & PP(11)(13) & PP(11)(12) & PP(11)(11) & PP(11)(10) & PP(11)(9) & PP(11)(8) & PP(11)(7) & PP(11)(6) & PP(11)(5) & PP(11)(4) & PP(11)(3) & PP(11)(2) & PP(11)(1) & PP(11)(0) & PP_sign(10) ;
internal_0_12 <= PP(16)(21) & PP(16)(22) & PP(15)(22) & PP(15)(23) & PP(14)(10) & PP(14)(9) & PP(13)(10) & PP(12)(11) & PP(12)(10) & PP(12)(9) & PP(12)(8) & PP(12)(7) & PP(12)(6) & PP(12)(5) & PP(12)(4) & PP(12)(3) & PP(12)(2) & PP(12)(1) & PP(12)(0) & PP_sign(11) ;
internal_0_13 <= PP(16)(23) & PP(16)(24) & PP(15)(24) & PP(15)(25) & PP(14)(8) & PP(13)(9) & PP(13)(8) & PP(13)(7) & PP(13)(6) & PP(13)(5) & PP(13)(4) & PP(13)(3) & PP(13)(2) & PP(13)(1) & PP(13)(0) & PP_sign(12) ;
internal_0_14 <= PP(16)(25) & PP(16)(26) & PP(15)(26) & PP(14)(7) & PP(14)(6) & PP(14)(5) & PP(14)(4) & PP(14)(3) & PP(14)(2) & PP(14)(1) & PP(14)(0) & PP_sign(13) ;
internal_0_15 <= PP(16)(27) & PP(15)(27) & PP(15)(28) & PP(15)(29) & PP(15)(30) & PP(15)(31) & PP(15)(32) & PP_sign(14) ;
internal_0_16 <= PP(16)(28) & PP(16)(29) & PP(16)(30) & PP(16)(31) & PP_sign(16) ;
CSA_1 : CSA generic map(17)
            port map(internal_0_0( 39 downto 23 ), internal_0_1( 37 downto 21 ), internal_0_2( 35 downto 19 ), internal_1_0( 39 downto 23 ), internal_1_1( 36 downto 20 ));
CSA_2 : CSA generic map(13)
            port map(internal_0_3( 31 downto 19 ), internal_0_4( 29 downto 17 ), internal_0_5( 27 downto 15 ), internal_1_1( 35 downto 23 ), internal_1_2( 32 downto 20 ));
CSA_3 : CSA generic map(9)
            port map(internal_0_6( 23 downto 15 ), internal_0_7( 21 downto 13 ), internal_0_8( 19 downto 11 ), internal_1_2( 31 downto 23 ), internal_1_3( 28 downto 20 ));
CSA_4 : CSA generic map(5)
            port map(internal_0_9( 15 downto 11 ), internal_0_10( 13 downto 9 ), internal_0_11( 11 downto 7 ), internal_1_3( 27 downto 23 ), internal_1_4( 24 downto 20 ));
HA_1 : HA port map(internal_0_0( 22 ), internal_0_1( 22 ), internal_1_0( 22 ), internal_1_1( 19 ));
HA_2 : HA port map(internal_0_0( 24 ), internal_0_1( 24 ), internal_1_0( 24 ), internal_1_1( 21 ));
HA_3 : HA port map(internal_0_0( 26 ), internal_0_1( 26 ), internal_1_0( 26 ), internal_1_1( 23 ));
HA_4 : HA port map(internal_0_0( 28 ), internal_0_1( 28 ), internal_1_0( 28 ), internal_1_1( 25 ));
HA_5 : HA port map(internal_0_0( 33 ), internal_0_1( 33 ), internal_1_0( 33 ), internal_1_1( 30 ));
HA_6 : HA port map(internal_0_0( 34 ), internal_0_1( 34 ), internal_1_0( 34 ), internal_1_1( 31 ));
HA_7 : HA port map(internal_0_0( 35 ), internal_0_1( 35 ), internal_1_0( 35 ), internal_1_1( 32 ));
HA_8 : HA port map(internal_0_0( 36 ), internal_0_1( 36 ), internal_1_0( 36 ), internal_1_1( 33 ));
HA_9 : HA port map(internal_0_0( 37 ), internal_0_1( 37 ), internal_1_0( 37 ), internal_1_1( 34 ));
HA_10 : HA port map(internal_0_0( 38 ), internal_0_1( 38 ), internal_1_0( 38 ), internal_1_1( 35 ));
HA_11 : HA port map(internal_0_0( 39 ), internal_0_1( 39 ), internal_1_0( 39 ), internal_1_1( 36 ));
HA_12 : HA port map(internal_0_0( 40 ), internal_0_1( 40 ), internal_1_0( 40 ), internal_1_1( 37 ));
CSA_5 : CSA generic map(33)
            port map(internal_1_0( 47 downto 15 ), internal_1_1( 45 downto 13 ), internal_1_2( 43 downto 11 ), internal_2_0( 47 downto 15 ), internal_2_1( 44 downto 12 ));
CSA_6 : CSA generic map(29)
            port map(internal_1_3( 39 downto 11 ), internal_1_4( 37 downto 9 ), internal_1_5( 35 downto 7 ), internal_2_1( 43 downto 15 ), internal_2_2( 40 downto 12 ));
CSA_7 : CSA generic map(25)
            port map(internal_1_6( 31 downto 7 ), internal_1_7( 29 downto 5 ), internal_1_8( 27 downto 3 ), internal_2_2( 39 downto 15 ), internal_2_3( 36 downto 12 ));
CSA_8 : CSA generic map(20)
            port map(internal_1_9( 23 downto 4 ), internal_1_10( 21 downto 2 ), internal_1_11( 19 downto 0 ), internal_2_3( 35 downto 16 ), internal_2_4( 32 downto 13 ));
HA_13 : HA port map(internal_1_0( 14 ), internal_1_1( 14 ), internal_2_0( 14 ), internal_2_1( 11 ));
HA_14 : HA port map(internal_1_0( 16 ), internal_1_1( 16 ), internal_2_0( 16 ), internal_2_1( 13 ));
HA_15 : HA port map(internal_1_0( 18 ), internal_1_1( 18 ), internal_2_0( 18 ), internal_2_1( 15 ));
HA_16 : HA port map(internal_1_0( 20 ), internal_1_1( 20 ), internal_2_0( 20 ), internal_2_1( 17 ));
HA_17 : HA port map(internal_1_0( 21 ), internal_1_1( 21 ), internal_2_0( 21 ), internal_2_1( 18 ));
HA_18 : HA port map(internal_1_0( 41 ), internal_1_1( 41 ), internal_2_0( 41 ), internal_2_1( 38 ));
HA_19 : HA port map(internal_1_0( 42 ), internal_1_1( 42 ), internal_2_0( 42 ), internal_2_1( 39 ));
HA_20 : HA port map(internal_1_0( 43 ), internal_1_1( 43 ), internal_2_0( 43 ), internal_2_1( 40 ));
HA_21 : HA port map(internal_1_0( 44 ), internal_1_1( 44 ), internal_2_0( 44 ), internal_2_1( 41 ));
HA_22 : HA port map(internal_1_0( 45 ), internal_1_1( 45 ), internal_2_0( 45 ), internal_2_1( 42 ));
HA_23 : HA port map(internal_1_0( 46 ), internal_1_1( 46 ), internal_2_0( 46 ), internal_2_1( 43 ));
HA_24 : HA port map(internal_1_0( 47 ), internal_1_1( 47 ), internal_2_0( 47 ), internal_2_1( 44 ));
HA_25 : HA port map(internal_1_0( 48 ), internal_1_1( 48 ), internal_2_0( 48 ), internal_2_1( 45 ));
CSA_9 : CSA generic map(45)
            port map(internal_2_0( 53 downto 9 ), internal_2_1( 51 downto 7 ), internal_2_2( 49 downto 5 ), internal_3_0( 53 downto 9 ), internal_3_1( 50 downto 6 ));
CSA_10 : CSA generic map(41)
            port map(internal_2_3( 45 downto 5 ), internal_2_4( 43 downto 3 ), internal_2_5( 41 downto 1 ), internal_3_1( 49 downto 9 ), internal_3_2( 46 downto 6 ));
CSA_11 : CSA generic map(36)
            port map(internal_2_6( 37 downto 2 ), internal_2_7( 35 downto 0 ), internal_2_8( 32 downto 3 ), internal_3_2( 45 downto 10 ), internal_3_3( 42 downto 7 ));
HA_26 : HA port map(internal_2_0( 8 ), internal_2_1( 8 ), internal_3_0( 8 ), internal_3_1( 5 ));
HA_27 : HA port map(internal_2_0( 10 ), internal_2_1( 10 ), internal_3_0( 10 ), internal_3_1( 7 ));
HA_28 : HA port map(internal_2_0( 12 ), internal_2_1( 12 ), internal_3_0( 12 ), internal_3_1( 9 ));
HA_29 : HA port map(internal_2_0( 13 ), internal_2_1( 13 ), internal_3_0( 13 ), internal_3_1( 10 ));
HA_30 : HA port map(internal_2_0( 49 ), internal_2_1( 49 ), internal_3_0( 49 ), internal_3_1( 46 ));
HA_31 : HA port map(internal_2_0( 50 ), internal_2_1( 50 ), internal_3_0( 50 ), internal_3_1( 47 ));
HA_32 : HA port map(internal_2_0( 51 ), internal_2_1( 51 ), internal_3_0( 51 ), internal_3_1( 48 ));
HA_33 : HA port map(internal_2_0( 52 ), internal_2_1( 52 ), internal_3_0( 52 ), internal_3_1( 49 ));
HA_34 : HA port map(internal_2_0( 53 ), internal_2_1( 53 ), internal_3_0( 53 ), internal_3_1( 50 ));
HA_35 : HA port map(internal_2_0( 54 ), internal_2_1( 54 ), internal_3_0( 54 ), internal_3_1( 51 ));
CSA_12 : CSA generic map(53)
            port map(internal_3_0( 57 downto 5 ), internal_3_1( 55 downto 3 ), internal_3_2( 53 downto 1 ), internal_4_0( 57 downto 5 ), internal_4_1( 54 downto 2 ));
CSA_13 : CSA generic map(48)
            port map(internal_3_3( 49 downto 2 ), internal_3_4( 47 downto 0 ), internal_3_5( 44 downto 3 ), internal_4_1( 53 downto 6 ), internal_4_2( 50 downto 3 ));
HA_36 : HA port map(internal_3_0( 4 ), internal_3_1( 4 ), internal_4_0( 4 ), internal_4_1( 1 ));
HA_37 : HA port map(internal_3_0( 6 ), internal_3_1( 6 ), internal_4_0( 6 ), internal_4_1( 3 ));
HA_38 : HA port map(internal_3_0( 7 ), internal_3_1( 7 ), internal_4_0( 7 ), internal_4_1( 4 ));
HA_39 : HA port map(internal_3_0( 55 ), internal_3_1( 55 ), internal_4_0( 55 ), internal_4_1( 52 ));
HA_40 : HA port map(internal_3_0( 56 ), internal_3_1( 56 ), internal_4_0( 56 ), internal_4_1( 53 ));
HA_41 : HA port map(internal_3_0( 57 ), internal_3_1( 57 ), internal_4_0( 57 ), internal_4_1( 54 ));
HA_42 : HA port map(internal_3_0( 58 ), internal_3_1( 58 ), internal_4_0( 58 ), internal_4_1( 55 ));
CSA_14 : CSA generic map(56)
            port map(internal_4_0( 59 downto 4 ), internal_4_1( 57 downto 2 ), internal_4_2( 55 downto 0 ), internal_5_0( 59 downto 4 ), internal_5_1( 56 downto 1 ));
HA_43 : HA port map(internal_4_0( 2 ), internal_4_1( 2 ), internal_5_0( 2 ), internal_5_1( 1 ));
HA_44 : HA port map(internal_4_0( 3 ), internal_4_1( 3 ), internal_5_0( 3 ), internal_5_1( 0 ));
HA_45 : HA port map(internal_4_0( 59 ), internal_4_1( 59 ), internal_5_0( 59 ), internal_5_1( 56 ));
HA_46 : HA port map(internal_4_0( 60 ), internal_4_1( 60 ), internal_5_0( 60 ), internal_5_1( 57 ));
CSA_15 : CSA generic map(60)
            port map(internal_5_0( 61 downto 2 ), internal_5_1( 59 downto 0 ), internal_5_2( 56 downto 3 ), internal_6_0( 61 downto 2 ), internal_6_1( 57 downto 2 ));
HA_47 : HA port map(internal_5_0( 1 ), internal_5_1( 1 ), internal_6_0( 1 ), internal_6_1( 3 ));
HA_48 : HA port map(internal_5_0( 61 ), internal_5_1( 61 ), internal_6_0( 61 ), internal_6_1( 57 ));
HA_49 : HA port map(internal_5_0( 62 ), internal_5_1( 62 ), internal_6_0( 62 ), internal_6_1( 58 ));


end architecture ;