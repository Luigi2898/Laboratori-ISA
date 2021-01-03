/*************************************************
 * Test bench for the Dadda Tree adder. *
 *************************************************/

`timescale 1ns/1ps
//import array_std::*;


module TB_CACHE ();
   wire clk;
   wire rst_n;
   reg sim_start;
   wire sim_end;
   reg rd_en;
   reg [31:0] readAddr;
   reg [31:0] readCont;
   reg [31:0] writeAddr;
   reg [31:0] writeCont;
   reg [31:0] memOut;
   reg hitMissN;
   reg [31:0] infileName = "../tb/stimulus_files/DaddaTestInputs.txt";     /*INSERT HERE INPUT FILE PATH AND NAME */
   reg [31:0] outfileNameBin = "../tb/stimulus_files/DaddaTestOutputs_bin.txt"; /*INSERT HERE BINARY OUTPUT FILE PATH AND NAME */
   reg [31:0] outfileNameInt = "../tb/stimulus_files/DaddaTestOutputs_int.txt"; /*INSERT HERE INTEGER OUTPUT FILE PATH AND NAME */
   integer wrong_res = 0;
   integer res = 0;
   integer i = 0;
   reg settle_flag = 1;
   integer end_sim = 0;



    always begin
            clk = 1'b1;     
            #5; // high for 20 * timescale = 20 ns

            clk = 1'b0;
            #5; // low for 20 * timescale = 20 ns
    end

    initial begin
        sim_start = 1'b0;
        #40
        sim_start = 1'b1;
        #100000000000000
    end

    initial begin
        rd_en = 1'b0;
        wr_en = 1'b0;
        write1 = 1'b0;
        write2 = 1'b0;
        #40
        wr_en = 1'b1;
        write1 = 1'b1;
        #40960
        wr_en = 1'b0;
        write1 = 1'b1;
        #20
        red_en = 1'b1;
        #40960
        rd_en = 1'b0;
        #20
        wr_en = 1'b1;
        write2 = 1'b1;
        #40960
        wr_en = 1'b0;
        write2 = 1'b0;
        #100000000000000000
    end
    
    always @(posedge clk) begin
        if (sim_start && write1) begin
            $readmemh("./stimulus_files/cache_stim/FirstWriteBin.txt", writeAddr);
            $readmemh("./stimulus_files/cache_stim/FirstWriteContentBin.txt", writeCont);
        end
        else if (sim_start && write2) begin 
            $readmemh("./stimulus_files/cache_stim/SecondWriteBin.txt", writeAddr);
            $readmemh("./stimulus_files/cache_stim/SecondWriteContentBin.txt", writeCont);
        end
    end

    always @(posedge clk) begin
        if (sim_start && rd_en) begin
            $readmemh("./stimulus_files/cache_stim/ReadAddrBin.txt", readAddr);
        end
    end

    CACHE_MEM #(
        .SetNum(4),
        .SetEntries(1024),
        .TagSize(22),
        .ContentSize(32),
        .AddrBits(32),
        .SetBits(1),
        .EntriesBits(10)
    );
    DUT (
        .CLK(clk),
        .RSTN(rst_n),
        .RD_ADDR(readAddr),
        .WR_ADDR(writeAddr),
        .WR_EN(wr_en),
        .RD_EN(rd_en),
        .DIN(writeCont),
        .DOUT(memOut),
        .HIT_MISSN(hitMissN)
    );
    


    
endmodule
