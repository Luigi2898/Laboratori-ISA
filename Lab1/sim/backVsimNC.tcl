source ./definition.tcl

set fp [open "newPer$normaltag.outGG" r]
set newPer [read $fp]
close $fp

change sim:tb_fir/CG/Ts {{$newPer ps}}
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../syn/netlist/firNC/myfir.sdf work.tb_fir
vcd file ../vcd/myfirNC/myfir_syn.vcd
vcd add /tb_fir/UUT/*
run 2 us
quit -f
