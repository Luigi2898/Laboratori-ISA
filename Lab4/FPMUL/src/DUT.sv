module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, output enum logic [1:0] {INITIAL,WAIT,SEND} state);
    
    integer latency = 5;
    integer delay_cycles = 0;
    integer i;
    integer inputA_FIFO [4:0];
    integer inputB_FIFO [4:0];
    integer cnt = 0;	

    FPmul UUT(.FP_A(in_inter.A), .FP_B(in_inter.B), .clk(in_inter.clk), .FP_Z(out_inter.data));

    always_ff @(posedge in_inter.clk)
    begin
        if(in_inter.rst) begin
            in_inter.ready <= 0;
            out_inter.data <= 'x;
            out_inter.valid <= 0;
            state <= INITIAL;
        end
        else case(state)
                INITIAL: begin
                    in_inter.ready <= 1;
                    state <= WAIT;
                end
                
                WAIT: begin
                      if(in_inter.valid) begin
                        in_inter.ready <= 0;
                        for (i = 0; i < latency - 1; i = i + 1) begin
                            inputA_FIFO[i+1] = inputA_FIFO[i];
                            inputB_FIFO[i+1] = inputB_FIFO[i];
                        end
                        inputA_FIFO[0] = in_inter.A;
                        inputB_FIFO[0] = in_inter.B;
		
                        
                        						
			if(cnt == latency-2) begin
			   cnt = 0;
			   $display("mult: input A = %f, input B = %f, output OUT = %f",$bitstoshortreal(inputA_FIFO[4]),    		$bitstoshortreal(inputB_FIFO[4]),$bitstoshortreal(out_inter.data));
			   $display("mult: input A = %b, input B = %b, output OUT = %b",inputA_FIFO[4],inputB_FIFO[4],out_inter.data);
                           
			   out_inter.valid <= 1;
                           state <= SEND;
			end
                       	cnt = cnt + 1;
			

                    end
                end
                
                SEND: begin
                    if(out_inter.ready) begin
                        out_inter.valid <= 0;
                        in_inter.ready <= 1;
                        state <= WAIT;
                    end
                end
        endcase
    end
endmodule: DUT
