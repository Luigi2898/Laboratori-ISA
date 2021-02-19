read_ddc ./reports/RISC_V_v2/ddc/RISC_V_v2.ddc
create_clock -name "clock" -period 10 {CLK}

read_saif -input ./saif/RISCV_v2_min_src.saif -instance TB_RISCV_back/DUT  -scale 1 -unit_base ns
report_power > ./reports/power_min_src_v2.txt
