
`timescale 1ns/1ps



module TB_BPU ();
   reg clk;
   reg rst_n;
   reg sim_start;
   integer i = 0;
   reg [7:0] PC, PC_DEL ;
   reg JMP_FLAG;
   reg [6:0]OPCODE;
   reg [7:0]TARG_ADDR;

   wire [7:0] TA_OUT ;
   wire PRED_OUT;

   reg [7:0] PC_MEM [101:0];
   reg [7:0] PC_MEM_DEL [101:0];
   reg JMP_MEM [101:0];
   reg [7:0] TARG_ADDR_MEM [101:0];
   reg [7:0] OPCODE_MEM [101:0];

    always begin
      clk = 1'b1;     
      #5; // high for 20 * timescale = 20 ns

      clk = 1'b0;
      #5; // low for 20 * timescale = 20 ns
    end

    initial begin
      sim_start = 1'b0;
      rst_n = 1'b1;
      #2
      rst_n = 1'b0;
      #2
      rst_n = 1'b1;
      sim_start = 1'b1;
    end

    

	initial begin
		$display("Initializing stimuli files...");
		$readmemb("./stimulus_files/bpu_stim/PC.txt", PC_MEM);
    $readmemb("./stimulus_files/bpu_stim/PC_DEL.txt", PC_MEM_DEL);
    $readmemb("./stimulus_files/bpu_stim/JMP_FLAG.txt", JMP_MEM);
    $readmemb("./stimulus_files/bpu_stim/TARG_ADDR.txt", TARG_ADDR_MEM);
    $readmemb("./stimulus_files/bpu_stim/OPCODE.txt", OPCODE_MEM);
		$display("Done!");
	end
    
    always @(posedge clk) begin
        if (sim_start) begin
          PC = PC_MEM[i];
			PC_DEL = PC_MEM_DEL[i];
          JMP_FLAG = JMP_MEM[i];
          TARG_ADDR = TARG_ADDR_MEM[i];
          OPCODE = OPCODE_MEM[i];
          i = i + 1;
		    end
        else begin
          PC = 8'd0;
PC_DEL = 8'd0;
          JMP_FLAG = 1'd0;
          TARG_ADDR = 8'd0;
          OPCODE = 7'd0;
		    end
    end

    BPU DUT (
        .CLK(clk),
        .RSTN(rst_n),
        .PC(PC),
        .PC_D2(PC_DEL),
        .OPCODE_D2(OPCODE),
        .OUTCOME(JMP_FLAG),
        .TARGET_ADDRESS_IN(TARG_ADDR),
        .TARGET_ADDRESS_OUT(TA_OUT),
        .PREDICTION(PRED_OUT)
    );
    
    
endmodule
