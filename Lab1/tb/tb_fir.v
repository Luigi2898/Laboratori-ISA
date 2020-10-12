/***********************************************************************
 * Test bench for the 8-order FIR  11 bit coefficients.
 **********************************************************************/
		


module tb_fir ();



   wire CLK_i;
   wire RST_n_i;
   wire [10:0] DIN_i;
   wire VIN_i;
   wire [10:0] H0_i;
   wire [10:0] H1_i;
   wire [10:0] H2_i;
   wire [10:0] H3_i;
   wire [10:0] H4_i;
   wire [10:0] H5_i;
   wire [10:0] H6_i;
   wire [10:0] H7_i;
   wire [10:0] H8_i;
   wire [10:0] DOUT_i;
   wire VOUT_i;
   wire END_SIM_i;
   
   integer error_count = 0;
   integer resC, res;
   integer outfile0,outfile1; //file descriptors
   
   //timeunit 1us;  timeprecision 1us;	

   clk_gen CG(.END_SIM(END_SIM_i),
  	          .CLK(CLK_i),
	          .RST_n(RST_n_i));

   data_gen DG(.CLK(CLK_i),
	           .RST_n(RST_n_i),
		       .VOUT(VIN_i),
		       .DOUT(DIN_i),
		       .END_SIM(END_SIM_i));

   myfir UUT(.CLK(CLK_i),
	         .RST_n(RST_n_i),
	         .DIN(DIN_i),
             .VIN(VIN_i),
			 .H0(H0_i),
	         .H1(H1_i),
			 .H2(H2_i),
			 .H3(H3_i),
			 .H4(H4_i),
			 .H5(H5_i),
			 .H6(H6_i),
			 .H7(H7_i),
			 .H8(H8_i),
             .DOUT(DOUT_i),
             .VOUT(VOUT_i));

   data_sink DS(.CLK(CLK_i),
		        .RST_n(RST_n_i),
		        .VIN(VOUT_i),
		        .DIN(DOUT_i));   

initial 
	begin
	outfile0=$fopen("../C/resultC.txt","r");
	@(posedge CLK_i)	
		if(VOUT_i == 1) begin
			if(! $feof(outfile0)) begin
			res = DOUT_i;
			$fscanf(outfile0,"%d\n",resC);
			check_results(); end
	        else begin
			$display("\nFILTER TESTS COMPLETED WITH %0d ERRORS!\n", error_count);
			$fclose(outfile0);
			$stop();
			$finish();
			end
		end	
end


task check_results;

    integer expected;    // local variable
    integer result;      // local variable
  begin     
    result = res;      // concatenation
    expected = resC;
     
    $write("At %t:  resC=%d  res=%d", $realtime, resC, res);
    if (result === expected) begin
      $display(" - OK"); end
    else begin
      $display(" - ERROR: expected %d", expected, expected);
      error_count = error_count + 1 ;
    end
end	
endtask		
		

endmodule




		   