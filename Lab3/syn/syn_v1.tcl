#*****************************************************************************
# This script is used to synthesize the RISC-V 
#*****************************************************************************
sh rm -r ./work
sh mkdir work
sh mkdir logs/RISC_V_v1
sh mkdir reports/RISC_V_v1
sh mkdir reports/RISC_V_v1/netlist

#to preserve rtl names in the netlist for power consumption estimation.
set power_preserve_rtl_hier_names true

#analyze all possible file contained in the work folder 
analyze -library WORK -format vhdl {../src/components/common/FF.vhd}
analyze -library WORK -format vhdl {../src/components/common/MUX_2to1.vhd}
analyze -library WORK -format vhdl {../src/components/common/MUX_2X1TO1X1.vhd}
analyze -library WORK -format vhdl {../src/components/common/MUX_4to1.vhd}
analyze -library WORK -format vhdl {../src/components/common/REG.vhd}
analyze -library WORK -format vhdl {../src/components/common/SIPO_SHIFT_REG.vhd}
analyze -library WORK -format vhdl {../src/components/control/ALU_CTRL.vhd}
analyze -library WORK -format vhdl {../src/components/control/CU.vhd}
analyze -library WORK -format vhdl {../src/components/control/HDU.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/AGE_CNT.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/BHT.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/BPU_CU.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/CACHE_MEM.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/DELAY_CHAIN.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/DELAY_CHAIN1.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/PHT.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/SAT_CNT.vhd}
analyze -library WORK -format vhdl {../src/components/control/BPU/BPU_32bit/BPU.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/ALU.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/BRANCH_COMP.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/IMM_GEN.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/INCREMENTER.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/JMP_ADD.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/PIPE_EX_MEM.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/PIPE_ID_EX.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/PIPE_IF_ID.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/PIPE_MEM_WB.vhd}
analyze -library WORK -format vhdl {../src/components/datapath/REG_FILE.vhd}
analyze -library WORK -format vhdl {../src/RISC_V.vhd}

#elaborate top entity, set the variables
elaborate RISC_V -architecture rtl -library WORK > ./logs/RISC_V_v1/elaborate_v1.txt

#**************** CONSTRAINT THE SYNTHESIS ****************#
# setting design constrains
create_clock -name MY_CLK -period 10 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

# compiling the RISC_V_v1
compile -exact_map > ./logs/RISC_V_v1/compile_v1.txt
report_timing -nworst 10 > ./reports/RISC_V_v1/timing_v1.txt
report_area > ./reports/RISC_V_v1/area_v1.txt
report_power > ./reports/RISC_V_v1/power_v1.txt

ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ./reports/RISC_V_v1/netlist/RISC_V_v1.sdf
write -f verilog -hierarchy -output ./reports/RISC_V_v1/netlist/RISC_V_v1.v
write_sdc ./reports/RISC_V_v1/netlist/RISC_V_v1.sdc
write -hierarchy -format ddc -output ./reports/RISC_V_v1/netlist/RISC_V_v1.ddc
quit



