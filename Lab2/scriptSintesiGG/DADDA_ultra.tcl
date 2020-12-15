sh rm -r ./WORK
sh mkdir WORK

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
compile_ultra -retime
report_timing > ./reports/DADDA/maxper_ultrambe.txt
create_clock -name MY_CLK -period 10 clk
report_timing  > ./reports/DADDA/ultra_mbe_timing.txt
report_area > ./reports/DADDA/ultra_mbe_area.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ./reports/DADDA/netlist/ultra_FPMUL.sdf
write -f verilog -hierarchy -output ./reports/DADDA/netlist/ultra_FPMUL.v
write_sdc ./reports/DADDA/netlist/ultra_FPMUL.sdc
write -hierarchy -format ddc -output ./reports/DADDA/netlist/ultra_FPMUL.ddc
quit
