#mkdir syn
#mkdir sim
#cd syn

#source /software/scripts/init_synopsys_64.18

#dc_shell-xg-t -f ../synBeforeBack_v1.tcl

#cd ..
#cd sim
#mkdir vcd

#source /software/scripts/init_msim6.5c
#vlib work

#vlog -work ./work ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.v
#vlog -work ./work ../../tb/TB_RISCV_back.v
#vlog -work ./work ../../tb/MAIN_MEM.v
#vcom -work ./work ../../src/components/testbenchComponents/clk_gen.vhd
#vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.sdf work.TB_RISCV_back -t 1ps -sdfnoerror -sdfnowarn; vcd file ./vcd/RISCV_v1_basic.vcd; vcd add /TB_RISCV_back/DUT/*; run 60 us; quit -f;"

#rm -r work
#vlib work

#vlog -work ./work ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.v
#vlog -work ./work ../../tb/TB_RISCV_back_matrix.v
#vlog -work ./work ../../tb/MAIN_MEM.v
#vcom -work ./work ../../src/components/testbenchComponents/clk_gen.vhd
#vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.sdf work.TB_RISCV_back -t 1ps -sdfnoerror -sdfnowarn; vcd file ./vcd/RISCV_v1_matrix.vcd; vcd add /TB_RISCV_back/DUT/*; run 300 us; quit -f;"

#rm -r work
#vlib work

#vlog -work ./work ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.v
#vlog -work ./work ../../tb/TB_RISCV_back_min_src.v
#vlog -work ./work ../../tb/MAIN_MEM.v
#vcom -work ./work ../../src/components/testbenchComponents/clk_gen.vhd
#vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.sdf work.TB_RISCV_back -t 1ps -sdfnoerror -sdfnowarn; vcd file ./vcd/RISCV_v1_min_src.vcd; vcd add /TB_RISCV_back/DUT/*; run 300 us; quit -f;"

#rm -r work
#vlib work

#vlog -work ./work ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.v
#vlog -work ./work ../../tb/TB_RISCV_back_neg_cnt.v
#vlog -work ./work ../../tb/MAIN_MEM.v
#vcom -work ./work ../../src/components/testbenchComponents/clk_gen.vhd
#vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.5c -sdftyp ../syn/reports/RISC_V_v1/netlist/RISC_V_v1.sdf work.TB_RISCV_back -t 1ps -sdfnoerror -sdfnowarn; vcd file ./vcd/RISCV_v1_neg_cnt.vcd; vcd add /TB_RISCV_back/DUT/*; run 300 us; quit -f;"

#cd ..
cd syn
source /software/scripts/init_synopsys_64.18
mkdir saif

vcd2saif -input ../sim/vcd/RISCV_v1_basic.vcd -output ./saif/RISCV_v1_basic.saif
vcd2saif -input ../sim/vcd/RISCV_v1_matrix.vcd -output ./saif/RISCV_v1_matrix.saif
vcd2saif -input ../sim/vcd/RISCV_v1_min_src.vcd -output ./saif/RISCV_v1_min_src.saif
vcd2saif -input ../sim/vcd/RISCV_v1_neg_cnt.vcd -output ./saif/RISCV_v1_neg_cnt.saif
dc_shell-xg-t -f ../backward_v1.tcl 
