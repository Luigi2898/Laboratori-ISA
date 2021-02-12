cd syn

source /software/scripts/init_synopsys_64.18

dc_shell-xg-t -f ../synBeforeBack_v1.tcl

cd ../sim

source /software/scripts/init_msim6.2g
vlib work

vlog /work ./work ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.v
vlog -work ./work ../tb/TB_RISCV.v
vlog -work ./work ../tb/MAIN_MEM.v
vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.2g work.TB_RISCV; vcd file ./vcd/RISCV.vcd; vcd add /TB_RISCV/DUT/*; add wave *; run 10 us"
