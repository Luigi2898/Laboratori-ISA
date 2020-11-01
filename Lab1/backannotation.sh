cd syn
if [ -d work ]    # ← see 'man test' for available unary and binary operators.
then
    echo "Ho trovato la cartella work, per rendere deterministici i risultati procedo con la rimozione e la creazione della cartella"
    #rm *.log
    #rm *.svf
    rm -rf work
    mkdir work
else
    echo "La cartella work non è presente, la creo"
    mkdir work
fi
if [ ! -d synthReport ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella synthreport non è presente, la creo"
    mkdir synthReport
    cd synthReport
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
if [ ! -d netlist ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella netlist non è presente, la creo"
    mkdir netlist
    cd netlist
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
if [ ! -d synthReportAfterBack ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella synthReportAfterBack non è presente, la creo"
    mkdir synthReportAfterBack
    cd synthReportAfterBack
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
if [ ! -d logs ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella logs non è presente, la creo"
    mkdir logs
    cd logs
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
if [ ! -d savings ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella savings non è presente, la creo"
    mkdir savings
    cd savings
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
source /software/scripts/init_synopsys_64.18
dc_shell-xg-t -f synth.tcl


cd ../sim
if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/testbenchComponents/clk_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/fir/myfir.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsim.tcl


if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
python3 setPer.py ../src/simulationComponents/clk_gen.vhd "normal"
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/testbenchComponents/clk_genNC.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_gen.vhd
vcom -93 -work ./work ../src/testbenchComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/firNC/myfirNC.v
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
