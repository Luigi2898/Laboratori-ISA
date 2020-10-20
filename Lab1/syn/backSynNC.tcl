set fp [open "newPer.outGG" r]
set newPer [read $fp]
close $fp
read_verilog -netlist ./netlist/myfirNC.v
read_saif -input ../saif/myfir_synNC.saif -instance tb_fir/UUT -unit ns -scale 1
create_clock -name MY_CLK -period $newPer CLK
report_power > ./synthReportAfterBack/powerNC.txt
report_power -net > ./synthReportAfterBack/power-netNC.txt
report_power -cell > ./synthReportAfterBack/power-cellNC.txt
report_power -hierarchy > ./synthReportAfterBack/power-hierarchyNC.txt
report_power -verbose > ./synthReportAfterBack/power-verboseNC.txt
exit

