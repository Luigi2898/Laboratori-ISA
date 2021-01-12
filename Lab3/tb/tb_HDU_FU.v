`timescale 10 ns/ 1 ns

module tb_HDU_FU();

    wire CLK_i;
    wire RST_n_i;
    wire SIM_END_i;
    wire [31:0] INSTR;
    reg [4:0] RS1_ID_IN;
    reg [4:0] RS2_ID_IN;
    reg [4:0] RS1_EXE_IN;
    reg [4:0] RS2_EXE_IN;
    reg [4:0] RD_EX_IN;
    reg [4:0] RD_MEM_IN;
    reg [4:0] RD_WB_IN;
    reg REG_WR_EX;
    reg REG_WR_WB;
    reg REG_WR_MEM;
    reg LOAD_EXE_IN;
    wire [5:0] FORWARD;
    wire [1:0] FORWARD_A;
    wire [1:0] FORWARD_B;
    wire STALL;
    reg [31:0] pipe_reg [3:0];
    reg [1:0] ctrl_pipe [2:0];
    
    reg[6:0] OPCODE;
    wire BPU_MISSPRED;
    wire BPU_PREDICTION;
    wire EX_ALUSRC_OUT;
    wire EX_ALUCTRL_OUT;
    wire EX_ALUEN_OUT;
    wire M_RD_OUT;
    wire M_WR_OUT;
    wire WB_RFEN_OUT;
    wire WB_RFMUX_OUT;
    wire IMM_EN_OUT;
    wire [2:0] IMM_CODE_OUT;
    wire PIPE_FLUSH;
    wire JUMP;
    wire DP_RST;

   

    HDU     DUT(.RS1_ID_IN(RS1_ID_IN),
                .RS2_ID_IN(RS2_ID_IN),
                .RS1_EXE_IN(RS1_EXE_IN),
                .RS2_EXE_IN(RS2_EXE_IN),
                .RD_EX_IN(RD_EX_IN),
                .RD_MEM_IN(RD_MEM_IN),
                .RD_WB_IN(RD_WB_IN),
                .LOAD_EXE_IN(LOAD_EXE_IN),
                .REG_WR_WB(REG_WR_WB),
                .REG_WR_MEM(REG_WR_MEM),
                .REG_WR_EX(REG_WR_EX),
                .IMM_COD(IMM_CODE_OUT),
                .STALL(STALL),
                .FORWARD(FORWARD)
                );

    CU CU_DUT(.RST(RST_n_i),
              .OPCODE(pipe_reg[0][6:0]),
              .BPU_MISSPRED(BPU_MISSPRED),
              .BPU_PREDICTION(BPU_PREDICTION),
              .HDU_STALL(STALL),
              .HDU_FORWARD(FORWARD),
              .EX_ALUSRC_OUT(EX_ALUSRC_OUT),
              .EX_ALUCTRL_OUT(EX_ALUCTRL_OUT),
              .EX_ALUEN_OUT(EX_ALUEN_OUT),
              .M_RD_OUT(M_RD_OUT),
              .M_WR_OUT(M_WR_OUT),
              .WB_RFEN_OUT(WB_RFEN_OUT),
              .WB_RFMUX_OUT(WB_RFMUX_OUT),
              .IMM_EN_OUT(IMM_EN_OUT),
              .IMM_CODE_OUT(IMM_CODE_OUT),
              .PIPE_FLUSH(PIPE_FLUSH),
              .PIPE_STALL(PIPE_STALL),
              .JUMP(JUMP),
              .FORWARD_B(FORWARD_B),
              .FORWARD_A(FORWARD_A),
              .DP_RST(DP_RST)
              );            

    clk_gen CG (
        .CLK(CLK_i),
        .RST_n(RST_n_i)
        );

    DATA_MAKER_HDU #("../tb/stimulus_files/HazardTest.txt")
     DG(.CLK(CLK_i),
        .SIM_END(SIM_END_i),
        .STALL(PIPE_STALL),
	      .DATA(INSTR)
       );

    

    always @ (posedge (CLK_i))         
    begin
   
    LOAD_EXE_IN = 1'b0;  
    REG_WR_WB = 1'b0;
    REG_WR_MEM = 1'b0;
    REG_WR_EX = 1'b0;
      
    
    pipe_reg[3][31:0] = pipe_reg[2][31:0];    
    pipe_reg[2][31:0] = pipe_reg[1][31:0];
    pipe_reg[1][31:0] = pipe_reg[0][31:0]; 
    if(PIPE_STALL == 1'b0) begin
    pipe_reg[0] = INSTR;
    ctrl_pipe[2][1:0] = ctrl_pipe[1][1:0];
    ctrl_pipe[1][1:0] = ctrl_pipe[0][1:0];
    ctrl_pipe[0] = {WB_RFEN_OUT,M_RD_OUT};
    end
    else begin
    ctrl_pipe[2][1:0] = ctrl_pipe[1][1:0];
    ctrl_pipe[1][1:0] = ctrl_pipe[0][1:0];
    ctrl_pipe[0] = {1'b0,1'b0};
    end 

    
    
    if(ctrl_pipe[0][0] == 1'b1) begin
      LOAD_EXE_IN = 1'b1;      
    end
    
    if(ctrl_pipe[0][1] == 1'b1) begin
      REG_WR_EX = 1'b1;
    end
    else begin
      REG_WR_EX = 1'b0;
    end

    if(ctrl_pipe[2][1] == 1'b1) begin
      REG_WR_WB = 1'b1;
    end
    else begin
      REG_WR_WB = 1'b0;
    end

    if(ctrl_pipe[1][1] == 1'b1) begin
      REG_WR_MEM = 1'b1;
    end
    else begin
      REG_WR_MEM = 1'b0;
    end

    RS1_ID_IN = pipe_reg[0][19:15];
    RS2_ID_IN = pipe_reg[0][24:20];
    RS1_EXE_IN = pipe_reg[1][19:15];
    RS2_EXE_IN = pipe_reg[1][24:20];
    RD_EX_IN = pipe_reg[1][11:7];
    RD_MEM_IN = pipe_reg[2][11:7];
    RD_WB_IN = pipe_reg[3][11:7];

    end     

    
    
endmodule
