vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../syn/netlist/myfirNC.sdf work.tb_fir
vcd file ../vcd/myfir_synNC.vcd
vcd add /tb_fir/UUT/*
run 2 us
quit -f
