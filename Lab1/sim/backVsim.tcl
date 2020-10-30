vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../syn/netlist/myfir.sdf work.tb_fir
vcd file ../vcd/fir/myfir_syn.vcd
vcd add /tb_fir/UUT/*
run 2 us
quit -f
