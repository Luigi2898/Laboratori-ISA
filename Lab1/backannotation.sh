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
    echo "La cartella work non è presente, la creo"
    mkdir synthReport
fi
if [ ! -d netlist ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella netlist non è presente, la creo"
    mkdir netlist
fi
if [ ! -d synthReportAfterBack ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella synthReportAfterBack non è presente, la creo"
    mkdir synthReportAfterBack
fi
if [ ! -d logs ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella logs non è presente, la creo"
    mkdir logs
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
vcom -93 -work ./work ../src/simulationComponents/clk_gen.vhd
vcom -93 -work ./work ../src/simulationComponents/data_gen.vhd
vcom -93 -work ./work ../src/simulationComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/myfir.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsim.tcl
if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/simulationComponents/clk_gen.vhd
vcom -93 -work ./work ../src/simulationComponents/data_gen.vhd
vcom -93 -work ./work ../src/simulationComponents/data_sink.vhd
vlog -work ./work ../syn/netlist/myfirNC.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsimNC.tcl
cd ../syn
source /software/scripts/init_synopsys_64.18
vcd2saif -input ../vcd/myfir_syn.vcd -output ../saif/myfir_syn.saif
dc_shell-xg-t -f backSyn.tcl
vcd2saif -input ../vcd/myfir_synNC.vcd -output ../saif/myfir_synNC.saif
dc_shell-xg-t -f backSynNC.tcl
dir="../OldRes/res_$(date +%F)"_"$(date +%H)"-"$(date +%M)"-"$(date +%S)_synAndBack"
mkdir $dir
mv synthReport $dir 
mv netlist $dir
mv logs $dir
mv synthReportAfterBack $dir
