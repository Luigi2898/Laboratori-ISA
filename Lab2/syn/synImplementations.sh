#cleaning work directory
rm -r ./WORK
mkdir WORK
#init synopsys
source /software/scripts/init_synopsys_64.18
# performing basic version synthesis
design_vision -f ./synBasicMPY.tcl
#cleaning the work directory
rm -r ./WORK
mkdir WORK
source /software/scripts/init_synopsys_64.18
# performing CSA version synthesis
design_vision -f ./synCsaMPY.tcl
#cleaning the work directory
rm -r ./WORK
mkdir WORK
source /software/scripts/init_synopsys_64.18
# performing parallel prefix version synthesis
design_vision -f ./synPpMPY.tcl

