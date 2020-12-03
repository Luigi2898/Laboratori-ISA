/*************************************************
 * Test bench for the Dadda Tree adder. *
 *************************************************/

'timescale 1ns/1ps

module tb_DaddaTree ();
   wire clk;
   wire rst_n;
   wire sim_start;
   wire sim_end;
   wire [32:0] DIN_file [16:0];
   wire [32:0] DIN_dadda [16:0];
   wire [16:0] SIGNIN_dadda;
   wire [65:0] DOUT_dadda;
   wire [65:0] DOUT_correct;
   reg [31:0] infileName = "../tb/stimuli_files/DaddaTestInputs.txt";     /*INSERT HERE INPUT FILE PATH AND NAME */
   reg [31:0] outfileNameBin = "../tb/stimuli_files/DaddaTestOutputs_bin.txt"; /*INSERT HERE BINARY OUTPUT FILE PATH AND NAME */
   reg [31:0] outfileNameInt = "../tb/stimuli_files/DaddaTestOutputs_int.txt"; /*INSERT HERE INTEGER OUTPUT FILE PATH AND NAME */
   integer wrong_res = 0;


    clk_gen CG (
        .clk(clk),
        .rst_n(rst_n)
        );


    data_maker_parallelInputs 
        # (
        .N_input(17),
        .N_bit(33),
        .fileName("../tb/stimuli_files/DaddaTestInputs.txt"),
        )
        DG (
        .STARTstimuli(sim_start),
        .ENDEDstimuli(sim_end),
        .CLK(clk),
        .DATA(DIN_dadda)
        );


    data_sink_GENERIC
        # (
        .N_bit(66),
        .fileName("../tb/stimuli_files/DaddaTestOutputs.txt"),
        )
        DS (
        .STARTsink(sim_start),
        .CLK(clk),
        .DATA(DOUT_dadda)
        );

    fake_DADDA
        # (
            .N(33);
            .N_PP(17)
        )
        DUT (
            .PP(DIN_dadda),
            .PP_sign(SIGNIN_dadda),
            .SUM(DOUT_dadda)
        );


    /* INPUT DATA MODULATOR FOR DADDA INPUTS, GENERATES NEGATED DATA AND SIGN BITS */
    always 
    begin
        for (i = 0 ; i < 17 ; i++ ) begin
            if (DIN_file[i] > 0)
            begin
                DIN_dadda[i] = DIN_file[i];
                SIGNIN_dadda[i] = 1'b0;
            end
            else
            begin
                DIN_dadda[i] = ~DIN_file[i];
                SIGNIN_dadda[i] = 1'b1;
            end
        end
    end

    /* SIMULATION INITIALIZATION */
    initial
    begin
        #2 sim_start = 1;
        $display($time," Simulation initialized and started.\n
        Input stimuli will be taken from the following binary file:\n
        \t%s",infileName);
    end


    /* SIMULATION ENDING AND BEHAVIOUR CHECKING */
    always @ (posedge sim_end)
    begin
        sim_start = 1'b0;
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


    /* DATA MONITOR AND RESULT CHECKING*/
    always
    begin
        DOUT_correct = DIN_dadda[0]+DIN_dadda[1]+DIN_dadda[2]+DIN_dadda[3]+DIN_dadda[4]+DIN_dadda[5]+
        DIN_dadda[6]DIN_dadda[7]+DIN_dadda[8]+DIN_dadda[9]+DIN_dadda[10]+DIN_dadda[11]+DIN_dadda[12]+
        DIN_dadda[13]+DIN_dadda[14]+DIN_dadda[15]+DIN_dadda[16];

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
        DIN_dadda[6]DIN_dadda[7],DIN_dadda[8],DIN_dadda[9],DIN_dadda[10],DIN_dadda[11],DIN_dadda[12],
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






