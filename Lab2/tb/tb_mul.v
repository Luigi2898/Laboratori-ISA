/***********************************************************************
 * Test bench for the floating point multiplier.
 **********************************************************************/


module tb_mul ();

   wire CLK_i;
   wire RST_n_i;
   wire [31:0] DIN_i;
   wire [31:0] DOUT_i;

   integer error_count = 0;
   wire resC[31:0];
   wire res[31:0];
   integer endL = 0;
   
   clk_gen CG(.CLK(CLK_i),
	            .RST_n(RST_n_i));

   data_maker DG(.CLK(CLK_i),
	               .DATA(DIN_i)
                );

   FPmul UUT(.FP_A(DIN_i),
             .FP_B(DIN_i),
             .clk(CLK_i),
             .FP_Z(DOUT_i)
             );

   data_sink DS(.CLK(CLK_i),
		            .DATA(DOUT_i));


endmodule
