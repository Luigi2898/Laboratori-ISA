if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
source /software/scripts/init_msim6.2g
vlib work
vcom -93 -work ./work ../src/clk_gen.vhd
vcom -93 -work ./work ../src/data_gen.vhd
vcom -93 -work ./work ../src/data_sink.vhd
vlog -work ./work ../syn/netlist/myfir.v
vlog -work ./work ../tb/tb_fir.v
vsim -do backVsim.tcl
cd ../syn
source /software/scripts/init_synopsys_64.18
vcd2saif -input ../vcd/myfir_syn.vcd -output ../saif/myfir_syn.saif
dc_shell-xg-t -f backSyn.tcl
dir="../OldRes/res_$(date +%F)"_"$(date +%T)_synAndBack"
mkdir $dir
mv synthReport $dir 
mv netlist $dir
mv logs $dir
mv synthReportAfterBack $dir
