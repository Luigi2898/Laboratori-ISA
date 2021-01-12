vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=./netlist/myfir.sdf -t ps work.tb_fir
vcd file ../vcd/myfir_syn.vcd
vcd add /tb_fir/UUT/*
add wave *
run 8 us
quit -f
