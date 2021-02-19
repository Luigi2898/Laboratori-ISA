mkdir syn
mkdir sim
cd syn

source /software/scripts/init_synopsys_64.18

dc_shell-xg-t -f ../synBeforeBack_v2.tcl

cd ..
cd sim
mkdir vcd

source /software/scripts/init_msim6.5c
vlib work

vlog -work ./work ../syn/reports/RISC_V_v2/netlist/RISC_V_v2.v
vlog -work ./work ../../tb/TB_RISCV_back_min_src_v2.v
vlog -work ./work ../../tb/MAIN_MEM.v
vcom -work ./work ../../src/components/testbenchComponents/clk_gen.vhd
vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp ../syn/reports/RISC_V_v2/netlist/RISC_V_v2.sdf work.TB_RISCV_back -t 1ps -sdfnoerror -sdfnowarn; vcd file ./vcd/RISCV_v2_min_src.vcd; vcd add /TB_RISCV_back/DUT/*; run 300 us; quit -f;"

cd ..
cd syn
source /software/scripts/init_synopsys_64.18
mkdir saif

vcd2saif -input ../sim/vcd/RISCV_v2_min_src.vcd -output ./saif/RISCV_v2_min_src.saif

dc_shell-xg-t -f ../backward_v2.tcl 
