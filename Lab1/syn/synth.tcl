set power preserve rtl hier names true
analyze -f vhdl -lib WORK -autoread {../src}
elaborate myfir -arch beh -lib WORK
uniquify
link
create clock -name MY CLK -period 10.0 CLK
set_dont_touch network MY CLK
set_clock_uncertainty 0.07 [get clocks MY CLK]
set_input_delay 0.5 -max -clock MY CLK [remove from collection [all inputs] CLK]
set_output_delay 0.5 -max -clock MY CLK [all outputs]
set OLOAD [load of NangateOpenCellLibrary/BUF X4/A]
set_load $OLOAD [all outputs]
compile -exact_map
#compile -exact_map -gate_clock

#REPORTS

report_timing > synthReport/timing.txt
report_area  > synthReport/area.txt
report_power > synthReport/power.txt
report_power -net > synthReport/power-net.txt
report_power -cell > synthReport/power-cell.txt
report_power -hierarchy > synthReport/power-hierarchy.txt
report_power -verbose > synthReport/power-verbose.txt

#SDF

ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf netlist/myfir.sdf
write -f verilog -hierarchy -output netlist/myfir.v
write_sdc netlist/myfir.sdc
