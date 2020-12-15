sh rm -r ./WORK
sh mkdir WORK

define_design_lib WORK -path ./WORK
analyze -library WORK -format vhdl -autoread {../src/MBEmpyDADDA/}
analyze -library WORK -format vhdl -autoread {../src/fpuvhdl/common/}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_pipeline.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_single_cycle.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage2_struct.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd}
analyze -library WORK -format vhdl {../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd}
elaborate FPMUL -architecture PIPELINE -library WORK -update
link
# setting design constrains
create_clock -name MY_CLK -period 10 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile
report_timing > ./MBE_DADDA_reports/per10_dadda.txt
optimize_registers
sh mkdir reports/DADDA
sh mkdir reports/DADDA/netlist
report_timing > ./reports/DADDA/maxper_optdadda.txt
create_clock -name MY_CLK -period 10 clk
report_timing  > ./reports/DADDA/opt_dadda_timing.txt
report_area > ./reports/DADDA/opt_dadda_area.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ./reports/DADDA/netlist/FPMUL.sdf
write -f verilog -hierarchy -output ./reports/DADDA/netlist/FPMUL.v
write_sdc ./reports/DADDA/netlist/FPMUL.sdc
write -hierarchy -format ddc -output ./reports/DADDA/netlist/FPMUL.ddc
quit
