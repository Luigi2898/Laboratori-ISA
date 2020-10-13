if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_new.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vlog -work ./work ../netlist/myfir.v
vlog -work ./work ../tb/tb fir.v
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb fir/UUT=../syn/netlist/myfir.sdf work.tb fir
vsim do -f backVsim.tcl
cd ../syn
source /software/scripts/init_synopsys_64.18
vcd2saif -input ../vcd/myfir_syn.vcd -output ../saif/myfir_syn.saif
design_vision -f backSyn.tcl
dir="../OldRes/res_$(date +%F)"_"$(date +%T)_synAndBack"
mkdir $dir
mv -r synthReport $dir 
mv -r netlist $dir
mv -r synthReportAfterBack $dir