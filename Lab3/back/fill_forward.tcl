vsim -L /software/dk/nangate45/verilog/msim6.5c -sdftyp ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.sdf work.TB_RISCV_back -t 1ps
add wave *
vcd file ./vcd/RISCV_v1.vcd
vcd add /TB_RISCV_back/DUT/*
run 60 us

