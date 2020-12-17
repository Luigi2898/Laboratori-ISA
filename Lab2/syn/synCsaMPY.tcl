define_design_lib WORK -path ./WORK
analyze -library WORK -format vhdl {/home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/common/unpackfp_unpackfp.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/common/packfp_packfp.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/common/fpround_fpround.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_stage2_struct.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_single_cycle.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_pipeline.vhd /home/isa25/Desktop/Laboratori-ISA/Lab2/src/fpuvhdl/common/fpnormalize_fpnormalize.vhd}
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
report_timing -nworst 10 > ./synthReport/report_timing_csa.txt
report_area > ./synthReport/report_area_csa.txt
report_resources -nworst 10 > ./synthReport/report_resources_csa.txt
quit