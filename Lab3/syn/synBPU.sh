#cleaning work directory
rm -r ./WORK
mkdir WORK
#init synopsys
source /software/scripts/init_synopsys_64.18
# performing basic version synthesis
dc_shell-xg-t -f ./synCommBPU.tcl
