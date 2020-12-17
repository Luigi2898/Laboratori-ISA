/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : O-2018.06-SP4
// Date      : Wed Dec  9 21:26:22 2020
/////////////////////////////////////////////////////////////


module FPmul_1 ( FP_A, FP_B, clk, FP_Z );
  input [31:0] FP_A;
  input [31:0] FP_B;
  output [31:0] FP_Z;
  input clk;
  wire   SIGN_out_stage1, isINF_stage1, isNaN_stage1, isZ_tab_stage1,
         EXP_neg_stage2, EXP_pos_stage2, SIGN_out_stage2, isINF_stage2,
         isNaN_stage2, isZ_tab_stage2, EXP_neg, EXP_pos, SIGN_out, isINF_tab,
         isNaN, isZ_tab;
  wire   [31:0] FP_Ad1;
  wire   [31:0] FP_Bd1;
  wire   [7:0] A_EXP;
  wire   [31:0] A_SIG;
  wire   [7:0] B_EXP;
  wire   [31:0] B_SIG;
  wire   [7:0] EXP_in;
  wire   [27:0] SIG_in;
  wire   [7:0] EXP_out_round;
  wire   [27:0] SIG_out_round;

  \**SEQGEN**  \FP_Ad1_reg[31]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[31]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[31]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[30]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[30]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[30]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[29]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[29]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[29]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[28]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[28]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[28]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[27]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[27]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[27]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[26]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[26]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[26]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[25]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[25]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[25]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[24]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[24]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[24]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[23]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[23]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[23]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[22]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[22]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[22]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[21]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[21]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[21]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[20]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[20]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[20]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[19]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[19]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[19]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[18]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[18]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[18]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[17]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[17]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[17]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[16]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[16]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[16]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[15]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[15]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[15]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[14]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[14]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[14]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[13]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[13]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[13]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[12]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[12]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[12]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[11]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[11]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[11]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[10]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[10]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[10]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[9]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[9]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[9]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[8]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[8]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[8]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[7]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[7]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[7]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[6]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[6]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[6]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[5]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[5]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[5]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[4]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[4]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[4]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[3]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[3]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[3]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[2]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[2]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[2]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[1]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[1]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[1]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Ad1_reg[0]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_A[0]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Ad1[0]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[31]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[31]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[31]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[30]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[30]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[30]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[29]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[29]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[29]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[28]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[28]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[28]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[27]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[27]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[27]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[26]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[26]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[26]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[25]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[25]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[25]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[24]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[24]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[24]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[23]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[23]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[23]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[22]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[22]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[22]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[21]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[21]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[21]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[20]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[20]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[20]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[19]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[19]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[19]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[18]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[18]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[18]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[17]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[17]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[17]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[16]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[16]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[16]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[15]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[15]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[15]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[14]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[14]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[14]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[13]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[13]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[13]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[12]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[12]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[12]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[11]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[11]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[11]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[10]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[10]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[10]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[9]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[9]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[9]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[8]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[8]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[8]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[7]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[7]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[7]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[6]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[6]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[6]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[5]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[5]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[5]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[4]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[4]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[4]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[3]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[3]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[3]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[2]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[2]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[2]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[1]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[1]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[1]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \FP_Bd1_reg[0]  ( .clear(1'b0), .preset(1'b0), .next_state(
        FP_B[0]), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        FP_Bd1[0]), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(
        1'b0), .synch_enable(1'b1) );
  FPmul_stage1 I1 ( .FP_A(FP_Ad1), .FP_B(FP_Bd1), .clk(clk), .A_EXP(A_EXP), 
        .A_SIG(A_SIG), .B_EXP(B_EXP), .B_SIG(B_SIG), .SIGN_out_stage1(
        SIGN_out_stage1), .isINF_stage1(isINF_stage1), .isNaN_stage1(
        isNaN_stage1), .isZ_tab_stage1(isZ_tab_stage1) );
  FPmul_stage2 I2 ( .A_EXP(A_EXP), .A_SIG(A_SIG), .B_EXP(B_EXP), .B_SIG(B_SIG), 
        .SIGN_out_stage1(SIGN_out_stage1), .clk(clk), .isINF_stage1(
        isINF_stage1), .isNaN_stage1(isNaN_stage1), .isZ_tab_stage1(
        isZ_tab_stage1), .EXP_in(EXP_in), .EXP_neg_stage2(EXP_neg_stage2), 
        .EXP_pos_stage2(EXP_pos_stage2), .SIGN_out_stage2(SIGN_out_stage2), 
        .SIG_in(SIG_in), .isINF_stage2(isINF_stage2), .isNaN_stage2(
        isNaN_stage2), .isZ_tab_stage2(isZ_tab_stage2) );
  FPmul_stage3 I3 ( .EXP_in(EXP_in), .EXP_neg_stage2(EXP_neg_stage2), 
        .EXP_pos_stage2(EXP_pos_stage2), .SIGN_out_stage2(SIGN_out_stage2), 
        .SIG_in(SIG_in), .clk(clk), .isINF_stage2(isINF_stage2), 
        .isNaN_stage2(isNaN_stage2), .isZ_tab_stage2(isZ_tab_stage2), 
        .EXP_neg(EXP_neg), .EXP_out_round(EXP_out_round), .EXP_pos(EXP_pos), 
        .SIGN_out(SIGN_out), .SIG_out_round(SIG_out_round), .isINF_tab(
        isINF_tab), .isNaN(isNaN), .isZ_tab(isZ_tab) );
  FPmul_stage4 I4 ( .EXP_neg(EXP_neg), .EXP_out_round(EXP_out_round), 
        .EXP_pos(EXP_pos), .SIGN_out(SIGN_out), .SIG_out_round(SIG_out_round), 
        .clk(clk), .isINF_tab(isINF_tab), .isNaN(isNaN), .isZ_tab(isZ_tab), 
        .FP_Z(FP_Z) );
endmodule

