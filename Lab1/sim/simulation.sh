if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -reportprogress 300 -work  ./work ../src/*.vhd
vlog -reportprogress 300 -work ./work ../tb/*.v
vsim -do simulationVsim.tcl
