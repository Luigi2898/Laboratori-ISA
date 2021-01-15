/***********************************************************************
 * Test bench for the 8-order FIR  11 bit coefficients CU.
 **********************************************************************/
`timescale 10 ns/ 1 ns
		 
module tb_cu_fir ();
   reg CLK_i;
   reg RST_n_i;
   reg load_i;
   reg VIN_i;
   wire VOUT_i;

   
initial begin
             CLK_i = 1'b0;
             forever  CLK_i = #5 ~CLK_i;
          end

initial begin
             RST_n_i = 1'b0;
             forever #20  RST_n_i = 1'b1;
          end

myfir_cu CU(.CLK(CLK_i), 
            .RST_N(RST_n_i),  
			.VIN(VIN_i), 
			.LOAD(LOAD_i), 
			.VOUT(VOUT_i));

initial 
begin 
	#25 VIN_i = 1'b1;
	#27 VIN_i = 1'b0;
	#28 VIN_i = 1'b1;	
	#32 VIN_i = 1'b0;
    #38 VIN_i = 1'b1;
	#40 $stop;
end


endmodule	
