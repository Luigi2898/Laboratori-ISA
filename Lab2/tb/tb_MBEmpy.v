/***********************************************************************
 * Testbench for the 32 bit MBE unsigned multiplier.
 **********************************************************************/


module tb_MBEmpy ();

// TODO : La back vogliamo farla a 10 ns o con il periodo diviso?
   wire CLK_i;
   wire RST_n_i;
   wire unsigned [31:0] IN_A;
   wire unsigned [31:0] IN_B;
   wire unsigned [63:0] OUT_MPY;
   wire END_SIM_i;
   
   integer error_count = 0;
   integer inputA,inputB = 0;
   integer resCorrect, res, a = 1;
   integer infileLineRead = 1;
   integer endL = 0;
   integer outfile0,outfile1; //file descriptors
   

// Input data generation
always begin : infinite2
  infile = $fopen("./stimulus_files/inputsMPY.txt");
  while (1) begin
    @ (posedge CLK_i)
      if (!$feof(infile)) begin
        infileLineRead = $fscanf(infile,"%d\n%d\n",inputA,inputB);
        IN_A = inputA;
        IN_B = inputB;
        cnt_in = cnt_i + 1;
      end
      if (cnt_in == 100) begin
        END_SIM_i = 1;
        disable infinite2;
      end
  end
end
  

// Acquire correct results from file  
always begin  : infinite
	outfile0=$fopen("../C/resultMPY.txt","r");
  while(1) begin
	  @(posedge CLK_i)
	    if(!$feof(outfile0)) begin
		    a = $fscanf(outfile0,"%d\n",resCorrect);
		    res = OUT_MPY;
		    check_results(); 
        end          
	    else if (END_SIM_i == 1 && $feof(outfile0)) begin
        $display("\nFILTER TESTS COMPLETED WITH %0d ERRORS!\n", error_count);
        $fclose(outfile0);
        disable infinite;
     	end
    end      
end

  //Clock generation
   clk_gen CG(.CLK(CLK_i),.RST_n(RST_n_i));

  //
   DUT MBE_mult_uns(.A(IN_A),.B(IN_B),.MPY_OUT(OUT_MPY));

   
//Result verification task
task check_results;

    integer expected;    // local variable
    integer result;      // local variable
  begin     
    result = res;      // concatenation
    expected = resCorrect;
     
    $display("At %t:  INPUT A=%d  INPUT B=%d\n        EXPECTED=%d  OBTAINED=%d",$realtime,inputA,inputB,resCorrect,res);
    if (result === expected) begin
      $display(" - OK\n"); end
    else begin
      $display(" - ERROR: expected %d\n", expected);
      error_count = error_count + 1 ;
    end
end	
endtask		
		

endmodule




		   
