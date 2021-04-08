class packet_in extends uvm_sequence_item;
    rand bit [31:0] A;
    rand bit [31:0] B;
    rand bit [7:0] exp_A;
    rand bit [7:0] exp_B;
    rand bit sign_A;
    rand bit sign_B;
    rand bit [22:0] s_A;
    rand bit [22:0] s_B;

    constraint exp_range_A {exp_A > 100; exp_A < 253;}
    constraint exp_range_B {exp_B > 100; exp_B < 253;}
    constraint s_A_range {s_A < 2**21; s_A > 2**20;}
    constraint s_B_range {s_B < 2**22; s_B > 2**21;}

    constraint A_C {A == {sign_A, exp_A, s_A};}
    constraint B_C {B == {sign_B, exp_B, s_B};}

    `uvm_object_utils_begin(packet_in)
        `uvm_field_int(A, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(B, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

    function new(string name="packet_in");
        super.new(name);
        //this.A = this.sign_A + this.exp_A + this.s_A;
        //this.B = this.sign_B + this.exp_B + this.s_B;
    endfunction: new
endclass: packet_in
