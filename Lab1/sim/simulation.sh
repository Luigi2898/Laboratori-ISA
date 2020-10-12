if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -reportprogress 300 -work  ./work ../src/*.vhd
vlog -reportprogress 300 -work ./work ../tb/*.v
vsim -t 10ps -novopt work.tb_fir
#vsim -do simulationVsim.tcl
vsim add wave myfir/clk, myfir/din, myfir/vin, myfir/dout, myfir/vout

