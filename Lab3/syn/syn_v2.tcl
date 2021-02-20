#*****************************************************************************
# This script is used to synthesize the RISC-V 
#*****************************************************************************
#sh rm -r ./WORK
sh mkdir WORK
sh mkdir logs/RISC_V_v2
sh mkdir reports/RISC_V_v2
sh mkdir reports/RISC_V_v2/netlist

#to preserve rtl names in the netlist for power consumption estimation.
set power_preserve_rtl_hier_names true

#analyze all possible file contained in the work folder 
analyze -library WORK -format vhdl {../src/components/common/FF.vhd}
analyze -library WORK -format vhdl {../src/components/common/MUX_2to1.vhd}
analyze -library WORK -format vhdl {../src/components/common/MUX_2X1TO1X1.vhd}
analyze -library WORK -format vhdl {../src/components/common/MUX_4to1.vhd}
analyze -library WORK -format vhdl {../src/components/common/REG.vhd}
analyze -library WORK -format vhdl {../src/components/common/SIPO_SHIFT_REG.vhd}
analyze -library WORK -format vhdl {../src/components/control/ALU_CTRL_v2.vhd}
analyze -library WORK -format vhdl {../src/components/control/CU.vhd}
analyze -library WORK -format vhdl {../src/components/control/HDU.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/AGE_CNT.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/BHT.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/BPU_CU.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/CACHE_MEM.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/DELAY_CHAIN.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/DELAY_CHAIN_1.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/PHT.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/SAT_CNT.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/BPU_32bit/BPU.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/ABS_VAL.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/ALU_v2.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/BRANCH_COMP.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/IMM_GEN.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/INCREMENTER.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/JMP_ADD.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/PIPE_EX_MEM.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/PIPE_ID_EX.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/PIPE_IF_ID.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/PIPE_MEM_WB.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/REG_FILE.vhd}
analyze -library WORK -format vhdl {../src/RISC_V_v2.vhd}


#elaborate top entity, set the variables
elaborate RISC_V_v2 -architecture rtl -library WORK > ./logs/RISC_V_v2/elaborate_v2.txt

#**************** CONSTRAINT THE SYNTHESIS ****************#
# setting design constrains
link
create_clock -name MY_CLK -period 3 CLK
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
# compiling the RISC_V_v2
compile -exact_map > ./logs/RISC_V_v2/compile_v2.txt
report_timing > ./reports/RISC_V_v2/timing_v2.txt
report_area > ./reports/RISC_V_v2/area_v2.txt
report_power > ./reports/RISC_V_v2/power_v2.txt

#ungroup -all -flatten
#change_names -hierarchy -rules verilog
#write_sdf ./reports/RISC_V_v2/netlist/RISC_V_v2.sdf
#write -f verilog -hierarchy -output ./reports/RISC_V_v2/netlist/RISC_V_v2.v
#write_sdc ./reports/RISC_V_v2/netlist/RISC_V_v2.sdc
#write -hierarchy -format ddc -output ./reports/RISC_V_v2/netlist/RISC_V_v2.ddc
#quit








