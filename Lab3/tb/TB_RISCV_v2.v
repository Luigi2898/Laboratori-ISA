module TB_RISCV_v2 ();

	wire [31:0] INSTR_ADDR, DATA_ADDR, INSTR, DATA_OUT, DATA_IN;
	wire [31:0] INSTR_ADDR_REF, DATA_ADDR_REF, INSTR_REF, DATA_OUT_REF, DATA_IN_REF;
	wire MEM_WR_EN, MEM_RD_EN, MEM_WR_EN_REF, MEM_RD_EN_REF;
	wire CLK, RSTN;
	//assign INSTR_ADDR = 4194304;
	//assign DATA_ADDR = 268500992;


	MAIN_MEM #( 
		.instr_filename("test_program_abs.txt"),
    	.data_filename("data.txt"),
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


	/*MAIN_MEM #( 
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
	);*/

	clk_gen clk_gen_instance(
		.CLK(CLK),
		.RST_N(RSTN)
	);
	
	RISC_V_v2 DUT(
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

	/*RISCVCPU REF_MODEL(
        .CLK(CLK),
        .WR_EN(MEM_WR_EN_REF),
        .INSTR_ADDR(INSTR_ADDR_REF),
        .INSTR(INSTR_REF),
        .DATA_ADDR(DATA_ADDR_REF),
        .DATA_OUT(DATA_OUT_REF),
        .DATA_IN(DATA_IN_REF)
    );*/


	
	
	// Instruction Name Upload
	parameter MaxChar = 6;
	parameter InstrSize = 22;
	integer fileID;
	integer i;
	reg [8*MaxChar-1:0] fileLine;
	reg [8*MaxChar-1:0] InstrName [InstrSize-1:0];
	reg [8*MaxChar-1:0] IF_instr_name;
	reg [8*MaxChar-1:0] ID_instr_name;
	reg [8*MaxChar-1:0] EXE_instr_name;
	reg [8*MaxChar-1:0] MEM_instr_name;
	reg [8*MaxChar-1:0] WB_instr_name;
	integer IF_instr;
	integer ID_instr;
	integer EXE_instr;
	integer MEM_instr;
	integer WB_instr;
	integer cycle_cnt = 0;

	initial begin
		fileID = $fopen("instr_name.txt","r");
		if (fileID == 0) begin
			$display("ERROR: COULDN'T OPEN INPUT FILE instr_name.txt");
			//$finish;
		end
		else begin
			for (i=0; i<InstrSize; i=i+1) begin
				$fgets(fileLine,fileID);
  			InstrName[i] = fileLine[8*MaxChar-1:8];
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


	always @(negedge CLK) begin
		if (start_flag == 1) begin

			cycle_cnt = cycle_cnt + 1;

			// Pipeline State Monitor
			IF_instr_name = InstrName[DUT.PC.REG_OUT/4];
			ID_instr_name = InstrName[DUT.DEBUG_PC_IF_ID.REG_OUT/4];
			EXE_instr_name = InstrName[DUT.DEBUG_PC_ID_EXE.REG_OUT/4];
			MEM_instr_name = InstrName[DUT.DEBUG_PC_EXE_MEM.REG_OUT/4];
			WB_instr_name = InstrName[DUT.DEBUG_PC_MEM_WB.REG_OUT/4];

			IF_instr = DUT.PC.REG_OUT;
			ID_instr = DUT.DEBUG_PC_IF_ID.REG_OUT;
			EXE_instr = DUT.DEBUG_PC_ID_EXE.REG_OUT;
			MEM_instr = DUT.DEBUG_PC_EXE_MEM.REG_OUT;
			WB_instr = DUT.DEBUG_PC_MEM_WB.REG_OUT;

			
			$display("\n\n----------------------------------------------------------------------------------------------------------------");
			$display("\n\n--------------------------------------------------------------------");
			$display("--------------------------------------------------------------------");
			$display("------------------ MACHINE CYCLE %d -----------------------	", cycle_cnt);
			$display("--------------------------------------------------------------------");
			$display("--------------------------------------------------------------------");

			$display("\n\n-----------------------------------------------------------");
			$display("------------------ PIPELINE STATE TABLE -------------------	");
			$display("-----------------------------------------------------------");
			$display("         IF          ID         EXE         MEM          WB");
			$display("     %s      %s      %s      %s      %s", IF_instr_name, ID_instr_name, EXE_instr_name, MEM_instr_name, WB_instr_name);
			$display("%d %d %d %d %d", IF_instr, ID_instr, EXE_instr, MEM_instr, WB_instr);
			$display("-----------------------------------------------------------");

				$display("\n\n-----------------------------------------------------------");
			$display("------------------ REGISTER FILE CONTENT ------------------	");
			$display("-----------------------------------------------------------");
			for (i=0; i<32; i=i+1) begin
				$display("ENTRY %d] %d ",i,DUT.RF.MEM[i]);
			end
			$display("-----------------------------------------------------------");

			$display("\n\n-----------------------------------------------------------");
			$display("------------------ REGISTER FILE ADDRESSES ----------------	");
			$display("-----------------------------------------------------------");
			$display("RD_ADDR 1] %d  RD_ADDR 2] %d",DUT.RF.RD1_ADDR, DUT.RF.RD2_ADDR);
			$display("  WR_ADDR] %d     WR_DIN] %d", DUT.RF.WR1_ADDR, DUT.RF.WR1_DIN);
			$display("-----------------------------------------------------------");

			$display("\n\n---------------------------------------------------------------------------");
			$display("------------------ MAIN MEMORY ADDRESSES ----------------------------------	");
			$display("---------------------------------------------------------------------------");
      $display("DATA_RD_ADDR] %d  DATA_WR_ADDR] %d  DATA_WR_DIN] %d",MEMORY.RD_ADDR1,MEMORY.WR_ADDR1,MEMORY.WR_DIN_1);
			$display("---------------------------------------------------------------------------");





			$display("\n\n------------------------------------------------------------");
			$display("------------------ ALU OPERANDS & RESULT -------------------	");
			$display("------------------------------------------------------------");
			$display("INPUT 1] %d  INPUT 2] %d  RESULT] %d",DUT.ALU_EXE.DATA1_IN, DUT.ALU_EXE.DATA2_IN, DUT.ALU_EXE.RESULT_OUT);
			$display("------------------------------------------------------------");
			




		end

		

	end
	
endmodule


	



