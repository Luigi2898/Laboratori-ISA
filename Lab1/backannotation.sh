cd syn
if [ ! -d netlist ]    # ← see 'man test' for available unary and binary operators.
then
    echo "WARNING!! ./syn/netlist directory is not present in main directory, go to ./syn and execute syn.sh to perform synthesis"
else
    echo "./syn/netlist directory is present in synthesis directory! I'll test all the others directory!"
	cd netlist
	if [ ! -d gating || ! -d noGating ]
	then
		echo "WARNING!! ./syn/netlist directory does not contains gating or noGating directories, go to ./syn and execute syn.sh to perform synthesis"
	elif [ -d gating && -d noGating ]
	then
		echo "./syn/netlist/gating and ./syn/netlist/noGating are present, they shuold contain everything I need, otherwise it can be a problem :)"
	fi
	cd ..
fi
cd ../sim
echo "Starting simulation, it can take a while..."
if [ -d "work" ]; then
	rm -r work
	echo "sim/work directory is present, I'll remove it to perform a clean simulation"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/testbenchComponents/clk_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/noGated/fir/myfir.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsim.tcl

if [ -d "work" ]; then
	rm -r work
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/testbenchComponents/clk_genNC.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/noGated/firNC/myfirNC.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsimNC.tcl

if [ -d "work" ]; then
	rm -r work
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/testbenchComponents/clk_genNC.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/noGated/firNC/myfirNC.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsimNC.tcl











cd ../syn
source /software/scripts/init_synopsys_64.18
vcd2saif -input ../vcd/fir/myfir_syn.vcd -output ../saif/fir/myfir_syn.saif
dc_shell-xg-t -f backSyn.tcl
vcd2saif -input ../vcd/firNC/myfir_syn.vcd -output ../saif/firNC/myfir_syn.saif
dc_shell-xg-t -f backSynNC.tcl

dir="../OldRes/res_$(date +%F)"_"$(date +%H)"-"$(date +%M)"-"$(date +%S)_synAndBack"
mkdir $dir
mv synthReport $dir 
mv netlist $dir
mv logs $dir
mv synthReportAfterBack $dir
