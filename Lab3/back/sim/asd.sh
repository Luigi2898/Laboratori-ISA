mkdir vcd

source /software/scripts/init_msim6.2g
vlib work

vlog -work work ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.v
vlog -work work ../../tb/TB_RISCV_back.v
vlog -work work ../../tb/MAIN_MEM.v
vcom -work work ../../src/components/testbenchComponents/clk_gen.vhd
vcom -work work ../../src/components/control/BPU/DELAY_CHAIN_1.vhd
vsim -c -do "vsim -voptargs=+acc -c -L /software/dk/nangate45/verilog/msim6.2g -sdftyp ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.sdf +nowarn(vsim-3017) work.TB_RISCV_back -t 1ps; add wave *; vcd file ./vcd/RISCV_v1.vcd; vcd add /TB_RISCV_back/DUT/*; run 60 us; quit"
