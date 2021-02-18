read_ddc ./reports/RISC_V_v1/ddc/RISC_V_v1.ddc
create_clock -name "clock" -period 10 {CLK}
read_saif -input ./saif/RISCV_v1_basic.saif -instance TB_RISCV_back/DUT  -scale 1 -unit_base ns
report_power > ./reports/power_basic.txt

read_saif -input ./saif/RISCV_v1_min_src.saif -instance TB_RISCV_back/DUT  -scale 1 -unit_base ns
report_power > ./reports/power_min_src.txt

read_saif -input ./saif/RISCV_v1_matrix.saif -instance TB_RISCV_back/DUT  -scale 1 -unit_base ns
report_power > ./reports/power_matrix.txt

read_saif -input ./saif/RISCV_v1_neg_cnt.saif -instance TB_RISCV_back/DUT  -scale 1 -unit_base ns
report_power > ./reports/power_neg_cmt.txt
