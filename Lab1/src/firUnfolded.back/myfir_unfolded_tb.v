// read_file_ex.v
// note that, we need to create Modelsim project to run this file,
// or provide full path to the input-file i.e. adder_data.txt  

`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module myfir_unfolded_tb;
    
    reg [10:0] DIN;
    reg VIN;
    reg [10:0] DIN;
    reg VIN;
    reg [10:0] H0;
    reg [10:0] H1;
    reg [10:0] H2;
    reg [10:0] H3;
    reg [10:0] H4;
    reg [10:0] H5;
    reg [10:0] H6;
    reg [10:0] H7;
    reg [10:0] H8;
    reg[11:0] read_data [0:299]; //array of 300 rows of 12 bits numbers
    integer i;
    integer j = 0;


    myfir_unfolded : DUT 

    always 
    begin
        clk = 1'b1; 
        #5; // high for 5 * timescale
        clk = 1'b0;
        #5; // low for 5 * timescale
    end

    initial
    begin 
        // readmemb = read the binary values from the file
        // other option is 'readmemh' for reading hex values
        // create Modelsim project to use relative path with respect to project directory
        $readmemb("input_output_files/input_samples.txt", read_data_in);
        

        // or provide the compelete path as below
        // $readmemb("D:/Testbences/input_output_files/adder_data.txt", read_data);

        // total number of lines in adder_data.txt = 6
        for (i=0; i<300; i=i+1)
        begin
            // 0_1_0_1 and 0101 are read in the same way, i.e.
            //a=0, b=1, sum_expected=0, carry_expected=0 for above line;
            // but use of underscore makes the values more readable.
            {DIN,VIN} = read_data[i]; // use this or below            
            #10;  // wait
        end
    end

    initial
    begin
        rst_n = 1'b1;
        #10;
        rst_n = 0'b0;
        #10;
        rst = 1'b1;
    end

    always
    begin
        $readmemb("input_output_files/coeff_samples.txt", read_data_coeffs);
        H0 = read_data_coeffs[0];
        H1 = read_data_coeffs[1];
        H2 = read_data_coeffs[2];
        H3 = read_data_coeffs[3];
        H4 = read_data_coeffs[4];
        H5 = read_data_coeffs[5];
        H6 = read_data_coeffs[6];
        H7 = read_data_coeffs[7];
        H8 = read_data_coeffs[8];
    end

    always @(vout)
    begin
        if (posedge vout && vout = 1)
            $readmemb("input_output_files/output_samples.txt", read_data_out);
            if(DOUT != read_data_out[j])
                $display("DOUT = %0d, should be %0d. WRONG!",DOUT,read_data_out[j]);
            else
                $display("DOUT = %0d, should be %0d. CORRECT!",DOUT,read_data_out[j]);        
    end

    


endmodule