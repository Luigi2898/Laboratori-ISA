#cleaning work directory
rm -r ./WORK
mkdir WORK
#init synopsys
source /software/scripts/init_synopsys_64.18
# performing basic version synthesis
#design_vision -f ./analConstr.tcl
#design_vision -f ./analConstr_ultra.tcl
design_vision -f ./analConstrDADDA.tcl
#design_vision -f ./analConstrWALLACE.tcl

