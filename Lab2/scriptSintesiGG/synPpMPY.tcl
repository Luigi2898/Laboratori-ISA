sh rm -r ./work
sh mkdir work
sh mkdir logs/PP
sh mkdir reports/PP
sh mkdir reports/PP/netlist

analyze -library work -format vhdl -autoread {../src/fpuvhdl/common/}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage2_struct_beh.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_single_cycle.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_pipeline.vhd}
elaborate FPMUL -architecture PIPELINE -library work > logs/PP/elaboration.txt
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
compile -exact_map > logs/PP/compilation.txt
report_timing -nworst 10 > ./reports/PP/timing.txt
report_area > ./reports/PP/area.txt
report_resources > ./reports/PP/resources.txt
report_synlib dw_foundation.sldb > ./reports/synthetic_library.txt
change_names -hierarchy -rules verilog
write_sdf ./reports/PP/netlist/FPMUL.sdf
write -f verilog -hierarchy -output ./reports/PP/netlist/FPMUL.v
write_sdc ./reports/PP/netlist/FPMUL.sdc
write -hierarchy -format ddc -output ./reports/PP/netlist/FPMUL.ddc
quit
