# Init synopsys

mkdir reports
mkdir logs

source /software/scripts/init_synopsys_64.18

dc_shell-xg-t -f ./syn_v1.tcl
#dc_shell-xg-t -f ./syn_v2.tcl