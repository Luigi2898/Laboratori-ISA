if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi

source /software/scripts/init_msim6.2g
vlib work

vcom -93 -work ./work ../MBEmpy/ieee_proposed/array_std.vhd
vcom -93 -work  ./work ../MBEmpy/*.vhd
vcom -93 -work ./work ../tb_mul_mbe.vhd
vsim -do MBEsimulationVsim.tcl
