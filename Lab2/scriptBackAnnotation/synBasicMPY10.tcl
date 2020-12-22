sh rm -r ./work
sh mkdir work
sh mkdir logs/basic
sh mkdir reports/basic
sh mkdir reports/basic/netlist

analyze -library work -format vhdl -autoread {../src/fpuvhdl/common/}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage2_struct_beh.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_single_cycle.vhd}
analyze -library work -format vhdl {../src/fpuvhdl/multiplier/fpmul_pipeline.vhd}
elaborate FPMUL -architecture PIPELINE -library work > logs/basic/elaboration.txt
link
# setting design constrains
create_clock -name MY_CLK -period 10 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
# compiling the standard version of the mpy
compile -exact_map > logs/basic/compilation.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ./reports/basic/netlist/FPMUL.sdf
write -f verilog -hierarchy -output ./reports/basic/netlist/FPMUL.v
write_sdc ./reports/basic/netlist/FPMUL.sdc
write -hierarchy -format ddc -output ./reports/basic/netlist/FPMUL.ddc
quit