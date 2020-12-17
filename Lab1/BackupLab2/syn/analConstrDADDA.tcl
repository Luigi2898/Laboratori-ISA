define_design_lib WORK -path ./WORK
analyze -library WORK -format vhdl {/home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/common/unpackfp_unpackfp.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/common/packfp_packfp.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/common/fpround_fpround.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/common/fpnormalize_fpnormalize.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/MBEmpy/mux3xNto1xN.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/MBEmpy/mbe_ppg.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/MBEmpy/MBE_mult_uns.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/MBEmpy/HAbank.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/MBEmpy/HA.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/MBEmpy/FA.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/MBEmpy/BEU.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/MBEmpy/CSA_Tree.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_stage2_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_single_cycle.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/multiplier/fpmul_pipeline.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpswap_fpswap.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpselcomplement_fpselcomplement.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fplzc_fplzc.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpinvert_fpinvert.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpalign_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_stage6_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_stage5_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_stage4_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_stage3_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_stage2_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_stage1_struct.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_single_cycle.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_pipeline.vhd /home/lp20.19/Desktop/ISA/Laboratori-ISA/Lab2/src/fpuvhdl/adder/fpadd_normalize_struct.vhd}
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
#report_timing > ./MBE_DADDA_reports/per10_dadda.txt
#optimize_registers
#report_timing > ./MBE_DADDA_reports/maxper_optdadda.txt
#create_clock -name MY_CLK -period 10 clk
#report_timing  > ./MBE_WALLACE_reports/opt_dadda_timing.txt
#report_area > ./MBE_WALLACE_reports/opt_dadda_area.txt  
#compile_ultra -retime
#report_timing > ./MBE_DADDA_reports/maxper_ultrambe.txt
#create_clock -name MY_CLK -period 10 clk
#report_timing  > ./MBE_DADDA_reports/ultra_mbe_timing.txt
#report_area > ./MBE_DADDA_reports/ultra_mbe_area.txt  


