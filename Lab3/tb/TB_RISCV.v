module TB_RISCV ();

	wire [31:0] INSTR_ADDR, DATA_ADDR, INSTR, DATA_OUT, DATA_IN;
	wire MEM_WR_EN, MEM_RD_EN;
	wire CLK, RSTN;
	
	INSTR_MEM  
	  #(.INITFROMFILE("../sim/test_standard.hex"),
		.ADDR_N(32),
		.DATA_WIDTH(32)	
		)
    IMEM_instance(
        .INSTR_ADDR(INSTR_ADDR[31:0]),
		.INSTR(INSTR),
	);
	
	DATA_MEM
	  #(.word_size(32),
		.filename("../sim/data.hex")
		)
	 MEM_instance(
        .CLK(CLK),
        .RSTN(RSTN),
		.DATA_IN(DATA_IN),
		.DATA_OUT(DATA_OUT),
		.ADDR(DATA_ADDR[31:0]),
		.WR_EN(MEM_WR_EN),
        .RD_EN(MEM_RD_EN),
	);
	
	clk_gen clk_gen_instance(
		.CLK(CLK),
		.RST_N(RSTN)
	);
	
	RISC_V DUT(
		.DATA_IN(DATA_IN),
		.DATA_ADDR(DATA_ADDR),
		.DATA_OUT(DATA_OUT),
		.MEM_WR_EN(MEM_WR_EN),
        .MEM_RD_EN(MEM_RD_EN),
		.INSTR_ADDR(INSTR_ADDR),
		.INSTR(INSTR),		
		.CLK(CLK),
		.EXTERNAL_RST(RSTN)
	);
	
endmodule


	


