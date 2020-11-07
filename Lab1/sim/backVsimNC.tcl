source ../syn/definition.tcl

vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=./netlist/myfir.sdf -t ps work.tb_fir
set fp [open "./newPer.outGG" r]
set newPer [read $fp]
close $fp
set tb_fir/CG/ts { $newPer ns }
vcd file ../vcd/myfir_synNC.vcd
vcd add /tb_fir/UUT/*
add wave *
run 8 us
#quit -f
