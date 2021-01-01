module TB_CONTROL_ALU ();

  wire[6:0] OPCODE;
  wire BPU_MISSPRED;
  wire EX_ALUSRC_OUT;
  wire EX_ALUCTRL_OUT;
  wire EX_ALUEN_OUT;
  wire M_RD_OUT;
  wire M_WR_OUT;
  wire WB_RFEN_OUT;
  wire WB_RFMUX_OUT;
  wire IMM_EN_OUT;
  wire[2:0] IMM_CODE_OUT;
  wire BPU_BRANCH;
  wire PIPE_FLUSH;
  wire[2:0] FUNC_IN;
  wire[5:0] CODE_OUT;
  wire ZF_OUT;
  wire NF_OUT;
  wire[31:0] RESULT_OUT;
  wire[31:0] DATA1_IN;
  wire[31:0] DATA2_IN;

  CU controlUnit(
      .OPCODE(OPCODE),         
      .BPU_MISSPRED(BPU_MISSPRED),   
      .EX_ALUSRC_OUT(EX_ALUSRC_OUT),  
      .EX_ALUCTRL_OUT(EX_ALUCTRL_OUT), 
      .EX_ALUEN_OUT(EX_ALUEN_OUT),   
      .M_RD_OUT(M_RD_OUT),       
      .M_WR_OUT(M_WR_OUT),       
      .WB_RFEN_OUT(WB_RFEN_OUT),    
      .WB_RFMUX_OUT(WB_RFMUX_OUT),   
      .IMM_EN_OUT(IMM_EN_OUT),     
      .IMM_CODE_OUT(IMM_CODE_OUT),   
      .BPU_BRANCH(BPU_BRANCH),     
      .PIPE_FLUSH(PIPE_FLUSH)
  );

  ALU_CTRL ALUController(
      .EN_IN(EX_ALUEN_OUT),
      .CTRL_IN(EX_ALUCTRL_OUT),
      .FUNC_IN(FUNC_IN),
      .CODE_OUT(CODE_OUT)
  );

  ALU ALUundertest(
      .DATA1_IN(DATA1_IN),
      .DATA2_IN(DATA2_IN),
      .OPCODE_IN(CODE_OUT),
      .ZF_OUT(ZF_OUT),
      .NF_OUT(NF_OUT),
      .RESULT_OUT(RESULT_OUT)
  );

endmodule
