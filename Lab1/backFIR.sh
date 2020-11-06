cd syn
if [ ! -d netlist ]    # ← see 'man test' for available unary and binary operators.
then
    echo "WARNING!! ./syn/netlist directory is not present in main directory, go to ./syn and execute syn.sh to perform synthesis"
else
    echo "./syn/netlist directory is present in synthesis directory! I'll test all the others directory!"
	cd netlist
	if [ ! -d noGating ]
	then
		echo "WARNING!! ./syn/netlist directory does not contains gating or noGating directories, go to ./syn and execute syn.sh to perform synthesis"
	else
		echo "./syn/netlist/gating and ./syn/netlist/noGating are present, I continue checking"
        cd noGating
        if [ ! -d fir ]
        then
            echo "There is no ./syn/netlist/noGating/fir directory!"
        else
            echo "./syn/netlist/noGating/fir found, will I find some useful files inside it?"
            cd fir
            if [ ! -f myfir.v ]
            then
                echo "WARNING!!! There is no verilog netlist of myfir, go to ./syn and execute syn.sh to perform synthesis"
            else
                echo "I found everything I need :)"
                cd ..
            fi
            cd ..
        fi
        cd ..
	fi
    cd ..
fi
cd sim
mkdir netlist
cp ../syn/netlist/noGating/fir/* ./netlist
echo "Starting simulation, it can take a while..."
if [ -d "work" ]
then
	rm -r work
	echo "sim/work directory is present, I'll remove it to perform a clean simulation"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/testbenchComponents/clk_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/myfir.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsim.tcl
rm -r netlist

mkdir netlist
cp ../syn/netlist/noGating/firNC/* ./netlist
if [ -d "work" ]; then
	rm -r work
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/testbenchComponents/clk_genNC.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/myfirNC.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsimNC.tcl
rm -r netlist
echo "Simulation ended"
echo "I will satisfy my OCD messing a bit with files :)"
cd ../vcd
mv myfir_syn.vcd ./noGated/fir
mv myfir_synNC.vcd ./noGated/firNC
cd ..
