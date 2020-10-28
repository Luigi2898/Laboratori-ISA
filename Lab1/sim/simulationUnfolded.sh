if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -reportprogress 300 -work  ./work ../src/firUnfolded/*.vhd
vcom -reportprogress 300 -work  ./work ../src/testbenchComponents/*.vhd
vcom -reportprogress 300 -work  ./work ../src/commonComponents/*.vhd
vlog -reportprogress 300 -work ./work ../tb/tb_fir_unfolded.v
vsim -do simulationVsim.tcl
