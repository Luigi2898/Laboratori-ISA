read_verilog -netlist ./netlist/myfir.v
read_saif -input ../saif/fir/myfir_syn.saif -instance tb_fir/UUT -unit ns -scale 1
create_clock -name MY_CLK -period 10.0 CLK
report_power > ./synthReportAfterBack/fir/power.txt
report_power -net > ./synthReportAfterBack/fir/power-net.txt
report_power -cell > ./synthReportAfterBack/fir/power-cell.txt
report_power -hierarchy > ./synthReportAfterBack/fir/power-hierarchy.txt
report_power -verbose > ./synthReportAfterBack/fir/power-verbose.txt
exit
