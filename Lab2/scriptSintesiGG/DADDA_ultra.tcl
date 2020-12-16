sh rm -r ./work
sh mkdir work
sh mkdir logs/DADDA_ultra
sh mkdir reports/DADDA_ultra
sh mkdir reports/DADDA_ultra/netlist

analyze -library work -format vhdl -autoread {../src/MBEmpyDADDA/}
analyze -library work -format vhdl -autoread {../src/fpuvhdl/common/}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_pipeline.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_single_cycle.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage2_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd}
elaborate FPMUL -architecture PIPELINE -library work > logs/DADDA_ultra/elaboration.txt
link
# setting design constrains
create_clock -name MY_CLK -period 0 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile_ultra -retime > logs/DADDA_ultra/compilation.txt
report_timing > ./reports/DADDA_ultra/timing.txt
create_clock -name MY_CLK -period 10 clk
report_timing  > ./reports/DADDA_ultra/timing_wclock.txt
report_area > ./reports/DADDA_ultra/area.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ./reports/DADDA_ultra/netlist/FPMUL.sdf
write -f verilog -hierarchy -output ./reports/DADDA_ultra/netlist/FPMUL.v
write_sdc ./reports/DADDA_ultra/netlist/FPMUL.sdc
write -hierarchy -format ddc -output ./reports/DADDA_ultra/netlist/FPMUL.ddc
quit
