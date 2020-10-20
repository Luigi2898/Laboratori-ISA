set power_preserve_rtl_hier_names true
analyze -f vhdl -lib WORK -autoread {../src}
elaborate myfir -arch beh -lib WORK > ./logs/elaboration.log
uniquify
link
create_clock -name MY_CLK -period 10.0 CLK
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile -exact_map > ./logs/compilation.log
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

exit
