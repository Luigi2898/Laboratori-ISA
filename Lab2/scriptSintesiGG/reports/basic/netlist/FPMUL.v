
module FPmul ( FP_A, FP_B, clk, FP_Z );
  input [31:0] FP_A;
  input [31:0] FP_B;
  output [31:0] FP_Z;
  input clk;
  wire   SIGN_out_stage1, isINF_stage1, isNaN_stage1, isZ_tab_stage1,
         EXP_neg_stage2, EXP_pos_stage2, SIGN_out_stage2, isINF_stage2,
         isNaN_stage2, isZ_tab_stage2, EXP_neg, EXP_pos, isINF_tab, isNaN,
         isZ_tab, I1_n4, I1_n3, I1_n2, I1_n1, I1_n8, I1_n7, I1_n6, I1_n5,
         I1_B_SIGN, I1_A_SIGN, I1_B_isZ, I1_B_isNaN, I1_B_isINF, I1_A_isZ,
         I1_A_isNaN, I1_A_isINF, I1_isZ_tab_int, I1_isNaN_int, I1_isINF_int,
         I1_SIGN_out_int, I1_I0_n5, I1_I0_n4, I1_I0_n1, I1_I0_n15, I1_I0_n14,
         I1_I0_n13, I1_I0_n12, I1_I0_n11, I1_I0_n10, I1_I0_n9, I1_I0_n8,
         I1_I0_n7, I1_I0_n6, I1_I0_n3, I1_I0_n2, I1_I0_isDN, I1_I1_n27,
         I1_I1_n26, I1_I1_n25, I1_I1_n24, I1_I1_n23, I1_I1_n22, I1_I1_n21,
         I1_I1_n20, I1_I1_n19, I1_I1_n18, I1_I1_n17, I1_I1_n16, I1_I1_n5,
         I1_I1_n4, I1_I1_n1, I1_I1_isDN, I2_n1, I2_n6, I2_n5, I2_n4, I2_n3,
         I2_n2, I2_N0, I2_SIGN_out_stage2_REG, I2_isZ_tab_stage2_REG,
         I2_isNaN_stage2_REG, I2_isINF_stage2_REG, I2_EXP_neg_stage2_REG,
         I2_EXP_pos_int, I2_EXP_pos_stage2_REG, I3_I9_n53, I3_I9_n52,
         I3_I9_n51, I3_I9_n50, I3_I9_n49, I3_I9_n48, I3_I9_n47, I3_I9_n46,
         I3_I9_n45, I3_I9_n44, I3_I9_n43, I3_I9_n42, I3_I9_n41, I3_I9_n40,
         I3_I9_n39, I3_I9_n38, I3_I9_n37, I3_I9_n36, I3_I9_n33, I3_I9_n32,
         I3_I9_n31, I3_I9_n30, I3_I9_n29, I3_I9_n28, I3_I9_n27, I3_I9_n24,
         I3_I9_n23, I3_I9_n22, I3_I9_n21, I3_I9_n20, I3_I9_n19, I3_I9_n18,
         I3_I9_n17, I3_I9_n16, I3_I9_n15, I3_I9_n6, I3_I9_n5, I3_I9_n4,
         I3_I9_n3, I3_I9_n2, I3_I9_n1, I3_I9_n35, I3_I9_n34, I3_I11_n9,
         I3_I11_n8, I3_I11_n7, I3_I11_n6, I3_I11_n5, I3_I11_n4, I3_I11_n3,
         I3_I11_n2, I3_I11_n1, I3_I11_n52, I3_I11_n51, I3_I11_n50, I3_I11_n49,
         I3_I11_n48, I3_I11_n47, I3_I11_n46, I3_I11_n45, I3_I11_n44,
         I3_I11_n43, I3_I11_n42, I3_I11_n41, I3_I11_n40, I3_I11_n39,
         I3_I11_n38, I3_I11_n37, I3_I11_n36, I3_I11_n35, I3_I11_n34,
         I3_I11_n33, I3_I11_n32, I3_I11_n31, I3_I11_n30, I3_I11_n29,
         I3_I11_n28, I3_I11_N26, I3_I11_N25, I3_I11_N24, I3_I11_N23,
         I3_I11_N22, I3_I11_N21, I3_I11_N20, I3_I11_N19, I3_I11_N18,
         I3_I11_N17, I3_I11_N16, I3_I11_N15, I3_I11_N14, I3_I11_N13,
         I3_I11_N12, I3_I11_N11, I3_I11_N10, I3_I11_N9, I3_I11_N8, I3_I11_N7,
         I3_I11_N6, I3_I11_N5, I3_I11_N4, I3_I11_N3, I3_I11_N2, I4_n2, I4_n1,
         I4_n16, I4_n15, I4_n14, I4_n13, I4_n12, I4_n11, I4_n10, I4_n9, I4_n8,
         I4_n7, I4_n6, I4_n5, I4_n4, I4_n3, I4_isINF, I4_EXP_out_0_,
         I4_EXP_out_1_, I4_EXP_out_2_, I4_EXP_out_3_, I4_EXP_out_4_,
         I4_EXP_out_5_, I4_EXP_out_6_, I4_EXP_out_7_, I4_SIG_out_0_,
         I4_SIG_out_1_, I4_SIG_out_2_, I4_SIG_out_3_, I4_SIG_out_4_,
         I4_SIG_out_5_, I4_SIG_out_6_, I4_SIG_out_7_, I4_SIG_out_8_,
         I4_SIG_out_9_, I4_SIG_out_10_, I4_SIG_out_11_, I4_SIG_out_12_,
         I4_SIG_out_13_, I4_SIG_out_14_, I4_SIG_out_15_, I4_SIG_out_16_,
         I4_SIG_out_17_, I4_SIG_out_18_, I4_SIG_out_19_, I4_SIG_out_20_,
         I4_SIG_out_21_, I4_SIG_out_22_, I4_SIG_out_norm2_26_, I4_I1_n55,
         I4_I1_n54, I4_I1_n53, I4_I1_n52, I4_I1_n51, I4_I1_n50, I4_I1_n49,
         I4_I1_n48, I4_I1_n47, I4_I1_n46, I4_I1_n45, I4_I1_n44, I4_I1_n43,
         I4_I1_n42, I4_I1_n41, I4_I1_n40, I4_I1_n39, I4_I1_n38, I4_I1_n37,
         I4_I1_n36, I4_I1_n33, I4_I1_n32, I4_I1_n31, I4_I1_n30, I4_I1_n29,
         I4_I1_n28, I4_I1_n27, I4_I1_SIG_out_0_, I4_I1_SIG_out_1_, I4_I1_n24,
         I4_I1_n23, I4_I1_n22, I4_I1_n21, I4_I1_n20, I4_I1_n19, I4_I1_n18,
         I4_I1_n17, I4_I1_n16, I4_I1_n15, I4_I1_n8, I4_I1_n7, I4_I1_n6,
         I4_I1_n5, I4_I1_n4, I4_I1_n3, I4_I1_SIG_out_2_, I4_I3_n15, I4_I3_n3,
         I4_I3_n2, I4_I3_n1, I4_I3_n14, I4_I3_n13, I4_I3_n12, I4_I3_n11,
         I4_I3_n10, I4_I3_n9, I4_I3_n8, I4_I3_n7, I4_I3_n6, I4_I3_n5, I4_I3_n4,
         SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4,
         SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6,
         SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8,
         SYNOPSYS_UNCONNECTED_9, SYNOPSYS_UNCONNECTED_10,
         SYNOPSYS_UNCONNECTED_11, SYNOPSYS_UNCONNECTED_12,
         SYNOPSYS_UNCONNECTED_13, SYNOPSYS_UNCONNECTED_14,
         SYNOPSYS_UNCONNECTED_15, SYNOPSYS_UNCONNECTED_16,
         SYNOPSYS_UNCONNECTED_17, SYNOPSYS_UNCONNECTED_18,
         SYNOPSYS_UNCONNECTED_19, SYNOPSYS_UNCONNECTED_20,
         SYNOPSYS_UNCONNECTED_21, SYNOPSYS_UNCONNECTED_22,
         SYNOPSYS_UNCONNECTED_23, SYNOPSYS_UNCONNECTED_24,
         SYNOPSYS_UNCONNECTED_25, SYNOPSYS_UNCONNECTED_26,
         SYNOPSYS_UNCONNECTED_27, SYNOPSYS_UNCONNECTED_28,
         SYNOPSYS_UNCONNECTED_29, SYNOPSYS_UNCONNECTED_30,
         SYNOPSYS_UNCONNECTED_31, SYNOPSYS_UNCONNECTED_32,
         SYNOPSYS_UNCONNECTED_33, SYNOPSYS_UNCONNECTED_34,
         SYNOPSYS_UNCONNECTED_35, SYNOPSYS_UNCONNECTED_36,
         SYNOPSYS_UNCONNECTED_37;
  wire   [7:0] A_EXP;
  wire   [23:0] A_SIG;
  wire   [7:0] B_EXP;
  wire   [23:0] B_SIG;
  wire   [7:0] EXP_in;
  wire   [27:0] SIG_in;
  wire   [7:0] EXP_out_round;
  wire   [27:0] SIG_out_round;
  wire   [23:0] I1_B_SIG_int;
  wire   [7:0] I1_B_EXP_int;
  wire   [23:0] I1_A_SIG_int;
  wire   [7:0] I1_A_EXP_int;
  wire   [7:0] I2_mw_I4sum;
  wire   [27:0] I2_SIG_in_REG;
  wire   [7:0] I2_EXP_in_REG;
  wire   [27:0] I2_SIG_in_int;
  wire   [7:1] I2_add_1_root_add_161_2_carry;
  wire   [27:0] I3_SIG_out_norm;
  wire   [27:0] I3_SIG_out;
  wire   [7:0] I3_EXP_out;
  wire   [24:2] I3_I11_add_45_carry;
  wire   [31:0] I4_FP;

  DFF_X1 FP_Ad1_reg_31_ ( .D(FP_A[31]), .CK(clk), .Q(I1_A_SIGN) );
  DFF_X1 FP_Ad1_reg_30_ ( .D(FP_A[30]), .CK(clk), .Q(I1_A_EXP_int[7]) );
  DFF_X1 FP_Ad1_reg_29_ ( .D(FP_A[29]), .CK(clk), .Q(I1_A_EXP_int[6]) );
  DFF_X1 FP_Ad1_reg_28_ ( .D(FP_A[28]), .CK(clk), .Q(I1_A_EXP_int[5]) );
  DFF_X1 FP_Ad1_reg_27_ ( .D(FP_A[27]), .CK(clk), .Q(I1_A_EXP_int[4]) );
  DFF_X1 FP_Ad1_reg_26_ ( .D(FP_A[26]), .CK(clk), .Q(I1_A_EXP_int[3]) );
  DFF_X1 FP_Ad1_reg_25_ ( .D(FP_A[25]), .CK(clk), .Q(I1_A_EXP_int[2]) );
  DFF_X1 FP_Ad1_reg_24_ ( .D(FP_A[24]), .CK(clk), .Q(I1_A_EXP_int[1]) );
  DFF_X1 FP_Ad1_reg_23_ ( .D(FP_A[23]), .CK(clk), .Q(I1_A_EXP_int[0]) );
  DFF_X1 FP_Ad1_reg_22_ ( .D(FP_A[22]), .CK(clk), .Q(I1_A_SIG_int[22]) );
  DFF_X1 FP_Ad1_reg_21_ ( .D(FP_A[21]), .CK(clk), .Q(I1_A_SIG_int[21]) );
  DFF_X1 FP_Ad1_reg_20_ ( .D(FP_A[20]), .CK(clk), .Q(I1_A_SIG_int[20]) );
  DFF_X1 FP_Ad1_reg_19_ ( .D(FP_A[19]), .CK(clk), .Q(I1_A_SIG_int[19]) );
  DFF_X1 FP_Ad1_reg_18_ ( .D(FP_A[18]), .CK(clk), .Q(I1_A_SIG_int[18]) );
  DFF_X1 FP_Ad1_reg_17_ ( .D(FP_A[17]), .CK(clk), .Q(I1_A_SIG_int[17]) );
  DFF_X1 FP_Ad1_reg_16_ ( .D(FP_A[16]), .CK(clk), .Q(I1_A_SIG_int[16]) );
  DFF_X1 FP_Ad1_reg_15_ ( .D(FP_A[15]), .CK(clk), .Q(I1_A_SIG_int[15]) );
  DFF_X1 FP_Ad1_reg_14_ ( .D(FP_A[14]), .CK(clk), .Q(I1_A_SIG_int[14]) );
  DFF_X1 FP_Ad1_reg_13_ ( .D(FP_A[13]), .CK(clk), .Q(I1_A_SIG_int[13]) );
  DFF_X1 FP_Ad1_reg_12_ ( .D(FP_A[12]), .CK(clk), .Q(I1_A_SIG_int[12]) );
  DFF_X1 FP_Ad1_reg_11_ ( .D(FP_A[11]), .CK(clk), .Q(I1_A_SIG_int[11]) );
  DFF_X1 FP_Ad1_reg_10_ ( .D(FP_A[10]), .CK(clk), .Q(I1_A_SIG_int[10]) );
  DFF_X1 FP_Ad1_reg_9_ ( .D(FP_A[9]), .CK(clk), .Q(I1_A_SIG_int[9]) );
  DFF_X1 FP_Ad1_reg_8_ ( .D(FP_A[8]), .CK(clk), .Q(I1_A_SIG_int[8]) );
  DFF_X1 FP_Ad1_reg_7_ ( .D(FP_A[7]), .CK(clk), .Q(I1_A_SIG_int[7]) );
  DFF_X1 FP_Ad1_reg_6_ ( .D(FP_A[6]), .CK(clk), .Q(I1_A_SIG_int[6]) );
  DFF_X1 FP_Ad1_reg_5_ ( .D(FP_A[5]), .CK(clk), .Q(I1_A_SIG_int[5]) );
  DFF_X1 FP_Ad1_reg_4_ ( .D(FP_A[4]), .CK(clk), .Q(I1_A_SIG_int[4]) );
  DFF_X1 FP_Ad1_reg_3_ ( .D(FP_A[3]), .CK(clk), .Q(I1_A_SIG_int[3]) );
  DFF_X1 FP_Ad1_reg_2_ ( .D(FP_A[2]), .CK(clk), .Q(I1_A_SIG_int[2]) );
  DFF_X1 FP_Ad1_reg_1_ ( .D(FP_A[1]), .CK(clk), .Q(I1_A_SIG_int[1]) );
  DFF_X1 FP_Ad1_reg_0_ ( .D(FP_A[0]), .CK(clk), .Q(I1_A_SIG_int[0]) );
  DFF_X1 FP_Bd1_reg_31_ ( .D(FP_B[31]), .CK(clk), .Q(I1_B_SIGN) );
  DFF_X1 FP_Bd1_reg_30_ ( .D(FP_B[30]), .CK(clk), .Q(I1_B_EXP_int[7]) );
  DFF_X1 FP_Bd1_reg_29_ ( .D(FP_B[29]), .CK(clk), .Q(I1_B_EXP_int[6]) );
  DFF_X1 FP_Bd1_reg_28_ ( .D(FP_B[28]), .CK(clk), .Q(I1_B_EXP_int[5]) );
  DFF_X1 FP_Bd1_reg_27_ ( .D(FP_B[27]), .CK(clk), .Q(I1_B_EXP_int[4]) );
  DFF_X1 FP_Bd1_reg_26_ ( .D(FP_B[26]), .CK(clk), .Q(I1_B_EXP_int[3]) );
  DFF_X1 FP_Bd1_reg_25_ ( .D(FP_B[25]), .CK(clk), .Q(I1_B_EXP_int[2]) );
  DFF_X1 FP_Bd1_reg_24_ ( .D(FP_B[24]), .CK(clk), .Q(I1_B_EXP_int[1]) );
  DFF_X1 FP_Bd1_reg_23_ ( .D(FP_B[23]), .CK(clk), .Q(I1_B_EXP_int[0]) );
  DFF_X1 FP_Bd1_reg_22_ ( .D(FP_B[22]), .CK(clk), .Q(I1_B_SIG_int[22]) );
  DFF_X1 FP_Bd1_reg_21_ ( .D(FP_B[21]), .CK(clk), .Q(I1_B_SIG_int[21]) );
  DFF_X1 FP_Bd1_reg_20_ ( .D(FP_B[20]), .CK(clk), .Q(I1_B_SIG_int[20]) );
  DFF_X1 FP_Bd1_reg_19_ ( .D(FP_B[19]), .CK(clk), .Q(I1_B_SIG_int[19]) );
  DFF_X1 FP_Bd1_reg_18_ ( .D(FP_B[18]), .CK(clk), .Q(I1_B_SIG_int[18]) );
  DFF_X1 FP_Bd1_reg_17_ ( .D(FP_B[17]), .CK(clk), .Q(I1_B_SIG_int[17]) );
  DFF_X1 FP_Bd1_reg_16_ ( .D(FP_B[16]), .CK(clk), .Q(I1_B_SIG_int[16]) );
  DFF_X1 FP_Bd1_reg_15_ ( .D(FP_B[15]), .CK(clk), .Q(I1_B_SIG_int[15]) );
  DFF_X1 FP_Bd1_reg_14_ ( .D(FP_B[14]), .CK(clk), .Q(I1_B_SIG_int[14]) );
  DFF_X1 FP_Bd1_reg_13_ ( .D(FP_B[13]), .CK(clk), .Q(I1_B_SIG_int[13]) );
  DFF_X1 FP_Bd1_reg_12_ ( .D(FP_B[12]), .CK(clk), .Q(I1_B_SIG_int[12]) );
  DFF_X1 FP_Bd1_reg_11_ ( .D(FP_B[11]), .CK(clk), .Q(I1_B_SIG_int[11]) );
  DFF_X1 FP_Bd1_reg_10_ ( .D(FP_B[10]), .CK(clk), .Q(I1_B_SIG_int[10]) );
  DFF_X1 FP_Bd1_reg_9_ ( .D(FP_B[9]), .CK(clk), .Q(I1_B_SIG_int[9]) );
  DFF_X1 FP_Bd1_reg_8_ ( .D(FP_B[8]), .CK(clk), .Q(I1_B_SIG_int[8]) );
  DFF_X1 FP_Bd1_reg_7_ ( .D(FP_B[7]), .CK(clk), .Q(I1_B_SIG_int[7]) );
  DFF_X1 FP_Bd1_reg_6_ ( .D(FP_B[6]), .CK(clk), .Q(I1_B_SIG_int[6]) );
  DFF_X1 FP_Bd1_reg_5_ ( .D(FP_B[5]), .CK(clk), .Q(I1_B_SIG_int[5]) );
  DFF_X1 FP_Bd1_reg_4_ ( .D(FP_B[4]), .CK(clk), .Q(I1_B_SIG_int[4]) );
  DFF_X1 FP_Bd1_reg_3_ ( .D(FP_B[3]), .CK(clk), .Q(I1_B_SIG_int[3]) );
  DFF_X1 FP_Bd1_reg_2_ ( .D(FP_B[2]), .CK(clk), .Q(I1_B_SIG_int[2]) );
  DFF_X1 FP_Bd1_reg_1_ ( .D(FP_B[1]), .CK(clk), .Q(I1_B_SIG_int[1]) );
  DFF_X1 FP_Bd1_reg_0_ ( .D(FP_B[0]), .CK(clk), .Q(I1_B_SIG_int[0]) );
  AOI22_X1 I1_U13 ( .A1(I1_A_isINF), .A2(I1_n4), .B1(I1_B_isINF), .B2(I1_n1), 
        .ZN(I1_n8) );
  INV_X1 I1_U12 ( .A(I1_n7), .ZN(I1_n3) );
  NOR2_X1 I1_U11 ( .A1(I1_n3), .A2(I1_n8), .ZN(I1_isINF_int) );
  INV_X1 I1_U10 ( .A(I1_A_isINF), .ZN(I1_n2) );
  INV_X1 I1_U9 ( .A(I1_A_isZ), .ZN(I1_n1) );
  NAND2_X1 I1_U8 ( .A1(I1_B_isZ), .A2(I1_A_isINF), .ZN(I1_n7) );
  INV_X1 I1_U7 ( .A(I1_B_isINF), .ZN(I1_n4) );
  OAI211_X1 I1_U6 ( .C1(I1_A_isNaN), .C2(I1_B_isNaN), .A(I1_n2), .B(I1_n4), 
        .ZN(I1_n6) );
  OAI211_X1 I1_U5 ( .C1(I1_n4), .C2(I1_n1), .A(I1_n6), .B(I1_n7), .ZN(
        I1_isNaN_int) );
  OAI21_X1 I1_U4 ( .B1(I1_A_isZ), .B2(I1_B_isZ), .A(I1_n2), .ZN(I1_n5) );
  NOR4_X1 I1_U3 ( .A1(I1_n5), .A2(I1_A_isNaN), .A3(I1_B_isNaN), .A4(I1_B_isINF), .ZN(I1_isZ_tab_int) );
  XOR2_X1 I1_U14 ( .A(I1_B_SIGN), .B(I1_A_SIGN), .Z(I1_SIGN_out_int) );
  DFF_X1 I1_B_SIG_reg_0_ ( .D(I1_B_SIG_int[0]), .CK(clk), .Q(B_SIG[0]) );
  DFF_X1 I1_B_SIG_reg_1_ ( .D(I1_B_SIG_int[1]), .CK(clk), .Q(B_SIG[1]) );
  DFF_X1 I1_B_SIG_reg_2_ ( .D(I1_B_SIG_int[2]), .CK(clk), .Q(B_SIG[2]) );
  DFF_X1 I1_B_SIG_reg_3_ ( .D(I1_B_SIG_int[3]), .CK(clk), .Q(B_SIG[3]) );
  DFF_X1 I1_B_SIG_reg_4_ ( .D(I1_B_SIG_int[4]), .CK(clk), .Q(B_SIG[4]) );
  DFF_X1 I1_B_SIG_reg_5_ ( .D(I1_B_SIG_int[5]), .CK(clk), .Q(B_SIG[5]) );
  DFF_X1 I1_B_SIG_reg_6_ ( .D(I1_B_SIG_int[6]), .CK(clk), .Q(B_SIG[6]) );
  DFF_X1 I1_B_SIG_reg_7_ ( .D(I1_B_SIG_int[7]), .CK(clk), .Q(B_SIG[7]) );
  DFF_X1 I1_B_SIG_reg_8_ ( .D(I1_B_SIG_int[8]), .CK(clk), .Q(B_SIG[8]) );
  DFF_X1 I1_B_SIG_reg_9_ ( .D(I1_B_SIG_int[9]), .CK(clk), .Q(B_SIG[9]) );
  DFF_X1 I1_B_SIG_reg_10_ ( .D(I1_B_SIG_int[10]), .CK(clk), .Q(B_SIG[10]) );
  DFF_X1 I1_B_SIG_reg_11_ ( .D(I1_B_SIG_int[11]), .CK(clk), .Q(B_SIG[11]) );
  DFF_X1 I1_B_SIG_reg_12_ ( .D(I1_B_SIG_int[12]), .CK(clk), .Q(B_SIG[12]) );
  DFF_X1 I1_B_SIG_reg_13_ ( .D(I1_B_SIG_int[13]), .CK(clk), .Q(B_SIG[13]) );
  DFF_X1 I1_B_SIG_reg_14_ ( .D(I1_B_SIG_int[14]), .CK(clk), .Q(B_SIG[14]) );
  DFF_X1 I1_B_SIG_reg_15_ ( .D(I1_B_SIG_int[15]), .CK(clk), .Q(B_SIG[15]) );
  DFF_X1 I1_B_SIG_reg_16_ ( .D(I1_B_SIG_int[16]), .CK(clk), .Q(B_SIG[16]) );
  DFF_X1 I1_B_SIG_reg_17_ ( .D(I1_B_SIG_int[17]), .CK(clk), .Q(B_SIG[17]) );
  DFF_X1 I1_B_SIG_reg_18_ ( .D(I1_B_SIG_int[18]), .CK(clk), .Q(B_SIG[18]) );
  DFF_X1 I1_B_SIG_reg_19_ ( .D(I1_B_SIG_int[19]), .CK(clk), .Q(B_SIG[19]) );
  DFF_X1 I1_B_SIG_reg_20_ ( .D(I1_B_SIG_int[20]), .CK(clk), .Q(B_SIG[20]) );
  DFF_X1 I1_B_SIG_reg_21_ ( .D(I1_B_SIG_int[21]), .CK(clk), .Q(B_SIG[21]) );
  DFF_X1 I1_B_SIG_reg_22_ ( .D(I1_B_SIG_int[22]), .CK(clk), .Q(B_SIG[22]) );
  DFF_X1 I1_B_SIG_reg_23_ ( .D(I1_B_SIG_int[23]), .CK(clk), .Q(B_SIG[23]) );
  DFF_X1 I1_B_EXP_reg_0_ ( .D(I1_B_EXP_int[0]), .CK(clk), .Q(B_EXP[0]) );
  DFF_X1 I1_B_EXP_reg_1_ ( .D(I1_B_EXP_int[1]), .CK(clk), .Q(B_EXP[1]) );
  DFF_X1 I1_B_EXP_reg_2_ ( .D(I1_B_EXP_int[2]), .CK(clk), .Q(B_EXP[2]) );
  DFF_X1 I1_B_EXP_reg_3_ ( .D(I1_B_EXP_int[3]), .CK(clk), .Q(B_EXP[3]) );
  DFF_X1 I1_B_EXP_reg_4_ ( .D(I1_B_EXP_int[4]), .CK(clk), .Q(B_EXP[4]) );
  DFF_X1 I1_B_EXP_reg_5_ ( .D(I1_B_EXP_int[5]), .CK(clk), .Q(B_EXP[5]) );
  DFF_X1 I1_B_EXP_reg_6_ ( .D(I1_B_EXP_int[6]), .CK(clk), .Q(B_EXP[6]) );
  DFF_X1 I1_B_EXP_reg_7_ ( .D(I1_B_EXP_int[7]), .CK(clk), .Q(B_EXP[7]) );
  DFF_X1 I1_isZ_tab_stage1_reg ( .D(I1_isZ_tab_int), .CK(clk), .Q(
        isZ_tab_stage1) );
  DFF_X1 I1_isNaN_stage1_reg ( .D(I1_isNaN_int), .CK(clk), .Q(isNaN_stage1) );
  DFF_X1 I1_isINF_stage1_reg ( .D(I1_isINF_int), .CK(clk), .Q(isINF_stage1) );
  DFF_X1 I1_A_SIG_reg_0_ ( .D(I1_A_SIG_int[0]), .CK(clk), .Q(A_SIG[0]) );
  DFF_X1 I1_A_SIG_reg_1_ ( .D(I1_A_SIG_int[1]), .CK(clk), .Q(A_SIG[1]) );
  DFF_X1 I1_A_SIG_reg_2_ ( .D(I1_A_SIG_int[2]), .CK(clk), .Q(A_SIG[2]) );
  DFF_X1 I1_A_SIG_reg_3_ ( .D(I1_A_SIG_int[3]), .CK(clk), .Q(A_SIG[3]) );
  DFF_X1 I1_A_SIG_reg_4_ ( .D(I1_A_SIG_int[4]), .CK(clk), .Q(A_SIG[4]) );
  DFF_X1 I1_A_SIG_reg_5_ ( .D(I1_A_SIG_int[5]), .CK(clk), .Q(A_SIG[5]) );
  DFF_X1 I1_A_SIG_reg_6_ ( .D(I1_A_SIG_int[6]), .CK(clk), .Q(A_SIG[6]) );
  DFF_X1 I1_A_SIG_reg_7_ ( .D(I1_A_SIG_int[7]), .CK(clk), .Q(A_SIG[7]) );
  DFF_X1 I1_A_SIG_reg_8_ ( .D(I1_A_SIG_int[8]), .CK(clk), .Q(A_SIG[8]) );
  DFF_X1 I1_A_SIG_reg_9_ ( .D(I1_A_SIG_int[9]), .CK(clk), .Q(A_SIG[9]) );
  DFF_X1 I1_A_SIG_reg_10_ ( .D(I1_A_SIG_int[10]), .CK(clk), .Q(A_SIG[10]) );
  DFF_X1 I1_A_SIG_reg_11_ ( .D(I1_A_SIG_int[11]), .CK(clk), .Q(A_SIG[11]) );
  DFF_X1 I1_A_SIG_reg_12_ ( .D(I1_A_SIG_int[12]), .CK(clk), .Q(A_SIG[12]) );
  DFF_X1 I1_A_SIG_reg_13_ ( .D(I1_A_SIG_int[13]), .CK(clk), .Q(A_SIG[13]) );
  DFF_X1 I1_A_SIG_reg_14_ ( .D(I1_A_SIG_int[14]), .CK(clk), .Q(A_SIG[14]) );
  DFF_X1 I1_A_SIG_reg_15_ ( .D(I1_A_SIG_int[15]), .CK(clk), .Q(A_SIG[15]) );
  DFF_X1 I1_A_SIG_reg_16_ ( .D(I1_A_SIG_int[16]), .CK(clk), .Q(A_SIG[16]) );
  DFF_X1 I1_A_SIG_reg_17_ ( .D(I1_A_SIG_int[17]), .CK(clk), .Q(A_SIG[17]) );
  DFF_X1 I1_A_SIG_reg_18_ ( .D(I1_A_SIG_int[18]), .CK(clk), .Q(A_SIG[18]) );
  DFF_X1 I1_A_SIG_reg_19_ ( .D(I1_A_SIG_int[19]), .CK(clk), .Q(A_SIG[19]) );
  DFF_X1 I1_A_SIG_reg_20_ ( .D(I1_A_SIG_int[20]), .CK(clk), .Q(A_SIG[20]) );
  DFF_X1 I1_A_SIG_reg_21_ ( .D(I1_A_SIG_int[21]), .CK(clk), .Q(A_SIG[21]) );
  DFF_X1 I1_A_SIG_reg_22_ ( .D(I1_A_SIG_int[22]), .CK(clk), .Q(A_SIG[22]) );
  DFF_X1 I1_A_SIG_reg_23_ ( .D(I1_A_SIG_int[23]), .CK(clk), .Q(A_SIG[23]) );
  DFF_X1 I1_A_EXP_reg_0_ ( .D(I1_A_EXP_int[0]), .CK(clk), .Q(A_EXP[0]) );
  DFF_X1 I1_A_EXP_reg_1_ ( .D(I1_A_EXP_int[1]), .CK(clk), .Q(A_EXP[1]) );
  DFF_X1 I1_A_EXP_reg_2_ ( .D(I1_A_EXP_int[2]), .CK(clk), .Q(A_EXP[2]) );
  DFF_X1 I1_A_EXP_reg_3_ ( .D(I1_A_EXP_int[3]), .CK(clk), .Q(A_EXP[3]) );
  DFF_X1 I1_A_EXP_reg_4_ ( .D(I1_A_EXP_int[4]), .CK(clk), .Q(A_EXP[4]) );
  DFF_X1 I1_A_EXP_reg_5_ ( .D(I1_A_EXP_int[5]), .CK(clk), .Q(A_EXP[5]) );
  DFF_X1 I1_A_EXP_reg_6_ ( .D(I1_A_EXP_int[6]), .CK(clk), .Q(A_EXP[6]) );
  DFF_X1 I1_A_EXP_reg_7_ ( .D(I1_A_EXP_int[7]), .CK(clk), .Q(A_EXP[7]) );
  DFF_X1 I1_SIGN_out_stage1_reg ( .D(I1_SIGN_out_int), .CK(clk), .Q(
        SIGN_out_stage1) );
  OR2_X1 I1_I0_U21 ( .A1(I1_A_SIG_int[10]), .A2(I1_A_SIG_int[0]), .ZN(
        I1_I0_n13) );
  OR3_X1 I1_I0_U20 ( .A1(I1_A_SIG_int[19]), .A2(I1_A_SIG_int[18]), .A3(
        I1_A_SIG_int[17]), .ZN(I1_I0_n12) );
  OR3_X1 I1_I0_U19 ( .A1(I1_A_SIG_int[3]), .A2(I1_A_SIG_int[2]), .A3(
        I1_A_SIG_int[22]), .ZN(I1_I0_n11) );
  NAND4_X1 I1_I0_U18 ( .A1(I1_A_EXP_int[0]), .A2(I1_A_EXP_int[1]), .A3(
        I1_A_EXP_int[2]), .A4(I1_A_EXP_int[3]), .ZN(I1_I0_n4) );
  NAND4_X1 I1_I0_U17 ( .A1(I1_A_EXP_int[4]), .A2(I1_A_EXP_int[5]), .A3(
        I1_A_EXP_int[6]), .A4(I1_A_EXP_int[7]), .ZN(I1_I0_n1) );
  OR2_X1 I1_I0_U16 ( .A1(I1_I0_n1), .A2(I1_I0_n4), .ZN(I1_I0_n3) );
  NOR4_X1 I1_I0_U15 ( .A1(I1_A_EXP_int[7]), .A2(I1_A_EXP_int[6]), .A3(
        I1_A_EXP_int[5]), .A4(I1_A_EXP_int[4]), .ZN(I1_I0_n15) );
  NOR4_X1 I1_I0_U14 ( .A1(I1_A_EXP_int[3]), .A2(I1_A_EXP_int[2]), .A3(
        I1_A_EXP_int[1]), .A4(I1_A_EXP_int[0]), .ZN(I1_I0_n14) );
  NAND2_X1 I1_I0_U13 ( .A1(I1_I0_n14), .A2(I1_I0_n15), .ZN(I1_A_SIG_int[23])
         );
  NOR4_X1 I1_I0_U12 ( .A1(I1_I0_n11), .A2(I1_A_SIG_int[1]), .A3(
        I1_A_SIG_int[21]), .A4(I1_A_SIG_int[20]), .ZN(I1_I0_n8) );
  NOR4_X1 I1_I0_U11 ( .A1(I1_I0_n12), .A2(I1_A_SIG_int[14]), .A3(
        I1_A_SIG_int[16]), .A4(I1_A_SIG_int[15]), .ZN(I1_I0_n7) );
  NOR4_X1 I1_I0_U10 ( .A1(I1_I0_n13), .A2(I1_A_SIG_int[11]), .A3(
        I1_A_SIG_int[13]), .A4(I1_A_SIG_int[12]), .ZN(I1_I0_n6) );
  NAND4_X1 I1_I0_U9 ( .A1(I1_I0_n6), .A2(I1_I0_n7), .A3(I1_I0_n8), .A4(
        I1_I0_n9), .ZN(I1_I0_n2) );
  OR3_X1 I1_I0_U8 ( .A1(I1_A_SIG_int[9]), .A2(I1_A_SIG_int[8]), .A3(
        I1_A_SIG_int[7]), .ZN(I1_I0_n10) );
  NOR4_X1 I1_I0_U7 ( .A1(I1_I0_n10), .A2(I1_A_SIG_int[4]), .A3(I1_A_SIG_int[6]), .A4(I1_A_SIG_int[5]), .ZN(I1_I0_n9) );
  NOR2_X1 I1_I0_U6 ( .A1(I1_A_SIG_int[23]), .A2(I1_I0_n5), .ZN(I1_I0_isDN) );
  INV_X1 I1_I0_U5 ( .A(I1_I0_n2), .ZN(I1_I0_n5) );
  NOR2_X1 I1_I0_U4 ( .A1(I1_I0_n5), .A2(I1_I0_n3), .ZN(I1_A_isNaN) );
  NOR2_X1 I1_I0_U3 ( .A1(I1_A_SIG_int[23]), .A2(I1_I0_n2), .ZN(I1_A_isZ) );
  NOR2_X1 I1_I0_U2 ( .A1(I1_I0_n2), .A2(I1_I0_n3), .ZN(I1_A_isINF) );
  OR2_X1 I1_I1_U21 ( .A1(I1_B_SIG_int[10]), .A2(I1_B_SIG_int[0]), .ZN(
        I1_I1_n18) );
  OR3_X1 I1_I1_U20 ( .A1(I1_B_SIG_int[19]), .A2(I1_B_SIG_int[18]), .A3(
        I1_B_SIG_int[17]), .ZN(I1_I1_n19) );
  OR3_X1 I1_I1_U19 ( .A1(I1_B_SIG_int[3]), .A2(I1_B_SIG_int[2]), .A3(
        I1_B_SIG_int[22]), .ZN(I1_I1_n20) );
  NAND4_X1 I1_I1_U18 ( .A1(I1_B_EXP_int[0]), .A2(I1_B_EXP_int[1]), .A3(
        I1_B_EXP_int[2]), .A4(I1_B_EXP_int[3]), .ZN(I1_I1_n4) );
  NAND4_X1 I1_I1_U17 ( .A1(I1_B_EXP_int[4]), .A2(I1_B_EXP_int[5]), .A3(
        I1_B_EXP_int[6]), .A4(I1_B_EXP_int[7]), .ZN(I1_I1_n1) );
  OR2_X1 I1_I1_U16 ( .A1(I1_I1_n1), .A2(I1_I1_n4), .ZN(I1_I1_n26) );
  NOR4_X1 I1_I1_U15 ( .A1(I1_B_EXP_int[7]), .A2(I1_B_EXP_int[6]), .A3(
        I1_B_EXP_int[5]), .A4(I1_B_EXP_int[4]), .ZN(I1_I1_n16) );
  NOR4_X1 I1_I1_U14 ( .A1(I1_B_EXP_int[3]), .A2(I1_B_EXP_int[2]), .A3(
        I1_B_EXP_int[1]), .A4(I1_B_EXP_int[0]), .ZN(I1_I1_n17) );
  NAND2_X1 I1_I1_U13 ( .A1(I1_I1_n17), .A2(I1_I1_n16), .ZN(I1_B_SIG_int[23])
         );
  NOR4_X1 I1_I1_U12 ( .A1(I1_I1_n20), .A2(I1_B_SIG_int[1]), .A3(
        I1_B_SIG_int[21]), .A4(I1_B_SIG_int[20]), .ZN(I1_I1_n23) );
  NOR4_X1 I1_I1_U11 ( .A1(I1_I1_n19), .A2(I1_B_SIG_int[14]), .A3(
        I1_B_SIG_int[16]), .A4(I1_B_SIG_int[15]), .ZN(I1_I1_n24) );
  NOR4_X1 I1_I1_U10 ( .A1(I1_I1_n18), .A2(I1_B_SIG_int[11]), .A3(
        I1_B_SIG_int[13]), .A4(I1_B_SIG_int[12]), .ZN(I1_I1_n25) );
  NAND4_X1 I1_I1_U9 ( .A1(I1_I1_n25), .A2(I1_I1_n24), .A3(I1_I1_n23), .A4(
        I1_I1_n22), .ZN(I1_I1_n27) );
  OR3_X1 I1_I1_U8 ( .A1(I1_B_SIG_int[9]), .A2(I1_B_SIG_int[8]), .A3(
        I1_B_SIG_int[7]), .ZN(I1_I1_n21) );
  NOR4_X1 I1_I1_U7 ( .A1(I1_I1_n21), .A2(I1_B_SIG_int[4]), .A3(I1_B_SIG_int[6]), .A4(I1_B_SIG_int[5]), .ZN(I1_I1_n22) );
  NOR2_X1 I1_I1_U6 ( .A1(I1_B_SIG_int[23]), .A2(I1_I1_n5), .ZN(I1_I1_isDN) );
  INV_X1 I1_I1_U5 ( .A(I1_I1_n27), .ZN(I1_I1_n5) );
  NOR2_X1 I1_I1_U4 ( .A1(I1_I1_n5), .A2(I1_I1_n26), .ZN(I1_B_isNaN) );
  NOR2_X1 I1_I1_U3 ( .A1(I1_B_SIG_int[23]), .A2(I1_I1_n27), .ZN(I1_B_isZ) );
  NOR2_X1 I1_I1_U2 ( .A1(I1_I1_n27), .A2(I1_I1_n26), .ZN(I1_B_isINF) );
  AND2_X1 I2_U8 ( .A1(A_EXP[7]), .A2(B_EXP[7]), .ZN(I2_EXP_pos_int) );
  NAND4_X1 I2_U7 ( .A1(B_EXP[3]), .A2(B_EXP[2]), .A3(B_EXP[1]), .A4(B_EXP[0]), 
        .ZN(I2_n3) );
  NAND4_X1 I2_U6 ( .A1(A_EXP[3]), .A2(A_EXP[2]), .A3(A_EXP[1]), .A4(A_EXP[0]), 
        .ZN(I2_n5) );
  OAI22_X1 I2_U5 ( .A1(I2_n3), .A2(I2_n4), .B1(I2_n5), .B2(I2_n6), .ZN(I2_n2)
         );
  NOR3_X1 I2_U4 ( .A1(I2_n2), .A2(B_EXP[7]), .A3(A_EXP[7]), .ZN(I2_N0) );
  INV_X1 I2_U3 ( .A(I2_mw_I4sum[7]), .ZN(I2_n1) );
  MBE_mult_uns I2_mbe_mult ( .IN_A({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, A_SIG}), .IN_B({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        B_SIG}), .OUT_MPY({SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2, 
        SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4, SYNOPSYS_UNCONNECTED_5, 
        SYNOPSYS_UNCONNECTED_6, SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8, 
        SYNOPSYS_UNCONNECTED_9, SYNOPSYS_UNCONNECTED_10, 
        SYNOPSYS_UNCONNECTED_11, SYNOPSYS_UNCONNECTED_12, 
        SYNOPSYS_UNCONNECTED_13, SYNOPSYS_UNCONNECTED_14, 
        SYNOPSYS_UNCONNECTED_15, SYNOPSYS_UNCONNECTED_16, 
        SYNOPSYS_UNCONNECTED_17, I2_SIG_in_int, SYNOPSYS_UNCONNECTED_18, 
        SYNOPSYS_UNCONNECTED_19, SYNOPSYS_UNCONNECTED_20, 
        SYNOPSYS_UNCONNECTED_21, SYNOPSYS_UNCONNECTED_22, 
        SYNOPSYS_UNCONNECTED_23, SYNOPSYS_UNCONNECTED_24, 
        SYNOPSYS_UNCONNECTED_25, SYNOPSYS_UNCONNECTED_26, 
        SYNOPSYS_UNCONNECTED_27, SYNOPSYS_UNCONNECTED_28, 
        SYNOPSYS_UNCONNECTED_29, SYNOPSYS_UNCONNECTED_30, 
        SYNOPSYS_UNCONNECTED_31, SYNOPSYS_UNCONNECTED_32, 
        SYNOPSYS_UNCONNECTED_33, SYNOPSYS_UNCONNECTED_34, 
        SYNOPSYS_UNCONNECTED_35, SYNOPSYS_UNCONNECTED_36, 
        SYNOPSYS_UNCONNECTED_37}) );
  NAND3_X1 I2_U10 ( .A1(B_EXP[5]), .A2(B_EXP[4]), .A3(B_EXP[6]), .ZN(I2_n4) );
  NAND3_X1 I2_U9 ( .A1(A_EXP[5]), .A2(A_EXP[4]), .A3(A_EXP[6]), .ZN(I2_n6) );
  DFF_X1 I2_SIGN_out_stage2_reg ( .D(I2_SIGN_out_stage2_REG), .CK(clk), .Q(
        SIGN_out_stage2) );
  DFF_X1 I2_isZ_tab_stage2_reg ( .D(I2_isZ_tab_stage2_REG), .CK(clk), .Q(
        isZ_tab_stage2) );
  DFF_X1 I2_isNaN_stage2_reg ( .D(I2_isNaN_stage2_REG), .CK(clk), .Q(
        isNaN_stage2) );
  DFF_X1 I2_isINF_stage2_reg ( .D(I2_isINF_stage2_REG), .CK(clk), .Q(
        isINF_stage2) );
  DFF_X1 I2_SIGN_out_stage2_REG_reg ( .D(SIGN_out_stage1), .CK(clk), .Q(
        I2_SIGN_out_stage2_REG) );
  DFF_X1 I2_isZ_tab_stage2_REG_reg ( .D(isZ_tab_stage1), .CK(clk), .Q(
        I2_isZ_tab_stage2_REG) );
  DFF_X1 I2_isNaN_stage2_REG_reg ( .D(isNaN_stage1), .CK(clk), .Q(
        I2_isNaN_stage2_REG) );
  DFF_X1 I2_isINF_stage2_REG_reg ( .D(isINF_stage1), .CK(clk), .Q(
        I2_isINF_stage2_REG) );
  DFF_X1 I2_EXP_neg_stage2_reg ( .D(I2_EXP_neg_stage2_REG), .CK(clk), .Q(
        EXP_neg_stage2) );
  DFF_X1 I2_EXP_pos_stage2_reg ( .D(I2_EXP_pos_stage2_REG), .CK(clk), .Q(
        EXP_pos_stage2) );
  DFF_X1 I2_SIG_in_reg_0_ ( .D(I2_SIG_in_REG[0]), .CK(clk), .Q(SIG_in[0]) );
  DFF_X1 I2_SIG_in_reg_1_ ( .D(I2_SIG_in_REG[1]), .CK(clk), .Q(SIG_in[1]) );
  DFF_X1 I2_SIG_in_reg_2_ ( .D(I2_SIG_in_REG[2]), .CK(clk), .Q(SIG_in[2]) );
  DFF_X1 I2_SIG_in_reg_3_ ( .D(I2_SIG_in_REG[3]), .CK(clk), .Q(SIG_in[3]) );
  DFF_X1 I2_SIG_in_reg_4_ ( .D(I2_SIG_in_REG[4]), .CK(clk), .Q(SIG_in[4]) );
  DFF_X1 I2_SIG_in_reg_5_ ( .D(I2_SIG_in_REG[5]), .CK(clk), .Q(SIG_in[5]) );
  DFF_X1 I2_SIG_in_reg_6_ ( .D(I2_SIG_in_REG[6]), .CK(clk), .Q(SIG_in[6]) );
  DFF_X1 I2_SIG_in_reg_7_ ( .D(I2_SIG_in_REG[7]), .CK(clk), .Q(SIG_in[7]) );
  DFF_X1 I2_SIG_in_reg_8_ ( .D(I2_SIG_in_REG[8]), .CK(clk), .Q(SIG_in[8]) );
  DFF_X1 I2_SIG_in_reg_9_ ( .D(I2_SIG_in_REG[9]), .CK(clk), .Q(SIG_in[9]) );
  DFF_X1 I2_SIG_in_reg_10_ ( .D(I2_SIG_in_REG[10]), .CK(clk), .Q(SIG_in[10])
         );
  DFF_X1 I2_SIG_in_reg_11_ ( .D(I2_SIG_in_REG[11]), .CK(clk), .Q(SIG_in[11])
         );
  DFF_X1 I2_SIG_in_reg_12_ ( .D(I2_SIG_in_REG[12]), .CK(clk), .Q(SIG_in[12])
         );
  DFF_X1 I2_SIG_in_reg_13_ ( .D(I2_SIG_in_REG[13]), .CK(clk), .Q(SIG_in[13])
         );
  DFF_X1 I2_SIG_in_reg_14_ ( .D(I2_SIG_in_REG[14]), .CK(clk), .Q(SIG_in[14])
         );
  DFF_X1 I2_SIG_in_reg_15_ ( .D(I2_SIG_in_REG[15]), .CK(clk), .Q(SIG_in[15])
         );
  DFF_X1 I2_SIG_in_reg_16_ ( .D(I2_SIG_in_REG[16]), .CK(clk), .Q(SIG_in[16])
         );
  DFF_X1 I2_SIG_in_reg_17_ ( .D(I2_SIG_in_REG[17]), .CK(clk), .Q(SIG_in[17])
         );
  DFF_X1 I2_SIG_in_reg_18_ ( .D(I2_SIG_in_REG[18]), .CK(clk), .Q(SIG_in[18])
         );
  DFF_X1 I2_SIG_in_reg_19_ ( .D(I2_SIG_in_REG[19]), .CK(clk), .Q(SIG_in[19])
         );
  DFF_X1 I2_SIG_in_reg_20_ ( .D(I2_SIG_in_REG[20]), .CK(clk), .Q(SIG_in[20])
         );
  DFF_X1 I2_SIG_in_reg_21_ ( .D(I2_SIG_in_REG[21]), .CK(clk), .Q(SIG_in[21])
         );
  DFF_X1 I2_SIG_in_reg_22_ ( .D(I2_SIG_in_REG[22]), .CK(clk), .Q(SIG_in[22])
         );
  DFF_X1 I2_SIG_in_reg_23_ ( .D(I2_SIG_in_REG[23]), .CK(clk), .Q(SIG_in[23])
         );
  DFF_X1 I2_SIG_in_reg_24_ ( .D(I2_SIG_in_REG[24]), .CK(clk), .Q(SIG_in[24])
         );
  DFF_X1 I2_SIG_in_reg_25_ ( .D(I2_SIG_in_REG[25]), .CK(clk), .Q(SIG_in[25])
         );
  DFF_X1 I2_SIG_in_reg_26_ ( .D(I2_SIG_in_REG[26]), .CK(clk), .Q(SIG_in[26])
         );
  DFF_X1 I2_SIG_in_reg_27_ ( .D(I2_SIG_in_REG[27]), .CK(clk), .Q(SIG_in[27])
         );
  DFF_X1 I2_EXP_in_reg_0_ ( .D(I2_EXP_in_REG[0]), .CK(clk), .Q(EXP_in[0]) );
  DFF_X1 I2_EXP_in_reg_1_ ( .D(I2_EXP_in_REG[1]), .CK(clk), .Q(EXP_in[1]) );
  DFF_X1 I2_EXP_in_reg_2_ ( .D(I2_EXP_in_REG[2]), .CK(clk), .Q(EXP_in[2]) );
  DFF_X1 I2_EXP_in_reg_3_ ( .D(I2_EXP_in_REG[3]), .CK(clk), .Q(EXP_in[3]) );
  DFF_X1 I2_EXP_in_reg_4_ ( .D(I2_EXP_in_REG[4]), .CK(clk), .Q(EXP_in[4]) );
  DFF_X1 I2_EXP_in_reg_5_ ( .D(I2_EXP_in_REG[5]), .CK(clk), .Q(EXP_in[5]) );
  DFF_X1 I2_EXP_in_reg_6_ ( .D(I2_EXP_in_REG[6]), .CK(clk), .Q(EXP_in[6]) );
  DFF_X1 I2_EXP_in_reg_7_ ( .D(I2_EXP_in_REG[7]), .CK(clk), .Q(EXP_in[7]) );
  DFF_X1 I2_EXP_neg_stage2_REG_reg ( .D(I2_N0), .CK(clk), .Q(
        I2_EXP_neg_stage2_REG) );
  DFF_X1 I2_EXP_pos_stage2_REG_reg ( .D(I2_EXP_pos_int), .CK(clk), .Q(
        I2_EXP_pos_stage2_REG) );
  DFF_X1 I2_SIG_in_REG_reg_0_ ( .D(I2_SIG_in_int[0]), .CK(clk), .Q(
        I2_SIG_in_REG[0]) );
  DFF_X1 I2_SIG_in_REG_reg_1_ ( .D(I2_SIG_in_int[1]), .CK(clk), .Q(
        I2_SIG_in_REG[1]) );
  DFF_X1 I2_SIG_in_REG_reg_2_ ( .D(I2_SIG_in_int[2]), .CK(clk), .Q(
        I2_SIG_in_REG[2]) );
  DFF_X1 I2_SIG_in_REG_reg_3_ ( .D(I2_SIG_in_int[3]), .CK(clk), .Q(
        I2_SIG_in_REG[3]) );
  DFF_X1 I2_SIG_in_REG_reg_4_ ( .D(I2_SIG_in_int[4]), .CK(clk), .Q(
        I2_SIG_in_REG[4]) );
  DFF_X1 I2_SIG_in_REG_reg_5_ ( .D(I2_SIG_in_int[5]), .CK(clk), .Q(
        I2_SIG_in_REG[5]) );
  DFF_X1 I2_SIG_in_REG_reg_6_ ( .D(I2_SIG_in_int[6]), .CK(clk), .Q(
        I2_SIG_in_REG[6]) );
  DFF_X1 I2_SIG_in_REG_reg_7_ ( .D(I2_SIG_in_int[7]), .CK(clk), .Q(
        I2_SIG_in_REG[7]) );
  DFF_X1 I2_SIG_in_REG_reg_8_ ( .D(I2_SIG_in_int[8]), .CK(clk), .Q(
        I2_SIG_in_REG[8]) );
  DFF_X1 I2_SIG_in_REG_reg_9_ ( .D(I2_SIG_in_int[9]), .CK(clk), .Q(
        I2_SIG_in_REG[9]) );
  DFF_X1 I2_SIG_in_REG_reg_10_ ( .D(I2_SIG_in_int[10]), .CK(clk), .Q(
        I2_SIG_in_REG[10]) );
  DFF_X1 I2_SIG_in_REG_reg_11_ ( .D(I2_SIG_in_int[11]), .CK(clk), .Q(
        I2_SIG_in_REG[11]) );
  DFF_X1 I2_SIG_in_REG_reg_12_ ( .D(I2_SIG_in_int[12]), .CK(clk), .Q(
        I2_SIG_in_REG[12]) );
  DFF_X1 I2_SIG_in_REG_reg_13_ ( .D(I2_SIG_in_int[13]), .CK(clk), .Q(
        I2_SIG_in_REG[13]) );
  DFF_X1 I2_SIG_in_REG_reg_14_ ( .D(I2_SIG_in_int[14]), .CK(clk), .Q(
        I2_SIG_in_REG[14]) );
  DFF_X1 I2_SIG_in_REG_reg_15_ ( .D(I2_SIG_in_int[15]), .CK(clk), .Q(
        I2_SIG_in_REG[15]) );
  DFF_X1 I2_SIG_in_REG_reg_16_ ( .D(I2_SIG_in_int[16]), .CK(clk), .Q(
        I2_SIG_in_REG[16]) );
  DFF_X1 I2_SIG_in_REG_reg_17_ ( .D(I2_SIG_in_int[17]), .CK(clk), .Q(
        I2_SIG_in_REG[17]) );
  DFF_X1 I2_SIG_in_REG_reg_18_ ( .D(I2_SIG_in_int[18]), .CK(clk), .Q(
        I2_SIG_in_REG[18]) );
  DFF_X1 I2_SIG_in_REG_reg_19_ ( .D(I2_SIG_in_int[19]), .CK(clk), .Q(
        I2_SIG_in_REG[19]) );
  DFF_X1 I2_SIG_in_REG_reg_20_ ( .D(I2_SIG_in_int[20]), .CK(clk), .Q(
        I2_SIG_in_REG[20]) );
  DFF_X1 I2_SIG_in_REG_reg_21_ ( .D(I2_SIG_in_int[21]), .CK(clk), .Q(
        I2_SIG_in_REG[21]) );
  DFF_X1 I2_SIG_in_REG_reg_22_ ( .D(I2_SIG_in_int[22]), .CK(clk), .Q(
        I2_SIG_in_REG[22]) );
  DFF_X1 I2_SIG_in_REG_reg_23_ ( .D(I2_SIG_in_int[23]), .CK(clk), .Q(
        I2_SIG_in_REG[23]) );
  DFF_X1 I2_SIG_in_REG_reg_24_ ( .D(I2_SIG_in_int[24]), .CK(clk), .Q(
        I2_SIG_in_REG[24]) );
  DFF_X1 I2_SIG_in_REG_reg_25_ ( .D(I2_SIG_in_int[25]), .CK(clk), .Q(
        I2_SIG_in_REG[25]) );
  DFF_X1 I2_SIG_in_REG_reg_26_ ( .D(I2_SIG_in_int[26]), .CK(clk), .Q(
        I2_SIG_in_REG[26]) );
  DFF_X1 I2_SIG_in_REG_reg_27_ ( .D(I2_SIG_in_int[27]), .CK(clk), .Q(
        I2_SIG_in_REG[27]) );
  DFF_X1 I2_EXP_in_REG_reg_0_ ( .D(I2_mw_I4sum[0]), .CK(clk), .Q(
        I2_EXP_in_REG[0]) );
  DFF_X1 I2_EXP_in_REG_reg_1_ ( .D(I2_mw_I4sum[1]), .CK(clk), .Q(
        I2_EXP_in_REG[1]) );
  DFF_X1 I2_EXP_in_REG_reg_2_ ( .D(I2_mw_I4sum[2]), .CK(clk), .Q(
        I2_EXP_in_REG[2]) );
  DFF_X1 I2_EXP_in_REG_reg_3_ ( .D(I2_mw_I4sum[3]), .CK(clk), .Q(
        I2_EXP_in_REG[3]) );
  DFF_X1 I2_EXP_in_REG_reg_4_ ( .D(I2_mw_I4sum[4]), .CK(clk), .Q(
        I2_EXP_in_REG[4]) );
  DFF_X1 I2_EXP_in_REG_reg_5_ ( .D(I2_mw_I4sum[5]), .CK(clk), .Q(
        I2_EXP_in_REG[5]) );
  DFF_X1 I2_EXP_in_REG_reg_6_ ( .D(I2_mw_I4sum[6]), .CK(clk), .Q(
        I2_EXP_in_REG[6]) );
  DFF_X1 I2_EXP_in_REG_reg_7_ ( .D(I2_n1), .CK(clk), .Q(I2_EXP_in_REG[7]) );
  XNOR2_X1 I2_add_1_root_add_161_2_U2 ( .A(B_EXP[0]), .B(A_EXP[0]), .ZN(
        I2_mw_I4sum[0]) );
  OR2_X1 I2_add_1_root_add_161_2_U1 ( .A1(B_EXP[0]), .A2(A_EXP[0]), .ZN(
        I2_add_1_root_add_161_2_carry[1]) );
  FA_X1 I2_add_1_root_add_161_2_U1_1 ( .A(A_EXP[1]), .B(B_EXP[1]), .CI(
        I2_add_1_root_add_161_2_carry[1]), .CO(
        I2_add_1_root_add_161_2_carry[2]), .S(I2_mw_I4sum[1]) );
  FA_X1 I2_add_1_root_add_161_2_U1_2 ( .A(A_EXP[2]), .B(B_EXP[2]), .CI(
        I2_add_1_root_add_161_2_carry[2]), .CO(
        I2_add_1_root_add_161_2_carry[3]), .S(I2_mw_I4sum[2]) );
  FA_X1 I2_add_1_root_add_161_2_U1_3 ( .A(A_EXP[3]), .B(B_EXP[3]), .CI(
        I2_add_1_root_add_161_2_carry[3]), .CO(
        I2_add_1_root_add_161_2_carry[4]), .S(I2_mw_I4sum[3]) );
  FA_X1 I2_add_1_root_add_161_2_U1_4 ( .A(A_EXP[4]), .B(B_EXP[4]), .CI(
        I2_add_1_root_add_161_2_carry[4]), .CO(
        I2_add_1_root_add_161_2_carry[5]), .S(I2_mw_I4sum[4]) );
  FA_X1 I2_add_1_root_add_161_2_U1_5 ( .A(A_EXP[5]), .B(B_EXP[5]), .CI(
        I2_add_1_root_add_161_2_carry[5]), .CO(
        I2_add_1_root_add_161_2_carry[6]), .S(I2_mw_I4sum[5]) );
  FA_X1 I2_add_1_root_add_161_2_U1_6 ( .A(A_EXP[6]), .B(B_EXP[6]), .CI(
        I2_add_1_root_add_161_2_carry[6]), .CO(
        I2_add_1_root_add_161_2_carry[7]), .S(I2_mw_I4sum[6]) );
  FA_X1 I2_add_1_root_add_161_2_U1_7 ( .A(A_EXP[7]), .B(B_EXP[7]), .CI(
        I2_add_1_root_add_161_2_carry[7]), .S(I2_mw_I4sum[7]) );
  DFF_X1 I3_EXP_neg_reg ( .D(EXP_neg_stage2), .CK(clk), .Q(EXP_neg) );
  DFF_X1 I3_EXP_pos_reg ( .D(EXP_pos_stage2), .CK(clk), .Q(EXP_pos) );
  DFF_X1 I3_SIGN_out_reg ( .D(SIGN_out_stage2), .CK(clk), .Q(I4_FP[31]) );
  DFF_X1 I3_isZ_tab_reg ( .D(isZ_tab_stage2), .CK(clk), .Q(isZ_tab) );
  DFF_X1 I3_isNaN_reg ( .D(isNaN_stage2), .CK(clk), .Q(isNaN) );
  DFF_X1 I3_isINF_tab_reg ( .D(isINF_stage2), .CK(clk), .Q(isINF_tab) );
  DFF_X1 I3_SIG_out_round_reg_0_ ( .D(I3_SIG_out[0]), .CK(clk), .Q(
        SIG_out_round[0]) );
  DFF_X1 I3_SIG_out_round_reg_1_ ( .D(I3_SIG_out[1]), .CK(clk), .Q(
        SIG_out_round[1]) );
  DFF_X1 I3_SIG_out_round_reg_3_ ( .D(I3_SIG_out[3]), .CK(clk), .Q(
        SIG_out_round[3]) );
  DFF_X1 I3_SIG_out_round_reg_4_ ( .D(I3_SIG_out[4]), .CK(clk), .Q(
        SIG_out_round[4]) );
  DFF_X1 I3_SIG_out_round_reg_5_ ( .D(I3_SIG_out[5]), .CK(clk), .Q(
        SIG_out_round[5]) );
  DFF_X1 I3_SIG_out_round_reg_6_ ( .D(I3_SIG_out[6]), .CK(clk), .Q(
        SIG_out_round[6]) );
  DFF_X1 I3_SIG_out_round_reg_7_ ( .D(I3_SIG_out[7]), .CK(clk), .Q(
        SIG_out_round[7]) );
  DFF_X1 I3_SIG_out_round_reg_8_ ( .D(I3_SIG_out[8]), .CK(clk), .Q(
        SIG_out_round[8]) );
  DFF_X1 I3_SIG_out_round_reg_9_ ( .D(I3_SIG_out[9]), .CK(clk), .Q(
        SIG_out_round[9]) );
  DFF_X1 I3_SIG_out_round_reg_10_ ( .D(I3_SIG_out[10]), .CK(clk), .Q(
        SIG_out_round[10]) );
  DFF_X1 I3_SIG_out_round_reg_11_ ( .D(I3_SIG_out[11]), .CK(clk), .Q(
        SIG_out_round[11]) );
  DFF_X1 I3_SIG_out_round_reg_12_ ( .D(I3_SIG_out[12]), .CK(clk), .Q(
        SIG_out_round[12]) );
  DFF_X1 I3_SIG_out_round_reg_13_ ( .D(I3_SIG_out[13]), .CK(clk), .Q(
        SIG_out_round[13]) );
  DFF_X1 I3_SIG_out_round_reg_14_ ( .D(I3_SIG_out[14]), .CK(clk), .Q(
        SIG_out_round[14]) );
  DFF_X1 I3_SIG_out_round_reg_15_ ( .D(I3_SIG_out[15]), .CK(clk), .Q(
        SIG_out_round[15]) );
  DFF_X1 I3_SIG_out_round_reg_16_ ( .D(I3_SIG_out[16]), .CK(clk), .Q(
        SIG_out_round[16]) );
  DFF_X1 I3_SIG_out_round_reg_17_ ( .D(I3_SIG_out[17]), .CK(clk), .Q(
        SIG_out_round[17]) );
  DFF_X1 I3_SIG_out_round_reg_18_ ( .D(I3_SIG_out[18]), .CK(clk), .Q(
        SIG_out_round[18]) );
  DFF_X1 I3_SIG_out_round_reg_19_ ( .D(I3_SIG_out[19]), .CK(clk), .Q(
        SIG_out_round[19]) );
  DFF_X1 I3_SIG_out_round_reg_20_ ( .D(I3_SIG_out[20]), .CK(clk), .Q(
        SIG_out_round[20]) );
  DFF_X1 I3_SIG_out_round_reg_21_ ( .D(I3_SIG_out[21]), .CK(clk), .Q(
        SIG_out_round[21]) );
  DFF_X1 I3_SIG_out_round_reg_22_ ( .D(I3_SIG_out[22]), .CK(clk), .Q(
        SIG_out_round[22]) );
  DFF_X1 I3_SIG_out_round_reg_23_ ( .D(I3_SIG_out[23]), .CK(clk), .Q(
        SIG_out_round[23]) );
  DFF_X1 I3_SIG_out_round_reg_24_ ( .D(I3_SIG_out[24]), .CK(clk), .Q(
        SIG_out_round[24]) );
  DFF_X1 I3_SIG_out_round_reg_25_ ( .D(I3_SIG_out[25]), .CK(clk), .Q(
        SIG_out_round[25]) );
  DFF_X1 I3_SIG_out_round_reg_26_ ( .D(I3_SIG_out[26]), .CK(clk), .Q(
        SIG_out_round[26]) );
  DFF_X1 I3_SIG_out_round_reg_27_ ( .D(I3_SIG_out[27]), .CK(clk), .Q(
        SIG_out_round[27]) );
  DFF_X1 I3_EXP_out_round_reg_0_ ( .D(I3_EXP_out[0]), .CK(clk), .Q(
        EXP_out_round[0]) );
  DFF_X1 I3_EXP_out_round_reg_1_ ( .D(I3_EXP_out[1]), .CK(clk), .Q(
        EXP_out_round[1]) );
  DFF_X1 I3_EXP_out_round_reg_2_ ( .D(I3_EXP_out[2]), .CK(clk), .Q(
        EXP_out_round[2]) );
  DFF_X1 I3_EXP_out_round_reg_3_ ( .D(I3_EXP_out[3]), .CK(clk), .Q(
        EXP_out_round[3]) );
  DFF_X1 I3_EXP_out_round_reg_4_ ( .D(I3_EXP_out[4]), .CK(clk), .Q(
        EXP_out_round[4]) );
  DFF_X1 I3_EXP_out_round_reg_5_ ( .D(I3_EXP_out[5]), .CK(clk), .Q(
        EXP_out_round[5]) );
  DFF_X1 I3_EXP_out_round_reg_6_ ( .D(I3_EXP_out[6]), .CK(clk), .Q(
        EXP_out_round[6]) );
  DFF_X1 I3_EXP_out_round_reg_7_ ( .D(I3_EXP_out[7]), .CK(clk), .Q(
        EXP_out_round[7]) );
  NAND2_X1 I3_I9_U80 ( .A1(EXP_in[6]), .A2(I3_I9_n5), .ZN(I3_I9_n15) );
  XNOR2_X1 I3_I9_U79 ( .A(EXP_in[7]), .B(I3_I9_n15), .ZN(I3_EXP_out[7]) );
  XOR2_X1 I3_I9_U78 ( .A(EXP_in[1]), .B(I3_I9_n6), .Z(I3_EXP_out[1]) );
  XOR2_X1 I3_I9_U77 ( .A(EXP_in[6]), .B(I3_I9_n5), .Z(I3_EXP_out[6]) );
  XOR2_X1 I3_I9_U76 ( .A(EXP_in[5]), .B(I3_I9_n4), .Z(I3_EXP_out[5]) );
  XOR2_X1 I3_I9_U75 ( .A(EXP_in[4]), .B(I3_I9_n3), .Z(I3_EXP_out[4]) );
  XOR2_X1 I3_I9_U74 ( .A(EXP_in[3]), .B(I3_I9_n2), .Z(I3_EXP_out[3]) );
  XOR2_X1 I3_I9_U73 ( .A(EXP_in[2]), .B(I3_I9_n1), .Z(I3_EXP_out[2]) );
  XOR2_X1 I3_I9_U72 ( .A(I3_I9_n18), .B(EXP_in[0]), .Z(I3_EXP_out[0]) );
  AOI22_X1 I3_I9_U71 ( .A1(I3_I9_n24), .A2(SIG_in[2]), .B1(I3_I9_n17), .B2(
        SIG_in[1]), .ZN(I3_I9_n34) );
  INV_X1 I3_I9_U70 ( .A(I3_I9_n34), .ZN(I3_SIG_out_norm[1]) );
  OAI21_X1 I3_I9_U69 ( .B1(I3_I9_n17), .B2(SIG_in[1]), .A(SIG_in[0]), .ZN(
        I3_I9_n35) );
  INV_X1 I3_I9_U68 ( .A(I3_I9_n35), .ZN(I3_SIG_out_norm[0]) );
  INV_X1 I3_I9_U67 ( .A(SIG_in[25]), .ZN(I3_I9_n28) );
  INV_X1 I3_I9_U66 ( .A(SIG_in[24]), .ZN(I3_I9_n29) );
  INV_X1 I3_I9_U65 ( .A(SIG_in[23]), .ZN(I3_I9_n30) );
  INV_X1 I3_I9_U64 ( .A(SIG_in[22]), .ZN(I3_I9_n31) );
  INV_X1 I3_I9_U63 ( .A(SIG_in[21]), .ZN(I3_I9_n32) );
  INV_X1 I3_I9_U62 ( .A(SIG_in[20]), .ZN(I3_I9_n33) );
  INV_X1 I3_I9_U61 ( .A(SIG_in[26]), .ZN(I3_I9_n27) );
  AND2_X1 I3_I9_U59 ( .A1(I3_I9_n18), .A2(EXP_in[0]), .ZN(I3_I9_n6) );
  AND2_X1 I3_I9_U58 ( .A1(EXP_in[5]), .A2(I3_I9_n4), .ZN(I3_I9_n5) );
  AND2_X1 I3_I9_U57 ( .A1(EXP_in[4]), .A2(I3_I9_n3), .ZN(I3_I9_n4) );
  AND2_X1 I3_I9_U56 ( .A1(EXP_in[3]), .A2(I3_I9_n2), .ZN(I3_I9_n3) );
  AND2_X1 I3_I9_U55 ( .A1(EXP_in[2]), .A2(I3_I9_n1), .ZN(I3_I9_n2) );
  AND2_X1 I3_I9_U54 ( .A1(EXP_in[1]), .A2(I3_I9_n6), .ZN(I3_I9_n1) );
  INV_X1 I3_I9_U53 ( .A(SIG_in[2]), .ZN(I3_I9_n53) );
  OAI22_X1 I3_I9_U52 ( .A1(I3_I9_n16), .A2(I3_I9_n52), .B1(I3_I9_n19), .B2(
        I3_I9_n53), .ZN(I3_SIG_out_norm[2]) );
  BUF_X1 I3_I9_U51 ( .A(SIG_in[27]), .Z(I3_I9_n24) );
  INV_X1 I3_I9_U50 ( .A(SIG_in[10]), .ZN(I3_I9_n45) );
  INV_X1 I3_I9_U49 ( .A(SIG_in[19]), .ZN(I3_I9_n36) );
  INV_X1 I3_I9_U48 ( .A(SIG_in[18]), .ZN(I3_I9_n37) );
  INV_X1 I3_I9_U47 ( .A(SIG_in[17]), .ZN(I3_I9_n38) );
  INV_X1 I3_I9_U46 ( .A(SIG_in[16]), .ZN(I3_I9_n39) );
  INV_X1 I3_I9_U45 ( .A(SIG_in[15]), .ZN(I3_I9_n40) );
  INV_X1 I3_I9_U44 ( .A(SIG_in[14]), .ZN(I3_I9_n41) );
  INV_X1 I3_I9_U43 ( .A(SIG_in[13]), .ZN(I3_I9_n42) );
  INV_X1 I3_I9_U42 ( .A(SIG_in[12]), .ZN(I3_I9_n43) );
  INV_X1 I3_I9_U41 ( .A(SIG_in[11]), .ZN(I3_I9_n44) );
  INV_X1 I3_I9_U40 ( .A(SIG_in[8]), .ZN(I3_I9_n47) );
  INV_X1 I3_I9_U39 ( .A(SIG_in[7]), .ZN(I3_I9_n48) );
  INV_X1 I3_I9_U38 ( .A(SIG_in[6]), .ZN(I3_I9_n49) );
  INV_X1 I3_I9_U37 ( .A(SIG_in[5]), .ZN(I3_I9_n50) );
  INV_X1 I3_I9_U36 ( .A(SIG_in[4]), .ZN(I3_I9_n51) );
  INV_X1 I3_I9_U35 ( .A(SIG_in[3]), .ZN(I3_I9_n52) );
  INV_X1 I3_I9_U34 ( .A(SIG_in[9]), .ZN(I3_I9_n46) );
  BUF_X1 I3_I9_U33 ( .A(SIG_in[27]), .Z(I3_I9_n22) );
  BUF_X1 I3_I9_U32 ( .A(SIG_in[27]), .Z(I3_I9_n23) );
  BUF_X1 I3_I9_U31 ( .A(SIG_in[27]), .Z(I3_I9_n21) );
  BUF_X1 I3_I9_U30 ( .A(SIG_in[27]), .Z(I3_I9_n20) );
  BUF_X1 I3_I9_U29 ( .A(SIG_in[27]), .Z(I3_I9_n18) );
  BUF_X1 I3_I9_U28 ( .A(SIG_in[27]), .Z(I3_I9_n19) );
  NAND2_X1 I3_I9_U27 ( .A1(I3_I9_n17), .A2(I3_I9_n27), .ZN(I3_SIG_out_norm[26]) );
  OAI22_X1 I3_I9_U26 ( .A1(I3_I9_n16), .A2(I3_I9_n27), .B1(I3_I9_n19), .B2(
        I3_I9_n28), .ZN(I3_SIG_out_norm[25]) );
  OAI22_X1 I3_I9_U25 ( .A1(I3_I9_n16), .A2(I3_I9_n28), .B1(I3_I9_n20), .B2(
        I3_I9_n29), .ZN(I3_SIG_out_norm[24]) );
  OAI22_X1 I3_I9_U24 ( .A1(I3_I9_n16), .A2(I3_I9_n29), .B1(I3_I9_n20), .B2(
        I3_I9_n30), .ZN(I3_SIG_out_norm[23]) );
  OAI22_X1 I3_I9_U23 ( .A1(I3_I9_n16), .A2(I3_I9_n30), .B1(I3_I9_n20), .B2(
        I3_I9_n31), .ZN(I3_SIG_out_norm[22]) );
  OAI22_X1 I3_I9_U22 ( .A1(I3_I9_n16), .A2(I3_I9_n31), .B1(I3_I9_n20), .B2(
        I3_I9_n32), .ZN(I3_SIG_out_norm[21]) );
  OAI22_X1 I3_I9_U21 ( .A1(I3_I9_n17), .A2(I3_I9_n32), .B1(I3_I9_n21), .B2(
        I3_I9_n33), .ZN(I3_SIG_out_norm[20]) );
  OAI22_X1 I3_I9_U20 ( .A1(I3_I9_n17), .A2(I3_I9_n33), .B1(I3_I9_n21), .B2(
        I3_I9_n36), .ZN(I3_SIG_out_norm[19]) );
  OAI22_X1 I3_I9_U19 ( .A1(I3_I9_n17), .A2(I3_I9_n36), .B1(I3_I9_n21), .B2(
        I3_I9_n37), .ZN(I3_SIG_out_norm[18]) );
  OAI22_X1 I3_I9_U18 ( .A1(I3_I9_n17), .A2(I3_I9_n37), .B1(I3_I9_n22), .B2(
        I3_I9_n38), .ZN(I3_SIG_out_norm[17]) );
  OAI22_X1 I3_I9_U17 ( .A1(I3_I9_n17), .A2(I3_I9_n38), .B1(I3_I9_n22), .B2(
        I3_I9_n39), .ZN(I3_SIG_out_norm[16]) );
  OAI22_X1 I3_I9_U16 ( .A1(I3_I9_n17), .A2(I3_I9_n39), .B1(I3_I9_n22), .B2(
        I3_I9_n40), .ZN(I3_SIG_out_norm[15]) );
  OAI22_X1 I3_I9_U15 ( .A1(I3_I9_n17), .A2(I3_I9_n40), .B1(I3_I9_n22), .B2(
        I3_I9_n41), .ZN(I3_SIG_out_norm[14]) );
  OAI22_X1 I3_I9_U14 ( .A1(I3_I9_n17), .A2(I3_I9_n41), .B1(I3_I9_n23), .B2(
        I3_I9_n42), .ZN(I3_SIG_out_norm[13]) );
  OAI22_X1 I3_I9_U13 ( .A1(I3_I9_n17), .A2(I3_I9_n42), .B1(I3_I9_n23), .B2(
        I3_I9_n43), .ZN(I3_SIG_out_norm[12]) );
  OAI22_X1 I3_I9_U12 ( .A1(I3_I9_n17), .A2(I3_I9_n43), .B1(I3_I9_n23), .B2(
        I3_I9_n44), .ZN(I3_SIG_out_norm[11]) );
  OAI22_X1 I3_I9_U11 ( .A1(I3_I9_n17), .A2(I3_I9_n44), .B1(I3_I9_n23), .B2(
        I3_I9_n45), .ZN(I3_SIG_out_norm[10]) );
  OAI22_X1 I3_I9_U10 ( .A1(I3_I9_n16), .A2(I3_I9_n49), .B1(I3_I9_n19), .B2(
        I3_I9_n50), .ZN(I3_SIG_out_norm[5]) );
  OAI22_X1 I3_I9_U9 ( .A1(I3_I9_n16), .A2(I3_I9_n46), .B1(I3_I9_n18), .B2(
        I3_I9_n47), .ZN(I3_SIG_out_norm[8]) );
  OAI22_X1 I3_I9_U8 ( .A1(I3_I9_n16), .A2(I3_I9_n47), .B1(I3_I9_n18), .B2(
        I3_I9_n48), .ZN(I3_SIG_out_norm[7]) );
  OAI22_X1 I3_I9_U7 ( .A1(I3_I9_n16), .A2(I3_I9_n48), .B1(I3_I9_n18), .B2(
        I3_I9_n49), .ZN(I3_SIG_out_norm[6]) );
  OAI22_X1 I3_I9_U6 ( .A1(I3_I9_n24), .A2(I3_I9_n46), .B1(I3_I9_n45), .B2(
        I3_I9_n16), .ZN(I3_SIG_out_norm[9]) );
  INV_X1 I3_I9_U5 ( .A(I3_I9_n20), .ZN(I3_I9_n17) );
  OAI22_X1 I3_I9_U4 ( .A1(I3_I9_n16), .A2(I3_I9_n50), .B1(I3_I9_n19), .B2(
        I3_I9_n51), .ZN(I3_SIG_out_norm[4]) );
  OAI22_X1 I3_I9_U3 ( .A1(I3_I9_n16), .A2(I3_I9_n51), .B1(I3_I9_n21), .B2(
        I3_I9_n52), .ZN(I3_SIG_out_norm[3]) );
  INV_X1 I3_I9_U2 ( .A(I3_I9_n19), .ZN(I3_I9_n16) );
  AND2_X1 I3_I11_U64 ( .A1(I3_SIG_out_norm[1]), .A2(I3_I11_n2), .ZN(
        I3_SIG_out[1]) );
  AND2_X1 I3_I11_U63 ( .A1(I3_SIG_out_norm[0]), .A2(I3_I11_n2), .ZN(
        I3_SIG_out[0]) );
  AOI22_X1 I3_I11_U62 ( .A1(I3_I11_N26), .A2(I3_I11_n4), .B1(1'b0), .B2(
        I3_I11_n1), .ZN(I3_I11_n35) );
  INV_X1 I3_I11_U61 ( .A(I3_I11_n35), .ZN(I3_SIG_out[27]) );
  BUF_X1 I3_I11_U60 ( .A(I3_SIG_out_norm[2]), .Z(I3_I11_n9) );
  BUF_X1 I3_I11_U59 ( .A(I3_SIG_out_norm[2]), .Z(I3_I11_n4) );
  BUF_X1 I3_I11_U58 ( .A(I3_SIG_out_norm[2]), .Z(I3_I11_n5) );
  BUF_X1 I3_I11_U57 ( .A(I3_SIG_out_norm[2]), .Z(I3_I11_n6) );
  BUF_X1 I3_I11_U55 ( .A(I3_SIG_out_norm[2]), .Z(I3_I11_n7) );
  BUF_X1 I3_I11_U54 ( .A(I3_SIG_out_norm[2]), .Z(I3_I11_n8) );
  BUF_X1 I3_I11_U53 ( .A(I3_SIG_out_norm[2]), .Z(I3_I11_n3) );
  AOI22_X1 I3_I11_U52 ( .A1(I3_I11_N6), .A2(I3_I11_n3), .B1(I3_SIG_out_norm[7]), .B2(I3_I11_n1), .ZN(I3_I11_n30) );
  INV_X1 I3_I11_U51 ( .A(I3_I11_n30), .ZN(I3_SIG_out[7]) );
  AOI22_X1 I3_I11_U50 ( .A1(I3_I11_N5), .A2(I3_I11_n3), .B1(I3_SIG_out_norm[6]), .B2(I3_I11_n1), .ZN(I3_I11_n31) );
  INV_X1 I3_I11_U49 ( .A(I3_I11_n31), .ZN(I3_SIG_out[6]) );
  AOI22_X1 I3_I11_U48 ( .A1(I3_I11_N9), .A2(I3_I11_n8), .B1(
        I3_SIG_out_norm[10]), .B2(I3_I11_n1), .ZN(I3_I11_n52) );
  INV_X1 I3_I11_U47 ( .A(I3_I11_n52), .ZN(I3_SIG_out[10]) );
  AOI22_X1 I3_I11_U46 ( .A1(I3_I11_n9), .A2(I3_I11_N8), .B1(I3_SIG_out_norm[9]), .B2(I3_I11_n2), .ZN(I3_I11_n28) );
  INV_X1 I3_I11_U45 ( .A(I3_I11_n28), .ZN(I3_SIG_out[9]) );
  AOI22_X1 I3_I11_U44 ( .A1(I3_I11_N7), .A2(I3_I11_n3), .B1(I3_SIG_out_norm[8]), .B2(I3_I11_n1), .ZN(I3_I11_n29) );
  INV_X1 I3_I11_U43 ( .A(I3_I11_n29), .ZN(I3_SIG_out[8]) );
  AOI22_X1 I3_I11_U42 ( .A1(I3_I11_N4), .A2(I3_I11_n3), .B1(I3_SIG_out_norm[5]), .B2(I3_I11_n1), .ZN(I3_I11_n32) );
  INV_X1 I3_I11_U41 ( .A(I3_I11_n32), .ZN(I3_SIG_out[5]) );
  AOI22_X1 I3_I11_U40 ( .A1(I3_I11_N3), .A2(I3_I11_n4), .B1(I3_SIG_out_norm[4]), .B2(I3_I11_n1), .ZN(I3_I11_n33) );
  INV_X1 I3_I11_U39 ( .A(I3_I11_n33), .ZN(I3_SIG_out[4]) );
  AOI22_X1 I3_I11_U38 ( .A1(I3_I11_N2), .A2(I3_I11_n6), .B1(I3_SIG_out_norm[3]), .B2(I3_I11_n1), .ZN(I3_I11_n34) );
  INV_X1 I3_I11_U37 ( .A(I3_I11_n34), .ZN(I3_SIG_out[3]) );
  INV_X1 I3_I11_U36 ( .A(I3_I11_n9), .ZN(I3_I11_n1) );
  INV_X1 I3_I11_U35 ( .A(I3_I11_n9), .ZN(I3_I11_n2) );
  AOI22_X1 I3_I11_U34 ( .A1(I3_I11_N25), .A2(I3_I11_n4), .B1(
        I3_SIG_out_norm[26]), .B2(I3_I11_n1), .ZN(I3_I11_n36) );
  INV_X1 I3_I11_U33 ( .A(I3_I11_n36), .ZN(I3_SIG_out[26]) );
  AOI22_X1 I3_I11_U32 ( .A1(I3_I11_N24), .A2(I3_I11_n4), .B1(
        I3_SIG_out_norm[25]), .B2(I3_I11_n1), .ZN(I3_I11_n37) );
  INV_X1 I3_I11_U31 ( .A(I3_I11_n37), .ZN(I3_SIG_out[25]) );
  AOI22_X1 I3_I11_U30 ( .A1(I3_I11_N23), .A2(I3_I11_n5), .B1(
        I3_SIG_out_norm[24]), .B2(I3_I11_n1), .ZN(I3_I11_n38) );
  INV_X1 I3_I11_U29 ( .A(I3_I11_n38), .ZN(I3_SIG_out[24]) );
  AOI22_X1 I3_I11_U28 ( .A1(I3_I11_N22), .A2(I3_I11_n5), .B1(
        I3_SIG_out_norm[23]), .B2(I3_I11_n1), .ZN(I3_I11_n39) );
  INV_X1 I3_I11_U27 ( .A(I3_I11_n39), .ZN(I3_SIG_out[23]) );
  AOI22_X1 I3_I11_U26 ( .A1(I3_I11_N21), .A2(I3_I11_n5), .B1(
        I3_SIG_out_norm[22]), .B2(I3_I11_n1), .ZN(I3_I11_n40) );
  INV_X1 I3_I11_U25 ( .A(I3_I11_n40), .ZN(I3_SIG_out[22]) );
  AOI22_X1 I3_I11_U24 ( .A1(I3_I11_N20), .A2(I3_I11_n5), .B1(
        I3_SIG_out_norm[21]), .B2(I3_I11_n2), .ZN(I3_I11_n41) );
  INV_X1 I3_I11_U23 ( .A(I3_I11_n41), .ZN(I3_SIG_out[21]) );
  AOI22_X1 I3_I11_U22 ( .A1(I3_I11_N15), .A2(I3_I11_n7), .B1(
        I3_SIG_out_norm[16]), .B2(I3_I11_n2), .ZN(I3_I11_n46) );
  INV_X1 I3_I11_U21 ( .A(I3_I11_n46), .ZN(I3_SIG_out[16]) );
  AOI22_X1 I3_I11_U20 ( .A1(I3_I11_N14), .A2(I3_I11_n7), .B1(
        I3_SIG_out_norm[15]), .B2(I3_I11_n2), .ZN(I3_I11_n47) );
  INV_X1 I3_I11_U19 ( .A(I3_I11_n47), .ZN(I3_SIG_out[15]) );
  AOI22_X1 I3_I11_U18 ( .A1(I3_I11_N13), .A2(I3_I11_n7), .B1(
        I3_SIG_out_norm[14]), .B2(I3_I11_n2), .ZN(I3_I11_n48) );
  INV_X1 I3_I11_U17 ( .A(I3_I11_n48), .ZN(I3_SIG_out[14]) );
  AOI22_X1 I3_I11_U16 ( .A1(I3_I11_N10), .A2(I3_I11_n8), .B1(
        I3_SIG_out_norm[11]), .B2(I3_I11_n2), .ZN(I3_I11_n51) );
  INV_X1 I3_I11_U15 ( .A(I3_I11_n51), .ZN(I3_SIG_out[11]) );
  AOI22_X1 I3_I11_U14 ( .A1(I3_I11_N19), .A2(I3_I11_n6), .B1(
        I3_SIG_out_norm[20]), .B2(I3_I11_n2), .ZN(I3_I11_n42) );
  INV_X1 I3_I11_U13 ( .A(I3_I11_n42), .ZN(I3_SIG_out[20]) );
  AOI22_X1 I3_I11_U12 ( .A1(I3_I11_N18), .A2(I3_I11_n6), .B1(
        I3_SIG_out_norm[19]), .B2(I3_I11_n2), .ZN(I3_I11_n43) );
  INV_X1 I3_I11_U11 ( .A(I3_I11_n43), .ZN(I3_SIG_out[19]) );
  AOI22_X1 I3_I11_U10 ( .A1(I3_I11_N17), .A2(I3_I11_n6), .B1(
        I3_SIG_out_norm[18]), .B2(I3_I11_n2), .ZN(I3_I11_n44) );
  INV_X1 I3_I11_U9 ( .A(I3_I11_n44), .ZN(I3_SIG_out[18]) );
  AOI22_X1 I3_I11_U8 ( .A1(I3_I11_N16), .A2(I3_I11_n7), .B1(
        I3_SIG_out_norm[17]), .B2(I3_I11_n2), .ZN(I3_I11_n45) );
  INV_X1 I3_I11_U7 ( .A(I3_I11_n45), .ZN(I3_SIG_out[17]) );
  AOI22_X1 I3_I11_U6 ( .A1(I3_I11_N12), .A2(I3_I11_n8), .B1(
        I3_SIG_out_norm[13]), .B2(I3_I11_n2), .ZN(I3_I11_n49) );
  INV_X1 I3_I11_U5 ( .A(I3_I11_n49), .ZN(I3_SIG_out[13]) );
  AOI22_X1 I3_I11_U4 ( .A1(I3_I11_N11), .A2(I3_I11_n8), .B1(
        I3_SIG_out_norm[12]), .B2(I3_I11_n2), .ZN(I3_I11_n50) );
  INV_X1 I3_I11_U3 ( .A(I3_I11_n50), .ZN(I3_SIG_out[12]) );
  XOR2_X1 I3_I11_add_45_U2 ( .A(I3_I11_add_45_carry[24]), .B(1'b0), .Z(
        I3_I11_N26) );
  INV_X1 I3_I11_add_45_U1 ( .A(I3_SIG_out_norm[3]), .ZN(I3_I11_N2) );
  HA_X1 I3_I11_add_45_U1_1_1 ( .A(I3_SIG_out_norm[4]), .B(I3_SIG_out_norm[3]), 
        .CO(I3_I11_add_45_carry[2]), .S(I3_I11_N3) );
  HA_X1 I3_I11_add_45_U1_1_2 ( .A(I3_SIG_out_norm[5]), .B(
        I3_I11_add_45_carry[2]), .CO(I3_I11_add_45_carry[3]), .S(I3_I11_N4) );
  HA_X1 I3_I11_add_45_U1_1_3 ( .A(I3_SIG_out_norm[6]), .B(
        I3_I11_add_45_carry[3]), .CO(I3_I11_add_45_carry[4]), .S(I3_I11_N5) );
  HA_X1 I3_I11_add_45_U1_1_4 ( .A(I3_SIG_out_norm[7]), .B(
        I3_I11_add_45_carry[4]), .CO(I3_I11_add_45_carry[5]), .S(I3_I11_N6) );
  HA_X1 I3_I11_add_45_U1_1_5 ( .A(I3_SIG_out_norm[8]), .B(
        I3_I11_add_45_carry[5]), .CO(I3_I11_add_45_carry[6]), .S(I3_I11_N7) );
  HA_X1 I3_I11_add_45_U1_1_6 ( .A(I3_SIG_out_norm[9]), .B(
        I3_I11_add_45_carry[6]), .CO(I3_I11_add_45_carry[7]), .S(I3_I11_N8) );
  HA_X1 I3_I11_add_45_U1_1_7 ( .A(I3_SIG_out_norm[10]), .B(
        I3_I11_add_45_carry[7]), .CO(I3_I11_add_45_carry[8]), .S(I3_I11_N9) );
  HA_X1 I3_I11_add_45_U1_1_8 ( .A(I3_SIG_out_norm[11]), .B(
        I3_I11_add_45_carry[8]), .CO(I3_I11_add_45_carry[9]), .S(I3_I11_N10)
         );
  HA_X1 I3_I11_add_45_U1_1_9 ( .A(I3_SIG_out_norm[12]), .B(
        I3_I11_add_45_carry[9]), .CO(I3_I11_add_45_carry[10]), .S(I3_I11_N11)
         );
  HA_X1 I3_I11_add_45_U1_1_10 ( .A(I3_SIG_out_norm[13]), .B(
        I3_I11_add_45_carry[10]), .CO(I3_I11_add_45_carry[11]), .S(I3_I11_N12)
         );
  HA_X1 I3_I11_add_45_U1_1_11 ( .A(I3_SIG_out_norm[14]), .B(
        I3_I11_add_45_carry[11]), .CO(I3_I11_add_45_carry[12]), .S(I3_I11_N13)
         );
  HA_X1 I3_I11_add_45_U1_1_12 ( .A(I3_SIG_out_norm[15]), .B(
        I3_I11_add_45_carry[12]), .CO(I3_I11_add_45_carry[13]), .S(I3_I11_N14)
         );
  HA_X1 I3_I11_add_45_U1_1_13 ( .A(I3_SIG_out_norm[16]), .B(
        I3_I11_add_45_carry[13]), .CO(I3_I11_add_45_carry[14]), .S(I3_I11_N15)
         );
  HA_X1 I3_I11_add_45_U1_1_14 ( .A(I3_SIG_out_norm[17]), .B(
        I3_I11_add_45_carry[14]), .CO(I3_I11_add_45_carry[15]), .S(I3_I11_N16)
         );
  HA_X1 I3_I11_add_45_U1_1_15 ( .A(I3_SIG_out_norm[18]), .B(
        I3_I11_add_45_carry[15]), .CO(I3_I11_add_45_carry[16]), .S(I3_I11_N17)
         );
  HA_X1 I3_I11_add_45_U1_1_16 ( .A(I3_SIG_out_norm[19]), .B(
        I3_I11_add_45_carry[16]), .CO(I3_I11_add_45_carry[17]), .S(I3_I11_N18)
         );
  HA_X1 I3_I11_add_45_U1_1_17 ( .A(I3_SIG_out_norm[20]), .B(
        I3_I11_add_45_carry[17]), .CO(I3_I11_add_45_carry[18]), .S(I3_I11_N19)
         );
  HA_X1 I3_I11_add_45_U1_1_18 ( .A(I3_SIG_out_norm[21]), .B(
        I3_I11_add_45_carry[18]), .CO(I3_I11_add_45_carry[19]), .S(I3_I11_N20)
         );
  HA_X1 I3_I11_add_45_U1_1_19 ( .A(I3_SIG_out_norm[22]), .B(
        I3_I11_add_45_carry[19]), .CO(I3_I11_add_45_carry[20]), .S(I3_I11_N21)
         );
  HA_X1 I3_I11_add_45_U1_1_20 ( .A(I3_SIG_out_norm[23]), .B(
        I3_I11_add_45_carry[20]), .CO(I3_I11_add_45_carry[21]), .S(I3_I11_N22)
         );
  HA_X1 I3_I11_add_45_U1_1_21 ( .A(I3_SIG_out_norm[24]), .B(
        I3_I11_add_45_carry[21]), .CO(I3_I11_add_45_carry[22]), .S(I3_I11_N23)
         );
  HA_X1 I3_I11_add_45_U1_1_22 ( .A(I3_SIG_out_norm[25]), .B(
        I3_I11_add_45_carry[22]), .CO(I3_I11_add_45_carry[23]), .S(I3_I11_N24)
         );
  HA_X1 I3_I11_add_45_U1_1_23 ( .A(I3_SIG_out_norm[26]), .B(
        I3_I11_add_45_carry[23]), .CO(I3_I11_add_45_carry[24]), .S(I3_I11_N25)
         );
  INV_X1 I4_U19 ( .A(I4_EXP_out_7_), .ZN(I4_n1) );
  AND4_X1 I4_U18 ( .A1(I4_EXP_out_6_), .A2(I4_EXP_out_5_), .A3(I4_EXP_out_4_), 
        .A4(I4_EXP_out_3_), .ZN(I4_n4) );
  AOI221_X1 I4_U17 ( .B1(EXP_pos), .B2(I4_n1), .C1(I4_n4), .C2(I4_n5), .A(
        isINF_tab), .ZN(I4_n3) );
  NOR2_X1 I4_U16 ( .A1(I4_n2), .A2(I4_n3), .ZN(I4_isINF) );
  AND4_X1 I4_U15 ( .A1(I4_n9), .A2(I4_n10), .A3(I4_n11), .A4(I4_n12), .ZN(
        I4_n8) );
  AND4_X1 I4_U14 ( .A1(I4_n13), .A2(I4_n14), .A3(I4_n15), .A4(I4_n16), .ZN(
        I4_n7) );
  AOI221_X1 I4_U13 ( .B1(I4_EXP_out_7_), .B2(EXP_neg), .C1(I4_n7), .C2(I4_n8), 
        .A(isZ_tab), .ZN(I4_n6) );
  INV_X1 I4_U12 ( .A(I4_n6), .ZN(I4_n2) );
  NOR3_X1 I4_U11 ( .A1(I4_SIG_out_8_), .A2(I4_SIG_out_norm2_26_), .A3(
        I4_SIG_out_9_), .ZN(I4_n12) );
  AND4_X1 I4_U10 ( .A1(I4_EXP_out_2_), .A2(I4_EXP_out_1_), .A3(I4_EXP_out_0_), 
        .A4(I4_EXP_out_7_), .ZN(I4_n5) );
  NOR3_X1 I4_U9 ( .A1(I4_SIG_out_0_), .A2(I4_SIG_out_11_), .A3(I4_SIG_out_10_), 
        .ZN(I4_n13) );
  NOR3_X1 I4_U8 ( .A1(I4_SIG_out_20_), .A2(I4_SIG_out_22_), .A3(I4_SIG_out_21_), .ZN(I4_n9) );
  NOR3_X1 I4_U7 ( .A1(I4_SIG_out_12_), .A2(I4_SIG_out_14_), .A3(I4_SIG_out_13_), .ZN(I4_n14) );
  NOR3_X1 I4_U6 ( .A1(I4_SIG_out_2_), .A2(I4_SIG_out_4_), .A3(I4_SIG_out_3_), 
        .ZN(I4_n10) );
  NOR3_X1 I4_U5 ( .A1(I4_SIG_out_15_), .A2(I4_SIG_out_17_), .A3(I4_SIG_out_16_), .ZN(I4_n15) );
  NOR3_X1 I4_U4 ( .A1(I4_SIG_out_5_), .A2(I4_SIG_out_7_), .A3(I4_SIG_out_6_), 
        .ZN(I4_n11) );
  NOR3_X1 I4_U3 ( .A1(I4_SIG_out_18_), .A2(I4_SIG_out_1_), .A3(I4_SIG_out_19_), 
        .ZN(I4_n16) );
  DFF_X1 I4_FP_Z_reg_0_ ( .D(I4_FP[0]), .CK(clk), .Q(FP_Z[0]) );
  DFF_X1 I4_FP_Z_reg_1_ ( .D(I4_FP[1]), .CK(clk), .Q(FP_Z[1]) );
  DFF_X1 I4_FP_Z_reg_2_ ( .D(I4_FP[2]), .CK(clk), .Q(FP_Z[2]) );
  DFF_X1 I4_FP_Z_reg_3_ ( .D(I4_FP[3]), .CK(clk), .Q(FP_Z[3]) );
  DFF_X1 I4_FP_Z_reg_4_ ( .D(I4_FP[4]), .CK(clk), .Q(FP_Z[4]) );
  DFF_X1 I4_FP_Z_reg_5_ ( .D(I4_FP[5]), .CK(clk), .Q(FP_Z[5]) );
  DFF_X1 I4_FP_Z_reg_6_ ( .D(I4_FP[6]), .CK(clk), .Q(FP_Z[6]) );
  DFF_X1 I4_FP_Z_reg_7_ ( .D(I4_FP[7]), .CK(clk), .Q(FP_Z[7]) );
  DFF_X1 I4_FP_Z_reg_8_ ( .D(I4_FP[8]), .CK(clk), .Q(FP_Z[8]) );
  DFF_X1 I4_FP_Z_reg_9_ ( .D(I4_FP[9]), .CK(clk), .Q(FP_Z[9]) );
  DFF_X1 I4_FP_Z_reg_10_ ( .D(I4_FP[10]), .CK(clk), .Q(FP_Z[10]) );
  DFF_X1 I4_FP_Z_reg_11_ ( .D(I4_FP[11]), .CK(clk), .Q(FP_Z[11]) );
  DFF_X1 I4_FP_Z_reg_12_ ( .D(I4_FP[12]), .CK(clk), .Q(FP_Z[12]) );
  DFF_X1 I4_FP_Z_reg_13_ ( .D(I4_FP[13]), .CK(clk), .Q(FP_Z[13]) );
  DFF_X1 I4_FP_Z_reg_14_ ( .D(I4_FP[14]), .CK(clk), .Q(FP_Z[14]) );
  DFF_X1 I4_FP_Z_reg_15_ ( .D(I4_FP[15]), .CK(clk), .Q(FP_Z[15]) );
  DFF_X1 I4_FP_Z_reg_16_ ( .D(I4_FP[16]), .CK(clk), .Q(FP_Z[16]) );
  DFF_X1 I4_FP_Z_reg_17_ ( .D(I4_FP[17]), .CK(clk), .Q(FP_Z[17]) );
  DFF_X1 I4_FP_Z_reg_18_ ( .D(I4_FP[18]), .CK(clk), .Q(FP_Z[18]) );
  DFF_X1 I4_FP_Z_reg_19_ ( .D(I4_FP[19]), .CK(clk), .Q(FP_Z[19]) );
  DFF_X1 I4_FP_Z_reg_20_ ( .D(I4_FP[20]), .CK(clk), .Q(FP_Z[20]) );
  DFF_X1 I4_FP_Z_reg_21_ ( .D(I4_FP[21]), .CK(clk), .Q(FP_Z[21]) );
  DFF_X1 I4_FP_Z_reg_22_ ( .D(I4_FP[22]), .CK(clk), .Q(FP_Z[22]) );
  DFF_X1 I4_FP_Z_reg_23_ ( .D(I4_FP[23]), .CK(clk), .Q(FP_Z[23]) );
  DFF_X1 I4_FP_Z_reg_24_ ( .D(I4_FP[24]), .CK(clk), .Q(FP_Z[24]) );
  DFF_X1 I4_FP_Z_reg_25_ ( .D(I4_FP[25]), .CK(clk), .Q(FP_Z[25]) );
  DFF_X1 I4_FP_Z_reg_26_ ( .D(I4_FP[26]), .CK(clk), .Q(FP_Z[26]) );
  DFF_X1 I4_FP_Z_reg_27_ ( .D(I4_FP[27]), .CK(clk), .Q(FP_Z[27]) );
  DFF_X1 I4_FP_Z_reg_28_ ( .D(I4_FP[28]), .CK(clk), .Q(FP_Z[28]) );
  DFF_X1 I4_FP_Z_reg_29_ ( .D(I4_FP[29]), .CK(clk), .Q(FP_Z[29]) );
  DFF_X1 I4_FP_Z_reg_30_ ( .D(I4_FP[30]), .CK(clk), .Q(FP_Z[30]) );
  DFF_X1 I4_FP_Z_reg_31_ ( .D(I4_FP[31]), .CK(clk), .Q(FP_Z[31]) );
  INV_X1 I4_I1_U80 ( .A(1'b0), .ZN(I4_I1_n53) );
  OAI21_X1 I4_I1_U79 ( .B1(I4_I1_n17), .B2(SIG_out_round[1]), .A(
        SIG_out_round[0]), .ZN(I4_I1_n54) );
  AOI22_X1 I4_I1_U78 ( .A1(I4_I1_n24), .A2(1'b0), .B1(I4_I1_n17), .B2(
        SIG_out_round[1]), .ZN(I4_I1_n55) );
  BUF_X1 I4_I1_U77 ( .A(SIG_out_round[27]), .Z(I4_I1_n24) );
  XOR2_X1 I4_I1_U76 ( .A(EXP_out_round[2]), .B(I4_I1_n3), .Z(I4_EXP_out_2_) );
  INV_X1 I4_I1_U75 ( .A(SIG_out_round[10]), .ZN(I4_I1_n45) );
  INV_X1 I4_I1_U74 ( .A(SIG_out_round[3]), .ZN(I4_I1_n52) );
  INV_X1 I4_I1_U73 ( .A(SIG_out_round[4]), .ZN(I4_I1_n51) );
  INV_X1 I4_I1_U72 ( .A(SIG_out_round[15]), .ZN(I4_I1_n40) );
  INV_X1 I4_I1_U71 ( .A(SIG_out_round[14]), .ZN(I4_I1_n41) );
  INV_X1 I4_I1_U70 ( .A(SIG_out_round[13]), .ZN(I4_I1_n42) );
  INV_X1 I4_I1_U69 ( .A(SIG_out_round[16]), .ZN(I4_I1_n39) );
  INV_X1 I4_I1_U68 ( .A(SIG_out_round[18]), .ZN(I4_I1_n37) );
  INV_X1 I4_I1_U67 ( .A(SIG_out_round[17]), .ZN(I4_I1_n38) );
  INV_X1 I4_I1_U66 ( .A(SIG_out_round[19]), .ZN(I4_I1_n36) );
  INV_X1 I4_I1_U65 ( .A(SIG_out_round[21]), .ZN(I4_I1_n32) );
  INV_X1 I4_I1_U64 ( .A(SIG_out_round[20]), .ZN(I4_I1_n33) );
  INV_X1 I4_I1_U63 ( .A(SIG_out_round[22]), .ZN(I4_I1_n31) );
  INV_X1 I4_I1_U62 ( .A(SIG_out_round[5]), .ZN(I4_I1_n50) );
  INV_X1 I4_I1_U61 ( .A(SIG_out_round[23]), .ZN(I4_I1_n30) );
  INV_X1 I4_I1_U59 ( .A(SIG_out_round[24]), .ZN(I4_I1_n29) );
  INV_X1 I4_I1_U58 ( .A(SIG_out_round[25]), .ZN(I4_I1_n28) );
  INV_X1 I4_I1_U57 ( .A(SIG_out_round[6]), .ZN(I4_I1_n49) );
  INV_X1 I4_I1_U56 ( .A(SIG_out_round[8]), .ZN(I4_I1_n47) );
  INV_X1 I4_I1_U55 ( .A(SIG_out_round[7]), .ZN(I4_I1_n48) );
  INV_X1 I4_I1_U54 ( .A(SIG_out_round[11]), .ZN(I4_I1_n44) );
  INV_X1 I4_I1_U53 ( .A(SIG_out_round[12]), .ZN(I4_I1_n43) );
  INV_X1 I4_I1_U52 ( .A(SIG_out_round[9]), .ZN(I4_I1_n46) );
  XOR2_X1 I4_I1_U51 ( .A(I4_I1_n18), .B(EXP_out_round[0]), .Z(I4_EXP_out_0_)
         );
  INV_X1 I4_I1_U50 ( .A(SIG_out_round[26]), .ZN(I4_I1_n27) );
  BUF_X1 I4_I1_U49 ( .A(SIG_out_round[27]), .Z(I4_I1_n22) );
  BUF_X1 I4_I1_U48 ( .A(SIG_out_round[27]), .Z(I4_I1_n23) );
  BUF_X1 I4_I1_U47 ( .A(SIG_out_round[27]), .Z(I4_I1_n21) );
  BUF_X1 I4_I1_U46 ( .A(SIG_out_round[27]), .Z(I4_I1_n19) );
  BUF_X1 I4_I1_U45 ( .A(SIG_out_round[27]), .Z(I4_I1_n20) );
  XOR2_X1 I4_I1_U44 ( .A(EXP_out_round[1]), .B(I4_I1_n8), .Z(I4_EXP_out_1_) );
  XOR2_X1 I4_I1_U43 ( .A(EXP_out_round[6]), .B(I4_I1_n7), .Z(I4_EXP_out_6_) );
  XOR2_X1 I4_I1_U42 ( .A(EXP_out_round[4]), .B(I4_I1_n5), .Z(I4_EXP_out_4_) );
  XOR2_X1 I4_I1_U41 ( .A(EXP_out_round[3]), .B(I4_I1_n4), .Z(I4_EXP_out_3_) );
  AND2_X1 I4_I1_U40 ( .A1(I4_I1_n18), .A2(EXP_out_round[0]), .ZN(I4_I1_n8) );
  AND2_X1 I4_I1_U39 ( .A1(EXP_out_round[5]), .A2(I4_I1_n6), .ZN(I4_I1_n7) );
  AND2_X1 I4_I1_U38 ( .A1(EXP_out_round[4]), .A2(I4_I1_n5), .ZN(I4_I1_n6) );
  AND2_X1 I4_I1_U37 ( .A1(EXP_out_round[3]), .A2(I4_I1_n4), .ZN(I4_I1_n5) );
  AND2_X1 I4_I1_U36 ( .A1(EXP_out_round[2]), .A2(I4_I1_n3), .ZN(I4_I1_n4) );
  AND2_X1 I4_I1_U35 ( .A1(EXP_out_round[1]), .A2(I4_I1_n8), .ZN(I4_I1_n3) );
  BUF_X1 I4_I1_U34 ( .A(SIG_out_round[27]), .Z(I4_I1_n18) );
  XOR2_X1 I4_I1_U33 ( .A(EXP_out_round[5]), .B(I4_I1_n6), .Z(I4_EXP_out_5_) );
  NAND2_X1 I4_I1_U32 ( .A1(EXP_out_round[6]), .A2(I4_I1_n7), .ZN(I4_I1_n15) );
  XNOR2_X1 I4_I1_U31 ( .A(EXP_out_round[7]), .B(I4_I1_n15), .ZN(I4_EXP_out_7_)
         );
  INV_X1 I4_I1_U30 ( .A(I4_I1_n55), .ZN(I4_I1_SIG_out_1_) );
  INV_X1 I4_I1_U29 ( .A(I4_I1_n54), .ZN(I4_I1_SIG_out_0_) );
  OAI22_X1 I4_I1_U28 ( .A1(I4_I1_n16), .A2(I4_I1_n52), .B1(I4_I1_n19), .B2(
        I4_I1_n53), .ZN(I4_I1_SIG_out_2_) );
  NAND2_X1 I4_I1_U27 ( .A1(I4_I1_n17), .A2(I4_I1_n27), .ZN(
        I4_SIG_out_norm2_26_) );
  OAI22_X1 I4_I1_U26 ( .A1(I4_I1_n16), .A2(I4_I1_n51), .B1(I4_I1_n21), .B2(
        I4_I1_n52), .ZN(I4_SIG_out_0_) );
  OAI22_X1 I4_I1_U25 ( .A1(I4_I1_n17), .A2(I4_I1_n39), .B1(I4_I1_n22), .B2(
        I4_I1_n40), .ZN(I4_SIG_out_12_) );
  OAI22_X1 I4_I1_U24 ( .A1(I4_I1_n17), .A2(I4_I1_n36), .B1(I4_I1_n21), .B2(
        I4_I1_n37), .ZN(I4_SIG_out_15_) );
  OAI22_X1 I4_I1_U23 ( .A1(I4_I1_n16), .A2(I4_I1_n31), .B1(I4_I1_n20), .B2(
        I4_I1_n32), .ZN(I4_SIG_out_18_) );
  OAI22_X1 I4_I1_U22 ( .A1(I4_I1_n16), .A2(I4_I1_n29), .B1(I4_I1_n20), .B2(
        I4_I1_n30), .ZN(I4_SIG_out_20_) );
  OAI22_X1 I4_I1_U21 ( .A1(I4_I1_n16), .A2(I4_I1_n49), .B1(I4_I1_n19), .B2(
        I4_I1_n50), .ZN(I4_SIG_out_2_) );
  OAI22_X1 I4_I1_U20 ( .A1(I4_I1_n17), .A2(I4_I1_n43), .B1(I4_I1_n23), .B2(
        I4_I1_n44), .ZN(I4_SIG_out_8_) );
  OAI22_X1 I4_I1_U19 ( .A1(I4_I1_n16), .A2(I4_I1_n46), .B1(I4_I1_n18), .B2(
        I4_I1_n47), .ZN(I4_SIG_out_5_) );
  OAI22_X1 I4_I1_U18 ( .A1(I4_I1_n16), .A2(I4_I1_n27), .B1(I4_I1_n19), .B2(
        I4_I1_n28), .ZN(I4_SIG_out_22_) );
  OAI22_X1 I4_I1_U17 ( .A1(I4_I1_n17), .A2(I4_I1_n40), .B1(I4_I1_n22), .B2(
        I4_I1_n41), .ZN(I4_SIG_out_11_) );
  OAI22_X1 I4_I1_U16 ( .A1(I4_I1_n17), .A2(I4_I1_n37), .B1(I4_I1_n22), .B2(
        I4_I1_n38), .ZN(I4_SIG_out_14_) );
  OAI22_X1 I4_I1_U15 ( .A1(I4_I1_n17), .A2(I4_I1_n32), .B1(I4_I1_n21), .B2(
        I4_I1_n33), .ZN(I4_SIG_out_17_) );
  OAI22_X1 I4_I1_U14 ( .A1(I4_I1_n16), .A2(I4_I1_n50), .B1(I4_I1_n19), .B2(
        I4_I1_n51), .ZN(I4_SIG_out_1_) );
  OAI22_X1 I4_I1_U13 ( .A1(I4_I1_n17), .A2(I4_I1_n44), .B1(I4_I1_n23), .B2(
        I4_I1_n45), .ZN(I4_SIG_out_7_) );
  OAI22_X1 I4_I1_U12 ( .A1(I4_I1_n16), .A2(I4_I1_n47), .B1(I4_I1_n18), .B2(
        I4_I1_n48), .ZN(I4_SIG_out_4_) );
  OAI22_X1 I4_I1_U11 ( .A1(I4_I1_n17), .A2(I4_I1_n41), .B1(I4_I1_n23), .B2(
        I4_I1_n42), .ZN(I4_SIG_out_10_) );
  OAI22_X1 I4_I1_U10 ( .A1(I4_I1_n17), .A2(I4_I1_n38), .B1(I4_I1_n22), .B2(
        I4_I1_n39), .ZN(I4_SIG_out_13_) );
  OAI22_X1 I4_I1_U9 ( .A1(I4_I1_n17), .A2(I4_I1_n33), .B1(I4_I1_n21), .B2(
        I4_I1_n36), .ZN(I4_SIG_out_16_) );
  OAI22_X1 I4_I1_U8 ( .A1(I4_I1_n16), .A2(I4_I1_n30), .B1(I4_I1_n20), .B2(
        I4_I1_n31), .ZN(I4_SIG_out_19_) );
  OAI22_X1 I4_I1_U7 ( .A1(I4_I1_n16), .A2(I4_I1_n28), .B1(I4_I1_n20), .B2(
        I4_I1_n29), .ZN(I4_SIG_out_21_) );
  OAI22_X1 I4_I1_U6 ( .A1(I4_I1_n17), .A2(I4_I1_n42), .B1(I4_I1_n23), .B2(
        I4_I1_n43), .ZN(I4_SIG_out_9_) );
  OAI22_X1 I4_I1_U5 ( .A1(I4_I1_n16), .A2(I4_I1_n48), .B1(I4_I1_n18), .B2(
        I4_I1_n49), .ZN(I4_SIG_out_3_) );
  OAI22_X1 I4_I1_U4 ( .A1(I4_I1_n24), .A2(I4_I1_n46), .B1(I4_I1_n45), .B2(
        I4_I1_n16), .ZN(I4_SIG_out_6_) );
  INV_X1 I4_I1_U3 ( .A(I4_I1_n20), .ZN(I4_I1_n17) );
  INV_X1 I4_I1_U2 ( .A(I4_I1_n19), .ZN(I4_I1_n16) );
  INV_X1 I4_I3_U48 ( .A(I4_isINF), .ZN(I4_I3_n2) );
  INV_X1 I4_I3_U46 ( .A(isNaN), .ZN(I4_I3_n15) );
  NAND2_X1 I4_I3_U45 ( .A1(I4_I3_n15), .A2(I4_I3_n14), .ZN(I4_FP[22]) );
  NAND2_X1 I4_I3_U44 ( .A1(I4_EXP_out_7_), .A2(I4_I3_n3), .ZN(I4_I3_n6) );
  NAND2_X1 I4_I3_U43 ( .A1(I4_I3_n5), .A2(I4_I3_n6), .ZN(I4_FP[30]) );
  NAND2_X1 I4_I3_U42 ( .A1(I4_EXP_out_6_), .A2(I4_I3_n3), .ZN(I4_I3_n7) );
  NAND2_X1 I4_I3_U41 ( .A1(I4_I3_n5), .A2(I4_I3_n7), .ZN(I4_FP[29]) );
  NAND2_X1 I4_I3_U40 ( .A1(I4_EXP_out_5_), .A2(I4_I3_n3), .ZN(I4_I3_n8) );
  NAND2_X1 I4_I3_U39 ( .A1(I4_I3_n5), .A2(I4_I3_n8), .ZN(I4_FP[28]) );
  NAND2_X1 I4_I3_U38 ( .A1(I4_EXP_out_4_), .A2(I4_I3_n3), .ZN(I4_I3_n9) );
  NAND2_X1 I4_I3_U37 ( .A1(I4_I3_n5), .A2(I4_I3_n9), .ZN(I4_FP[27]) );
  NAND2_X1 I4_I3_U36 ( .A1(I4_EXP_out_3_), .A2(I4_I3_n3), .ZN(I4_I3_n10) );
  NAND2_X1 I4_I3_U35 ( .A1(I4_I3_n5), .A2(I4_I3_n10), .ZN(I4_FP[26]) );
  NAND2_X1 I4_I3_U34 ( .A1(I4_EXP_out_2_), .A2(I4_I3_n3), .ZN(I4_I3_n11) );
  NAND2_X1 I4_I3_U33 ( .A1(I4_I3_n5), .A2(I4_I3_n11), .ZN(I4_FP[25]) );
  NAND2_X1 I4_I3_U32 ( .A1(I4_EXP_out_1_), .A2(I4_I3_n3), .ZN(I4_I3_n12) );
  NAND2_X1 I4_I3_U31 ( .A1(I4_I3_n5), .A2(I4_I3_n12), .ZN(I4_FP[24]) );
  NAND2_X1 I4_I3_U30 ( .A1(I4_EXP_out_0_), .A2(I4_I3_n3), .ZN(I4_I3_n13) );
  NAND2_X1 I4_I3_U29 ( .A1(I4_I3_n5), .A2(I4_I3_n13), .ZN(I4_FP[23]) );
  AND2_X1 I4_I3_U28 ( .A1(I4_I3_n5), .A2(I4_I3_n3), .ZN(I4_I3_n4) );
  AND2_X1 I4_I3_U27 ( .A1(I4_I3_n5), .A2(I4_I3_n3), .ZN(I4_I3_n1) );
  INV_X1 I4_I3_U26 ( .A(I4_n2), .ZN(I4_I3_n3) );
  AND2_X1 I4_I3_U25 ( .A1(I4_SIG_out_20_), .A2(I4_I3_n1), .ZN(I4_FP[20]) );
  AND2_X1 I4_I3_U24 ( .A1(I4_SIG_out_18_), .A2(I4_I3_n4), .ZN(I4_FP[18]) );
  AND2_X1 I4_I3_U23 ( .A1(I4_SIG_out_15_), .A2(I4_I3_n1), .ZN(I4_FP[15]) );
  AND2_X1 I4_I3_U22 ( .A1(I4_SIG_out_12_), .A2(I4_I3_n4), .ZN(I4_FP[12]) );
  AND2_X1 I4_I3_U21 ( .A1(I4_SIG_out_8_), .A2(I4_I3_n1), .ZN(I4_FP[8]) );
  AND2_X1 I4_I3_U20 ( .A1(I4_SIG_out_2_), .A2(I4_I3_n1), .ZN(I4_FP[2]) );
  AND2_X1 I4_I3_U19 ( .A1(I4_SIG_out_0_), .A2(I4_I3_n1), .ZN(I4_FP[0]) );
  AND2_X1 I4_I3_U18 ( .A1(I4_SIG_out_5_), .A2(I4_I3_n4), .ZN(I4_FP[5]) );
  AND2_X1 I4_I3_U17 ( .A1(I4_SIG_out_17_), .A2(I4_I3_n1), .ZN(I4_FP[17]) );
  AND2_X1 I4_I3_U16 ( .A1(I4_SIG_out_14_), .A2(I4_I3_n4), .ZN(I4_FP[14]) );
  AND2_X1 I4_I3_U15 ( .A1(I4_SIG_out_11_), .A2(I4_I3_n1), .ZN(I4_FP[11]) );
  AND2_X1 I4_I3_U14 ( .A1(I4_SIG_out_7_), .A2(I4_I3_n4), .ZN(I4_FP[7]) );
  AND2_X1 I4_I3_U13 ( .A1(I4_SIG_out_1_), .A2(I4_I3_n4), .ZN(I4_FP[1]) );
  AND2_X1 I4_I3_U12 ( .A1(I4_SIG_out_4_), .A2(I4_I3_n1), .ZN(I4_FP[4]) );
  AND2_X1 I4_I3_U11 ( .A1(I4_SIG_out_21_), .A2(I4_I3_n4), .ZN(I4_FP[21]) );
  AND2_X1 I4_I3_U10 ( .A1(I4_SIG_out_19_), .A2(I4_I3_n1), .ZN(I4_FP[19]) );
  AND2_X1 I4_I3_U9 ( .A1(I4_SIG_out_16_), .A2(I4_I3_n4), .ZN(I4_FP[16]) );
  AND2_X1 I4_I3_U8 ( .A1(I4_SIG_out_13_), .A2(I4_I3_n1), .ZN(I4_FP[13]) );
  AND2_X1 I4_I3_U7 ( .A1(I4_SIG_out_10_), .A2(I4_I3_n4), .ZN(I4_FP[10]) );
  AND2_X1 I4_I3_U6 ( .A1(I4_SIG_out_9_), .A2(I4_I3_n4), .ZN(I4_FP[9]) );
  AND2_X1 I4_I3_U5 ( .A1(I4_SIG_out_3_), .A2(I4_I3_n4), .ZN(I4_FP[3]) );
  AND2_X1 I4_I3_U4 ( .A1(I4_SIG_out_6_), .A2(I4_I3_n1), .ZN(I4_FP[6]) );
  NOR2_X1 I4_I3_U3 ( .A1(isNaN), .A2(I4_isINF), .ZN(I4_I3_n5) );
  NAND3_X1 I4_I3_U47 ( .A1(I4_I3_n2), .A2(I4_I3_n3), .A3(I4_SIG_out_22_), .ZN(
        I4_I3_n14) );
endmodule

