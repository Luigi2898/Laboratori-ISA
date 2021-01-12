# Init synopsys

mkdir reports
mkdir logs

source /software/scripts/init_synopsys_64.18

# Performing basic version synthesis

dc_shell-xg-t -f ./synBasicMPY10.tcl
dc_shell-xg-t -f ./synPpMPY10.tcl
dc_shell-xg-t -f ./synCsaMPY10.tcl
dc_shell-xg-t -f ./DADDA10.tcl
dc_shell-xg-t -f ./WALLACE10.tcl
cd sim_back
rm -r work
source /software/scripts/init_msim6.2g
vlib work
DIR=basic/netlist
vcom -93 -work ./work ../../src/testbenchComponents/clk_gen.vhd
vcom -93 -work ./work ../../src/testbenchComponents/data_maker_forback.vhd
vlog -work ./work ../reports/$DIR/FPMUL.v
vlog -work ./work ../../tb/tb_forback.v
vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_mul/UUT=../reports/$DIR/FPMUL.sdf -t ps work.tb_mul; vcd file ../reports/$DIR/FPMUL.vcd; vcd add /tb_mul/UUT/*; add wave *; run 8 us; quit"
cd ..
source /software/scripts/init_synopsys_64.18
vcd2saif -input reports/$DIR/FPMUL.vcd -output reports/$DIR/FPMUL.saif
mkdir reports/$DIR/back
dc_shell-xg-t -x "read_verilog -netlist reports/$DIR/FPMUL.v; current_design FPmul; read_saif -input reports/$DIR/FPMUL.saif -instance tb_mul/UUT -unit ns -scale 1; create_clock -name MY_CLK -period 10.0 clk; report_power > reports/$DIR/back/power.txt; exit"
cd sim_back
source /software/scripts/init_msim6.2g
rm -r work
vlib work
DIR=CSA/netlist
vcom -93 -work ./work ../../src/testbenchComponents/clk_gen.vhd
vcom -93 -work ./work ../../src/testbenchComponents/data_maker_forback.vhd
vlog -work ./work ../reports/$DIR/FPMUL.v
vlog -work ./work ../../tb/tb_forback.v
vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_mul/UUT=../reports/$DIR/FPMUL.sdf -t ps work.tb_mul; vcd file ../reports/$DIR/FPMUL.vcd; vcd add /tb_mul/UUT/*; add wave *; run 8 us; quit"
cd ..
source /software/scripts/init_synopsys_64.18
vcd2saif -input reports/$DIR/FPMUL.vcd -output reports/$DIR/FPMUL.saif
mkdir reports/$DIR/back
dc_shell-xg-t -x "read_verilog -netlist reports/$DIR/FPMUL.v; current_design FPmul; read_saif -input reports/$DIR/FPMUL.saif -instance tb_mul/UUT -unit ns -scale 1; create_clock -name MY_CLK -period 10.0 clk; report_power > reports/$DIR/back/power.txt; exit"
cd sim_back
source /software/scripts/init_msim6.2g
rm -r work
vlib work
DIR=PP/netlist
vcom -93 -work ./work ../../src/testbenchComponents/clk_gen.vhd
vcom -93 -work ./work ../../src/testbenchComponents/data_maker_forback.vhd
vlog -work ./work ../reports/$DIR/FPMUL.v
vlog -work ./work ../../tb/tb_forback.v
vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_mul/UUT=../reports/$DIR/FPMUL.sdf -t ps work.tb_mul; vcd file ../reports/$DIR/FPMUL.vcd; vcd add /tb_mul/UUT/*; add wave *; run 8 us; quit"
cd ..
source /software/scripts/init_synopsys_64.18
vcd2saif -input reports/$DIR/FPMUL.vcd -output reports/$DIR/FPMUL.saif
mkdir reports/$DIR/back
dc_shell-xg-t -x "read_verilog -netlist reports/$DIR/FPMUL.v; current_design FPmul; read_saif -input reports/$DIR/FPMUL.saif -instance tb_mul/UUT -unit ns -scale 1; create_clock -name MY_CLK -period 10.0 clk; report_power > reports/$DIR/back/power.txt; exit"
cd sim_back
source /software/scripts/init_msim6.2g
rm -r work
vlib work
DIR=DADDA/netlist
vcom -93 -work ./work ../../src/testbenchComponents/clk_gen.vhd
vcom -93 -work ./work ../../src/testbenchComponents/data_maker_forback.vhd
vlog -work ./work ../reports/$DIR/FPMUL.v
vlog -work ./work ../../tb/tb_forback.v
vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_mul/UUT=../reports/$DIR/FPMUL.sdf -t ps work.tb_mul; vcd file ../reports/$DIR/FPMUL.vcd; vcd add /tb_mul/UUT/*; add wave *; run 8 us; quit"
cd ..
source /software/scripts/init_synopsys_64.18
vcd2saif -input reports/$DIR/FPMUL.vcd -output reports/$DIR/FPMUL.saif
mkdir reports/$DIR/back
dc_shell-xg-t -x "read_verilog -netlist reports/$DIR/FPMUL.v; current_design FPmul; read_saif -input reports/$DIR/FPMUL.saif -instance tb_mul/UUT -unit ns -scale 1; create_clock -name MY_CLK -period 10.0 clk; report_power > reports/$DIR/back/power.txt; exit"
cd sim_back
source /software/scripts/init_msim6.2g
rm -r work
vlib work
DIR=WALLACE/netlist
vcom -93 -work ./work ../../src/testbenchComponents/clk_gen.vhd
vcom -93 -work ./work ../../src/testbenchComponents/data_maker_forback.vhd
vlog -work ./work ../reports/$DIR/FPMUL.v
vlog -work ./work ../../tb/tb_forback.v
vsim -c -do "vsim -c -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_mul/UUT=../reports/$DIR/FPMUL.sdf -t ps work.tb_mul; vcd file ../reports/$DIR/FPMUL.vcd; vcd add /tb_mul/UUT/*; add wave *; run 8 us; quit"
cd ..
source /software/scripts/init_synopsys_64.18
vcd2saif -input reports/$DIR/FPMUL.vcd -output reports/$DIR/FPMUL.saif
mkdir reports/$DIR/back
dc_shell-xg-t -x "read_verilog -netlist reports/$DIR/FPMUL.v; current_design FPmul; read_saif -input reports/$DIR/FPMUL.saif -instance tb_mul/UUT -unit ns -scale 1; create_clock -name MY_CLK -period 10.0 clk; report_power > reports/$DIR/back/power.txt; exit"
cd sim_back
source /software/scripts/init_msim6.2g
