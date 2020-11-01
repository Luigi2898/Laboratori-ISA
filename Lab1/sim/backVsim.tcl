vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../syn/netlist/fir/myfir.sdf work.tb_fir
vcd file ../vcd/fir/myfir.vcd
vcd add /tb_fir/UUT/*
run 2 us
quit -f
