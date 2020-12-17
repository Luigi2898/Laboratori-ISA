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
   integer outfile0,outfile1; //file descriptors
   
	
/*always begin  : infinite
	outfile0=$fopen("./fp_prod.hex","r");
  while(1) begin
	  @(posedge CLK_i)	//Guardare simulazione
	    if(!$feof(outfile0)) begin
		    $fscanf(outfile0,"%d\n",resC);
		    res <= DOUT_i;
		    check_results(); end          
	    else if ($feof(outfile0)) begin
        $display("\nMULT TESTS COMPLETED WITH %0d ERRORS!\n", error_count);
        $fclose(outfile0);
        disable infinite;
     	end
    end      
end*/
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


/*task check_results;

    integer expected;    // local variable
    integer result;      // local variable
  begin     
    result = res;      // concatenation
    expected = resC;
     
    $display("At %t:  resC=%d  res=%d", $realtime, resC, res);
    if (result === expected) begin
      $display(" - OK\n"); end
    else begin
      $display(" - ERROR: expected %d\n", expected);
      error_count = error_count + 1 ;
    end
end	
endtask				*/

endmodule   
