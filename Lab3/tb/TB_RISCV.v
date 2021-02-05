module TB_RISCV ();

	wire [31:0] INSTR_ADDR, DATA_ADDR, INSTR, DATA_OUT, DATA_IN;
	wire MEM_WR_EN, MEM_RD_EN;
	wire CLK, RSTN;
	//assign INSTR_ADDR = 4194304;
	//assign DATA_ADDR = 268500992;
	INSTR_MEM  
	  #(.INITFILE("code.txt"),
		.ADDR_N(32),
		.DATA_WIDTH(32),
		.NEL(22)
		)
    IMEM_instance(
        .INSTR_ADDR(INSTR_ADDR[31:0]),
		.INSTR(INSTR)
	);
	
	DATA_MEM
	  #(.word_size(32),
		.filename("data.txt"),
		.NEL(1024)
		)
	 MEM_instance(
        .CLK(CLK),
        .RSTN(RSTN),
		.DATA_IN(DATA_OUT),
		.DATA_OUT(DATA_IN),
		.ADDR(DATA_ADDR[31:0]),
		.WR_EN(MEM_WR_EN),
        .RD_EN(MEM_RD_EN)
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
			content_dut = 44;
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
			$display("-> REGISTER FILE CHECK");

			for (i=0; i<32; i=i+1) begin
				content_ref = 34;
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


	



