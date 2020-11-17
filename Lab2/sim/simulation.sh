if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work  ./work ../src/fpuvhdl/common/*.vhd
vcom -93 -work  ./work ../src/fpuvhdl/multiplier/fpmul_stage*.vhd
vcom -93 -work  ./work ../src/fpuvhdl/multiplier/fpmul_pipeline.vhd
vcom -93 -work  ./work ../src/testbenchComponents/*.vhd
vlog -work ./work ../tb/tb_mul.v
vsim -do simulationVsim.tcl
