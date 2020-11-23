if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi

source /software/scripts/init_msim6.2g
vlib work

vcom -93 -work ./work ../src/MBE/ieee_proposed/array_std.vhd
vcom -93 -work  ./work ../src/MBE/*.vhd
vcom -93 -work ./work ../tb/mbe_ppg_tb.vhd
vsim -do MBEsimulationVsim.tcl
