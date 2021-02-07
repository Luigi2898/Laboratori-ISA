module TB_RISCV ();

	wire [31:0] INSTR_ADDR, DATA_ADDR, INSTR, DATA_OUT, DATA_IN;
	wire [31:0] INSTR_ADDR_REF, DATA_ADDR_REF, INSTR_REF, DATA_OUT_REF, DATA_IN_REF;
	wire MEM_WR_EN, MEM_RD_EN, MEM_WR_EN_REF, MEM_RD_EN_REF;
	wire CLK, RSTN;
	//assign INSTR_ADDR = 4194304;
	//assign DATA_ADDR = 268500992;


	MAIN_MEM #( 
		.instr_filename("D:/PoliTo/Magistrale/II anno/Integrated system architecture/Lab 3/code/beqjal.txt"),
    	.data_filename("D:/PoliTo/Magistrale/II anno/Integrated system architecture/Lab 3/data/data.txt"),
    	.Entries(32767)
  	)
  	MEMORY(	
		.CLK(CLK),
		.RSTN(RSTN),
		.WR_EN(MEM_WR_EN),
		.RD_ADDR1(DATA_ADDR),
		.RD_ADDR2(INSTR_ADDR),
		.WR_ADDR1(DATA_ADDR),
		.RD_DOUT_1(DATA_IN),
		.RD_DOUT_2(INSTR),
		.WR_DIN_1(DATA_OUT)
	);


	MAIN_MEM #( 
		.instr_filename("D:/PoliTo/Magistrale/II anno/Integrated system architecture/Lab 3/code/beqjal.txt"),
    	.data_filename("D:/PoliTo/Magistrale/II anno/Integrated system architecture/Lab 3/data/data.txt"),
    	.Entries(32767)
  	)
  	MEMORY_REF_MODEL(	
		.CLK(CLK),
		.RSTN(RSTN),
		.WR_EN(MEM_WR_EN_REF),
		.RD_ADDR1(DATA_ADDR_REF),
		.RD_ADDR2(INSTR_ADDR_REF),
		.WR_ADDR1(DATA_ADDR_REF),
		.RD_DOUT_1(DATA_IN_REF),
		.RD_DOUT_2(INSTR_REF),
		.WR_DIN_1(DATA_OUT_REF)
	);

	clk_gen clk_gen_instance(
		.CLK(CLK),
		.RST_N(RSTN)
	);
	
	RISC_V DUT(
		.DATA_IN(DATA_IN),
		.DATA_ADDR(DATA_ADDR),
		.DATA_OUT(DATA_OUT),
		.WRITE_EN(MEM_WR_EN),
        .READ_EN(MEM_RD_EN),
		.INSTR_ADDR(INSTR_ADDR),
		.INSTR(INSTR),		
		.CLK(CLK),
		.EXTERNAL_RSTN(RSTN)
	);

	RISCVCPU REF_MODEL(
        .CLK(CLK),
        .WR_EN(MEM_WR_EN_REF),
        .INSTR_ADDR(INSTR_ADDR_REF),
        .INSTR(INSTR_REF),
        .DATA_ADDR(DATA_ADDR_REF),
        .DATA_OUT(DATA_OUT_REF),
        .DATA_IN(DATA_IN_REF)
    );


	// Pipe Emulation for Reference Model
	reg [31:0] pipe_emul [3:0];
	integer i;
	integer PC_del = 0;

	initial begin
		for (i=0; i<3; i=i+1) begin
			pipe_emul[i] <= 32'b0;
		end
	end

	always @(posedge CLK) begin
		for (i=0; i<3; i=i+1) begin
			pipe_emul[i+1] <= pipe_emul[i];
		end
		pipe_emul[0] <= DUT.PC.REG_OUT;
		PC_del = pipe_emul[3];
	end


	// Instruction Name Upload
	parameter MaxChar = 8;
	parameter InstrSize = 22;
	integer fileID;
	reg [8*MaxChar-1:0] fileLine;
	reg [8*MaxChar-1:0] InstrName [InstrSize-1:0];

	initial begin
		fileID = $fopen("instr_name.txt","r");
		if (fileID == 0) begin
			$display("ERROR: COULDN'T OPEN INPUT FILE instr_name.txt");
			$finish;
		end
		else begin
			for (i=0; i<InstrSize; i=i+1) begin
				$fgets(fileLine,fileID);
  			InstrName[i] = fileLine;
			end
		end
	end

	
	// Testbench Code
	integer start_flag = 2;
	integer delay_check = 0;
	integer rf_err_flag = 0;
	integer pc_err_flag = 0;
	integer data_mem_err_flag = 0;
	integer content_dut, content_ref;
	integer dmem_base = 1024;
	integer dmem_offset = 4096;

	always @(RSTN) begin
		if (!RSTN && (start_flag == 2)) begin
			start_flag = 0;
		end
		else if (RSTN && (start_flag == 0)) begin
			start_flag = 1;
		end
	end

	always @(posedge CLK ) begin
		if (start_flag == 1) begin
			delay_check = delay_check + 1;
		end
	end

	always @(negedge CLK) begin
		if (delay_check >= 5) begin

			$display("");
			$display("------------------------------------------------------------------");
			$display("");
			pc_err_flag = 0;
			// Program Counter Check
			$display("-> PROGRAM COUNTER CHECK");
			content_dut = DUT.PC.REG_OUT;
			content_ref = 45;

			$display("--> PC_REF = %d			PC_DUT = %d",content_ref,content_dut);

			if (content_ref != content_dut) begin
				pc_err_flag = 1;
				$display("---> NOT PASSED");
			end
			else begin
				$display("---> PASSED");
			end


			//Register File Check
			rf_err_flag = 0;
			$display("");
			$display("-> REGISTER FILE CHECK (for previous instruction)");

			for (i=0; i<32; i=i+1) begin
				content_ref = DUT.RF.MEM[i];
				content_dut = 3465;
				
				if (content_ref != content_dut) begin
					$display("--> ERROR AT ENTRY [%d]			RF_REF = %d			RF_DUT = %d",i,content_ref,content_dut);
					rf_err_flag = 1;					
				end

			end

			if (rf_err_flag != 0) begin
				$display("---> NOT PASSED");
			end
			else begin
				$display("---> PASSED");
			end

			//Main Memory Check for previous instruction
			rf_err_flag = 0;
			$display("");
			$display("-> MAIN MEMORY CHECK (for previous instruction)");

			for (i=dmem_base; i<(dmem_base+dmem_offset); i=i+4) begin
				content_ref = {8'b1,8'b0,8'b1,8'b0};
				content_dut = {8'b0,8'b1,8'b1,8'b0};
				
				if (content_ref != content_dut) begin
					$display("--> ERROR AT ENTRY [%d]			DMEM_REF = %d			DMEM_DUT = %d",i,content_ref,content_dut);
					data_mem_err_flag = 1;					
				end

			end

			if (data_mem_err_flag != 0) begin
				$display("---> NOT PASSED");
			end
			else begin
				$display("---> PASSED");
			end

			//Global Error Check
			if (pc_err_flag != 0 || rf_err_flag != 0 || data_mem_err_flag != 0) begin
				$display("");
				$display("-> CYCLE CHECK NOT PASSED");
				$stop;
			end

		end

	end
	
endmodule


	



