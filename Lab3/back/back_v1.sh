#mkdir syn
mkdir sim
#cd syn

#source /software/scripts/init_synopsys_64.18

#dc_shell-xg-t -f ../synBeforeBack_v1.tcl

#cd ..
cd sim
mkdir vcd

source /software/scripts/init_msim6.5c
vlib work

vlog -work ./work ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.v
vlog -work ./work ../../tb/TB_RISCV_back.v
vlog -work ./work ../../tb/MAIN_MEM.v
vcom -work ./work ../../src/components/testbenchComponents/clk_gen.vhd
vsim -do ../fill_forward.tcl

cd ../syn
source /software/scripts/init_synopsys_64.18
mkdir saif

vcd2saif -input ../sim/vcd/RISCV_v1.vcd -output ./saif/RISCV_v1.saif
dc_shell-xg-t -f ../backward_v1.tcl 
