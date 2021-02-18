#mkdir vcd

source /software/scripts/init_msim6.5c
vlib work

vcom -93 -work ./work ../../../src/components/common/*.vhd
vcom -93 -work ./work ../../../src/components/control/*.vhd
vcom -93 -work ./work ../../../src/components/control/BPU/*.vhd
vcom -93 -work ./work ../../../src/components/control/BPU/BPU_32bit/*.vhd
vcom -93 -work ./work ../../../src/components/datapath/*.vhd
vcom -93 -work ./work ../../../src/components/testbenchComponents/*.vhd
vcom -93 -work ./work ../../../src/*.vhd
vlog -work ./work ../../../tb/MAIN_MEM.v
vlog -work ./work ../../../tb/TB_RISCV_back.v
vlog -work ./work ../RISC_V_v1.v

vsim -c -do "vsim -voptargs=+acc -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp /TB_RISCV_back/DUT=../RISC_V_v1.sdf work.TB_RISCV_back -t 1ps; add wave *; vcd file ./vcd/RISC_V_v1.vcd; vcd add /TB_RISCV_back/DUT/*; run 60 us"
#vsim -c -do "vsim -voptargs=+acc -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp /TB_RISCV_back/DUT=../RISC_V_v1.sdf work.TB_RISCV_back -t 1ps; add wave *; vcd file ./vcd/RISC_V_v1_matrix.vcd; vcd add /TB_RISCV_back/DUT/*; run 300 us"
#vsim -c -do "vsim -voptargs=+acc -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp /TB_RISCV_back/DUT=../RISC_V_v1.sdf work.TB_RISCV_back -t 1ps; add wave *; vcd file ./vcd/RISC_V_v1_min_src.vcd; vcd add /TB_RISCV_back/DUT/*; run 300 us"
#vsim -c -do "vsim -voptargs=+acc -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp /TB_RISCV_back/DUT=../RISC_V_v1.sdf work.TB_RISCV_back -t 1ps; add wave *; vcd file ./vcd/RISC_V_v1_neg_cnt.vcd; vcd add /TB_RISCV_back/DUT/*; run 300 us"

