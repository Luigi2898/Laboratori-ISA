vsim -t 10ps -novopt work.tb_mul
add wave  sim:/tb_mul/UUT/*
add wave sim:/tb_mul/DG/*
add wave sim:/tb_mul/CG/*
add wave sim:/tb_mul/DS/*

run 140 ns
