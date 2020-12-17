vsim -t 10ps -novopt work.mbe_ppg_tb
add wave  sim:/mbe_ppg_tb/uut/*

run 30 ns



