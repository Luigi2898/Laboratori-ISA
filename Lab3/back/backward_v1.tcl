create_clock -name "clock" -period 10 {CLK}
read_saif -input ./saif/RISCV_v1.saif -instance TB_RISCV_back/DUT  -scale 1 -unit_base ns
report_power > ./reports/power.txt