sh rm -r ./WORK
sh mkdir WORK
sh mkdir reports/pp
sh mkdir reports/pp/netlist
analyze -library WORK -format vhdl -autoread {../src/fpuvhdl/common/}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage2_struct.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_single_cycle.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_pipeline.vhd}
elaborate FPMUL -architecture PIPELINE -library WORK -update
# setting design constrains
create_clock -name MY_CLK -period 10.0 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
ungroup -all -flatten
# setting the mpy implementation
set_implementation DW02_mult/pparch [find cell *mult*]
compile -exact_map
report_timing -nworst 10 > ./reports/pp/report_timing.txt
report_area > ./reports/pp/report_area.txt
report_resources > ./reports/pp/report_resources.txt
report_synlib dw_foundation.sldb > ./reports/pp/report_synthetic_library.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ./reports/pp/netlist/FPMUL.sdf
write -f verilog -hierarchy -output ./reports/pp/netlist/FPMUL.v
write_sdc ./reports/pp/netlist/FPMUL.sdc
write -hierarchy -format ddc -output ./reports/pp/netlist/FPMUL.ddc
quit
