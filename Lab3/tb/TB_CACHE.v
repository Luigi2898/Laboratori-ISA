/*************************************************
 * Test bench for the Dadda Tree adder. *
 *************************************************/

`timescale 1ns/1ps
//import array_std::*;


module TB_CACHE ();
   reg clk;
   reg rst_n;
   reg sim_start;
   wire sim_end;
   reg rd_en;
   reg wr_en; 
   reg write1, write2;
   reg [7:0] readAddr;
   reg [7:0] readCont;
   reg [7:0] writeAddr;
   reg [7:0] writeCont;
   reg [7:0] write1AddrMemory [31:0];
   reg [7:0] write1ContMemory [31:0];
   reg [7:0] write2AddrMemory [31:0];
   reg [7:0] write2ContMemory [31:0];
   reg [7:0] readMemory [31:0];
   integer index1 = 0, index2 = 0, index3 = 0;
   wire [7:0] memOut;
   wire hitMissN;
   



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
        #26
        sim_start = 1'b1;
    end

    initial begin
        rd_en = 1'b0;
        wr_en = 1'b0;
        write1 = 1'b0;
        write2 = 1'b0;
        #33
		write1 = 1'b1;
		#10
        wr_en = 1'b1;
        #310
        write1 = 1'b0;
		#10
        wr_en = 1'b0;
        #20
        rd_en = 1'b1;
        #320
        rd_en = 1'b0;
        #20
        wr_en = 1'b1;
        write2 = 1'b1;
        #320
        wr_en = 1'b0;
        write2 = 1'b0;
    end

	initial begin
		$display("Initializing stimuli files...");
		$readmemb("./stimulus_files/cache_stim/FirstWriteAddrBin.txt", write1AddrMemory);
        $readmemb("./stimulus_files/cache_stim/FirstWriteContentBin.txt", write1ContMemory);
        $readmemb("./stimulus_files/cache_stim/SecondWriteAddrBin.txt", write2AddrMemory);
        $readmemb("./stimulus_files/cache_stim/SecondWriteContentBin.txt", write2ContMemory);
        $readmemb("./stimulus_files/cache_stim/ReadAddrBin.txt", readMemory);
		$display("Done!");
	end
    
    always @(posedge clk) begin
        if (sim_start && write1) begin
            writeAddr = write1AddrMemory[index1];
            writeCont = write1ContMemory[index1];
			if (index2 < 7) begin
            index1 = index1 + 1;
			end
        end
        else if (sim_start && write2) begin 
            writeAddr = write2AddrMemory[index2];
            writeCont = write2ContMemory[index2];
			if (index2 < 7) begin
            index2 = index2 + 1;
			end
        end
		else begin
		writeAddr = 32'd0;
		readAddr = 32'd0;
		writeCont = 32'd1;
		end	
    end

    always @(posedge clk) begin
        if (sim_start && rd_en) begin
            readAddr = readMemory[index3-1];
            index3 = index3 +1;
		end
        else begin
			readAddr = 32'd0;
		end
    end

    CACHE_MEM #(
        .SetNum(4),
        .SetEntries(8),
        .TagSize(5),
        .ContentSize(8),
        .AddrBits(8),
        .SetBits(1),
        .EntriesBits(3)
    )
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
