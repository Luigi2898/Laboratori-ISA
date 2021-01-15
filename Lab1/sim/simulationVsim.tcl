vsim -t 10ps -novopt work.tb_fir
add wave  sim:/tb_fir/CLK_i
add wave sim:/tb_fir/DIN_i
add wave sim:/tb_fir/VIN_i
add wave sim:/tb_fir/DOUT_i
add wave sim:/tb_fir/VOUT_i

run 3 us