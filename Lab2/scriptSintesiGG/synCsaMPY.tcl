sh rm -r ./WORK
sh mkdir WORK
sh mkdir reports/csa
sh mkdir reports/csa/netlist
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
set_implementation DW02_mult/csa [find cell *mult*]
compile -exact_map
report_resources
report_timing -nworst 10 > ./reports/csa/report_timing_csa.txt
report_area > ./reports/csa/report_area_csa.txt
report_resources -nworst 10 > ./reports/csa/report_resources_csa.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ./reports/csa/netlist/FPMUL.sdf
write -f verilog -hierarchy -output ./reports/csa/netlist/FPMUL.v
write_sdc ./reports/csa/netlist/FPMUL.sdc
write -hierarchy -format ddc -output ./reports/csa/netlist/FPMUL.ddc
quit
