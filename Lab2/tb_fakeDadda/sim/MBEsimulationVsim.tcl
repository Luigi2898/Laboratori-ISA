vsim -t 10ps -novopt work.tb_mul_mbe
add wave  sim:/tb_mul_mbe/uut1/*
add wave  sim:/tb_mul_mbe/uut1/DADDA_TREE/tmp*
add wave  sim:/tb_mul_mbe/CG/*
add wave  sim:/tb_mul_mbe/DM/*

run 200 ns



