# Init synopsys

mkdir reports
mkdir logs

source /software/scripts/init_synopsys_64.18

# Performing basic version synthesis

dc_shell-xg-t -f ./synBasicMPY.tcl
dc_shell-xg-t -f ./synPpMPY.tcl
dc_shell-xg-t -f ./synCsaMPY.tcl
#dc_shell-xg-t -f ./beh.tcl
#dc_shell-xg-t -f ./beh_ultra.tcl
#dc_shell-xg-t -f ./DADDA.tcl
#dc_shell-xg-t -f ./DADDA_ultra.tcl
#dc_shell-xg-t -f ./WALLACE.tcl
#dc_shell-xg-t -f ./WALLACE_ultra.tcl
