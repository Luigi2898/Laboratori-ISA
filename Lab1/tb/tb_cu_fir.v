/***********************************************************************
 * Test bench for the 8-order FIR  11 bit coefficients CU.
 **********************************************************************/
`timescale 1 us/ 1 ns
		 
module tb_cu_fir ();
   reg CLK_i;
   reg RST_n_i;
   wire RST_n_fir_i;
   reg load_i;
   reg VIN_i;
   wire VOUT_i;
   reg TC_i;
   wire CNT_EN_i;
   
initial begin
             CLK_i = 1'b0;
             forever  CLK_i = #0.5 ~CLK_i;
          end

initial begin
             RST_n_i = 1'b0;
             forever #2  RST_n_i = 1'b1;
          end

myfir_cu CU(.CLK(CLK_i), 
            .RST_N(RST_n_i), 
			.RST_N_FIR(RST_n_fir_i), 
			.VIN(VIN_i), 
			.LOAD(LOAD_i), 
			.VOUT(VOUT_i),
			.TC(TC_i),
			.CNT_EN(CNT_EN_i));

initial 
begin 
	#2.5 VIN_i = 1'b1;
	#7 VIN_i = 1'b0;
	#8 VIN_i = 1'b1;	
	#10 TC_i = 1'b1;
	#10.5 TC_i = 1'b0;
	#12 VIN_i = 1'b0;
    #18 VIN_i = 1'b1;
	#20 $stop;
end


endmodule	
