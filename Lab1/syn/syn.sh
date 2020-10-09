cd ../src
files = [ -f *.vhd ]
cd ../syn
source /software/scripts/init_synopsys_64.18
echo files
#design_vision -f synth.tcl