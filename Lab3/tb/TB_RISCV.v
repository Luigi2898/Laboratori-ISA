module TB_RISCV ();

	wire [31:0] INSTR_ADDR, DATA_ADDR, INSTR, DATA_OUT, DATA_IN;
	wire MEM_WR_EN, MEM_RD_EN;
	wire CLK, RSTN;
	//assign INSTR_ADDR = 4194304;
	//assign DATA_ADDR = 268500992;
	INSTR_MEM  
	  #(.INITFILE("D:/PoliTo/Magistrale/II anno/Integrated system architecture/Lab 3/code.txt"),
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
		.filename("D:/PoliTo/Magistrale/II anno/Integrated system architecture/Lab 3/data.txt"),
		.NEL(1024)
		)
	 MEM_instance(
        .CLK(CLK),
        .RSTN(RSTN),
		.DATA_IN(DATA_IN),
		.DATA_OUT(DATA_OUT),
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
	
endmodule


	



