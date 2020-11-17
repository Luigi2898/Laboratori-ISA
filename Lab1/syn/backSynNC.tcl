source ./definition.tcl

set fp [open "newPer.outGG" r]
set newPer [read $fp]
close $fp
read_verilog -netlist ./netlistToBack/myfir.v
current_design MYFIR
current_design MYFIR_UNFOLDED
current_design MYFIR_PIPED_UNFOLDED
read_saif -input ./netlistToBack/myfir_syn.saif -instance tb_fir/UUT -unit ns -scale 1
create_clock -name MY_CLK -period $newPer CLK
report_power > ./synthReportAfterBack/power.txt
report_power -net > ./synthReportAfterBack/power-net.txt
report_power -cell > ./synthReportAfterBack/power-cell.txt
report_power -hierarchy > ./synthReportAfterBack/power-hierarchy.txt
report_power -verbose > ./synthReportAfterBack/power-verbose.txt
exit

