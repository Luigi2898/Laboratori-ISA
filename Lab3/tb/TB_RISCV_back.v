module TB_RISCV_back ();

	wire [31:0] INSTR_ADDR, DATA_ADDR, INSTR, DATA_OUT, DATA_IN;
	wire [31:0] INSTR_ADDR_REF, DATA_ADDR_REF, INSTR_REF, DATA_OUT_REF, DATA_IN_REF;
	wire MEM_WR_EN, MEM_RD_EN, MEM_WR_EN_REF, MEM_RD_EN_REF;
	wire CLK, RSTN;
	//assign INSTR_ADDR = 4194304;
	//assign DATA_ADDR = 268500992;


	MAIN_MEM #( 
		.instr_filename("../code/minrsv.txt"),
    	.data_filename("../data/data.txt"),
    	.Entries(32767)
  	)
  	MEMORY(	
		.CLK(CLK),
		.RSTN(RSTN),
		.WR_EN(MEM_WR_EN),
		.RD_EN(MEM_RD_EN),
		.RD_ADDR1(DATA_ADDR),
		.RD_ADDR2(INSTR_ADDR),
		.WR_ADDR1(DATA_ADDR),
		.RD_DOUT_1(DATA_IN),
		.RD_DOUT_2(INSTR),
		.WR_DIN_1(DATA_OUT)
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

endmodule


	



