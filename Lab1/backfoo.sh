backAnn () {

    #$1 gating or not
    #$2 type of fir
    #$3 type of fir NC
    #$4 tag clk_gen

    cd syn
    if [ ! -d netlist ]    # ← see 'man test' for available unary and binary operators.
    then
        echo "WARNING!! ./syn/netlist directory is not present in main directory, go to ./syn and execute syn.sh to perform synthesis"
    else
        echo "./syn/netlist directory is present in synthesis directory! I'll test all the others directory!"
	    cd netlist
	    if [ ! -d $1 ]
	    then
		    echo "WARNING!! ./syn/netlist directory does not contains $1 directory, go to ./syn and execute syn.sh to perform synthesis"
	    else
		    echo "./syn/netlist/$1 is present, I continue checking"
            cd $1
        if [ ! -d $2 ]
        then
            echo "There is no ./syn/netlist/$1/$2 directory!"
        else
            echo "./syn/netlist/$1/$2 found, will I find some useful files inside it?"
            cd $2
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
cp ../syn/netlist/$1/$2/* ./netlist
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
vlog -work ./work ./netlist/myfir.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsim.tcl
rm -r netlist

mkdir netlist
cp ../syn/netlist/$1/$3/* ./netlist
if [ -d "work" ]; then
	rm -r work
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/testbenchComponents/clk_gen$4.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_sink.vhd
vlog -work ./work ./netlist/myfir.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsimNC.tcl
rm -r netlist
echo "Simulation ended"
echo "I will satisfy my OCD messing a bit with files :)"
cd ../vcd
mv myfir_syn.vcd ./$1/$2
mv myfir_synNC.vcd ./$1/$2
cd ../syn
mkdir netlistToBack
cp ./netlist/$1/$2/* ./netlistToBack
source /software/scripts/init_synopsys_64.18
vcd2saif -input ../vcd/$1/$2/myfir_syn.vcd -output ../saif/$1/$2/myfir_syn.saif
cp ../saif/$1/$2/myfir_syn.saif ./netlistToBack
dc_shell-xg-t -f backSyn.tcl
mv ./synthReportAfterBack/*.txt ./synthReportAfterBack/$1/$2

cp ./netlist/$1/$2/* ./netlistToBack
vcd2saif -input ../vcd/$1/$2/myfir_synNC.vcd -output ../saif/$1/$2/myfir_syn.saif
cp ../saif/$1/$2/myfir_syn.saif ./netlistToBack
dc_shell-xg-t -f backSynNC.tcl
mv ./synthReportAfterBack/*.txt ./synthReportAfterBack/$1/$2

dir="../OldRes/res_$(date +%F)"_"$(date +%H)"-"$(date +%M)"-"$(date +%S)_synAndBack"
mkdir $dir
cp -r ./synthReport $dir 
cp -r ./netlist $dir
cp -r ./logs $dir
cp -r ./synthReportAfterBack $dir
cp -r ../vcd $dir
cp -r ../saif $dir
}