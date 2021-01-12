rm -r work

source /software/scripts/init_msim6.2g
vlib work

vcom -93 -work ./work ../src/components/common/*.vhd
vcom -93 -work ./work ../src/components/control/*.vhd
vcom -93 -work ./work ../src/components/control/BPU/*.vhd
vcom -93 -work ./work ../src/components/control/BPU/BPU_32bit/*.vhd
vcom -93 -work ./work ../src/components/datapath/*.vhd
vcom -93 -work ./work ../src/components/testbenchComponents/*.vhd
vcom -93 -work ./work ../src/components/*.vhd
vlog -work ./work ../tb/TB_RISCV.v
vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.2g work.TB_RISCV; vcd file RISCV.vcd; vcd add /TB_RISCV/*; vcd add /TB_RISCV/DUT/*; add wave *; run 8 us; quit"
