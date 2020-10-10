read verilog -netlist ../netlist/myfir.v
read saif -input ../saif/myfir_syn.saif -instance tb_fir/UUT -unit ns -scale 1
create_clock -name MY_CLK CLK
report_power > synthReportAfterBack/power.txt
report_power -net> synthReportAfterBack/power-net.txt
report_power -cell> synthReportAfterBack/power-cell.txt
report_power -hierarchy> synthReportAfterBack/power-hierarchy.txt
report_power -verbose> synthReportAfterBack/power-verbose.txt