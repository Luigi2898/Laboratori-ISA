source ./definition.tcl

set fp [open "newPer$normaltag.outGG" r]
set newPer [read $fp]
close $fp
read_verilog -netlist ./netlist/firNC/myfir.v
read_saif -input ../saif/myfir_synNC.saif -instance tb_fir/UUT -unit ns -scale 1
create_clock -name MY_CLK -period $newPer CLK
report_power > ./synthReportAfterBack/firNC/power.txt
report_power -net > ./synthReportAfterBack/firNC/power-net.txt
report_power -cell > ./synthReportAfterBack/firNC/power-cell.txt
report_power -hierarchy > ./synthReportAfterBack/firNC/power-hierarchy.txt
report_power -verbose > ./synthReportAfterBack/firNC/power-verbose.txt
exit

