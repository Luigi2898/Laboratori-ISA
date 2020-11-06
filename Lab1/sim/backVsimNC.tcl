source ../syn/definition.tcl

set fp [open "newPer$normaltag.outGG" r]
set newPer [read $fp]
close $fp

change sim:tb_fir/CG/Ts {{$newPer ps}}
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../syn/netlist/myfir.sdf work.tb_fir
vcd file ../vcd/myfir_synNC.vcd
vcd add /tb_fir/UUT/*
run 2 us
quit -f
