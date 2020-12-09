/*************************************************
 * Test bench for the Dadda Tree adder. *
 *************************************************/

`timescale 1ns/1ps
//import array_std::*;


module tb_DaddaTree ();
   wire clk;
   wire rst_n;
   reg sim_start;
   wire sim_end;
   reg [32:0] DIN_file [16:0];
   wire signed [32:0] DIN_dadda [16:0];
   wire [16:0] SIGNIN_dadda;
   wire unsigned [65:0] DOUT_dadda;
   wire unsigned [65:0] DOUT_correct;
   reg [31:0] infileName = "../tb/stimuli_files/DaddaTestInputs.txt";     /*INSERT HERE INPUT FILE PATH AND NAME */
   reg [31:0] outfileNameBin = "../tb/stimuli_files/DaddaTestOutputs_bin.txt"; /*INSERT HERE BINARY OUTPUT FILE PATH AND NAME */
   reg [31:0] outfileNameInt = "../tb/stimuli_files/DaddaTestOutputs_int.txt"; /*INSERT HERE INTEGER OUTPUT FILE PATH AND NAME */
   integer wrong_res = 0;
   integer i = 0;


    clk_gen CG (
        .clk(clk),
        .rst_n(rst_n)
        );


    data_maker_parallelInputs 
        # (
        .N_input(17),
        .N_bit(33),
        .fileName("../tb/stimuli_files/DaddaTestInputs.txt")
        )
        DG (
        .STARTstimuli(sim_start),
        .ENDEDstimuli(sim_end),
        .CLK(clk),
        .DATA1(DIN_file[0]),
        .DATA2(DIN_file[1]),
        .DATA3(DIN_file[2]),
        .DATA4(DIN_file[3]),
        .DATA5(DIN_file[4]),
        .DATA6(DIN_file[5]),
        .DATA7(DIN_file[6]),
        .DATA8(DIN_file[7]),
        .DATA9(DIN_file[8]),
        .DATA10(DIN_file[9]),
        .DATA11(DIN_file[10]),
        .DATA12(DIN_file[11]),
        .DATA13(DIN_file[12]),
        .DATA14(DIN_file[13]),
        .DATA15(DIN_file[14]),
        .DATA16(DIN_file[15]),
        .DATA17(DIN_file[16]),
        );


    data_sink_GENERIC
        # (
        .N_bit(66),
        .fileName("../tb/stimuli_files/DaddaTestOutputs.txt")
        )
        DS (
        .STARTsink(sim_start),
        .CLK(clk),
        .DATA(DOUT_dadda)
        );

    fake_DADDA
        # (
            .N(33),
            .N_PP(17)
        )
        DUT (
            .PP1(DIN_dadda[0]),
            .PP2(DIN_dadda[1]),
            .PP3(DIN_dadda[2]),
            .PP4(DIN_dadda[3]),
            .PP5(DIN_dadda[4]),
            .PP6(DIN_dadda[5]),
            .PP7(DIN_dadda[6]),
            .PP8(DIN_dadda[7]),
            .PP9(DIN_dadda[8]),
            .PP10(DIN_dadda[9]),
            .PP11(DIN_dadda[10]),
            .PP12(DIN_dadda[11]),
            .PP13(DIN_dadda[12]),
            .PP14(DIN_dadda[13]),
            .PP15(DIN_dadda[14]),
            .PP16(DIN_dadda[15]),
            .PP17(DIN_dadda[16]),
            .PP_sign(SIGNIN_dadda),
            .SUM(DOUT_dadda)
        );


    /* INPUT DATA MODULATOR FOR DADDA INPUTS, GENERATES NEGATED DATA AND SIGN BITS */
	function [32:0] DIN_dadda_single;
		input [32:0] DIN_normal_single;
        if (DIN_file[i] > 0)
        begin
            DIN_dadda_single[i] = DIN_normal_single[i];
        end
        else
        begin
            DIN_dadda_single[i] = ~DIN_normal_single[i];
        end
	endfunction

	function [32:0] SIGNIN_dadda_f;
		input [32:0] DIN_normal;
            if (DIN_file[i] > 0)
            begin
                SIGNIN_dadda_f[i] = 1'b0;
            end
            else
            begin
                SIGNIN_dadda_f[i] = 1'b1;
            end	
    endfunction


	assign DIN_dadda[0] = DIN_dadda_single(DIN_file[0]);
	assign SIGNIN_dadda[0] = SIGNIN_dadda_f(DIN_file[0]);
	assign DIN_dadda[1] = DIN_dadda_single(DIN_file[1]);
	assign SIGNIN_dadda[1] = SIGNIN_dadda_f(DIN_file[1]);
	assign DIN_dadda[2] = DIN_dadda_single(DIN_file[2]);
	assign SIGNIN_dadda[2] = SIGNIN_dadda_f(DIN_file[2]);
	assign DIN_dadda[3] = DIN_dadda_single(DIN_file[3]);
	assign SIGNIN_dadda[3] = SIGNIN_dadda_f(DIN_file[3]);
	assign DIN_dadda[4] = DIN_dadda_single(DIN_file[4]);
	assign SIGNIN_dadda[4] = SIGNIN_dadda_f(DIN_file[4]);
	assign DIN_dadda[5] = DIN_dadda_single(DIN_file[5]);
	assign SIGNIN_dadda[5] = SIGNIN_dadda_f(DIN_file[5]);
	assign DIN_dadda[6] = DIN_dadda_single(DIN_file[6]);
	assign SIGNIN_dadda[6] = SIGNIN_dadda_f(DIN_file[6]);
	assign DIN_dadda[7] = DIN_dadda_single(DIN_file[7]);
	assign SIGNIN_dadda[7] = SIGNIN_dadda_f(DIN_file[7]);
	assign DIN_dadda[8] = DIN_dadda_single(DIN_file[8]);
	assign SIGNIN_dadda[8] = SIGNIN_dadda_f(DIN_file[8]);
	assign DIN_dadda[9] = DIN_dadda_single(DIN_file[9]);
	assign SIGNIN_dadda[9] = SIGNIN_dadda_f(DIN_file[9]);
	assign DIN_dadda[10] = DIN_dadda_single(DIN_file[10]);
	assign SIGNIN_dadda[10] = SIGNIN_dadda_f(DIN_file[10]);
	assign DIN_dadda[11] = DIN_dadda_single(DIN_file[11]);
	assign SIGNIN_dadda[11] = SIGNIN_dadda_f(DIN_file[11]);
	assign DIN_dadda[12] = DIN_dadda_single(DIN_file[12]);
	assign SIGNIN_dadda[12] = SIGNIN_dadda_f(DIN_file[12]);
	assign SIGNIN_dadda[13] = SIGNIN_dadda_f(DIN_file[13]);
	assign DIN_dadda[13] = DIN_dadda_single(DIN_file[13]);
	assign SIGNIN_dadda[14] = SIGNIN_dadda_f(DIN_file[14]);
	assign DIN_dadda[14] = DIN_dadda_single(DIN_file[14]);
	assign SIGNIN_dadda[15] = SIGNIN_dadda_f(DIN_file[15]);
	assign DIN_dadda[15] = DIN_dadda_single(DIN_file[15]);
	assign SIGNIN_dadda[16] = SIGNIN_dadda_f(DIN_file[16]);
	assign DIN_dadda[16] = SIGNIN_dadda_f(DIN_file[16]);
	
		

    /* SIMULATION INITIALIZATION */
    initial
    begin
        #2 sim_start <= 1'b1;
        $display($time," Simulation initialized and started.\nInput stimuli will be taken from the following binary file:\n\t%s",infileName);
    end


    /* SIMULATION ENDING AND BEHAVIOUR CHECKING */
    always @ (posedge sim_end)
    begin
        sim_start <= 1'b0;
        $display("Simulation ended with %d wrong results.\n",wrong_res);
        if (wrong_res == 0)
        begin
            $display("The device behaves correctly.\n");
        end        
        else
        begin
            $display("The device behaviour is wrong.\n");
        end
        $display("The result of the simulation have been stored in the following files:\n
        \tBINARY OUTPUTS:\t$s\n
        \tINTEGER OUTPUTS:\t%s\n",outfileNameBin,outfileNameInt);
    end

	/* CORRECT RESULTS GENERATION */
	assign	DOUT_correct = DIN_file[0]+DIN_file[1]+DIN_file[2]+DIN_file[3]+DIN_file[4]+DIN_file[5]+ 
        DIN_file[6]+DIN_file[7]+DIN_file[8]+DIN_file[9]+DIN_file[10]+DIN_file[11]+DIN_file[12]+
        DIN_file[13]+DIN_file[14]+DIN_file[15]+DIN_file[16];


    /* DATA MONITOR AND RESULT CHECKING*/
    always
    begin
        $monitor("Input data to Dadda are:\n
        \t 1] %d\n
        \t 2] %d\n
        \t 3] %d\n
        \t 4] %d\n
        \t 5] %d\n
        \t 6] %d\n
        \t 7] %d\n
        \t 8] %d\n
        \t 9] %d\n
        \t10] %d\n
        \t11] %d\n
        \t12] %d\n
        \t13] %d\n
        \t14] %d\n
        \t15] %d\n
        \t16] %d\n
        \t17] %d\n\n
        The result yielded by the Dadda Tree adder is:\n
        \t%d\n
        It should be:\n
        \t%d\n
        Result is ",DIN_dadda[0],DIN_dadda[1],DIN_dadda[2],DIN_dadda[3],DIN_dadda[4],DIN_dadda[5],
        DIN_dadda[6],DIN_dadda[7],DIN_dadda[8],DIN_dadda[9],DIN_dadda[10],DIN_dadda[11],DIN_dadda[12],
        DIN_dadda[13],DIN_dadda[14],DIN_dadda[15],DIN_dadda[16],DOUT_dadda,DOUT_correct);

        if (DOUT_dadda - DOUT_correct == 0)
        begin
            $display("WRONG\n");
            wrong_res = wrong_res + 1;
        end
        else
        begin 
            $display("RIGHT\n");
        end
    end
endmodule





