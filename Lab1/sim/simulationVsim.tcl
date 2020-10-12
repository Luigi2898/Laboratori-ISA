vsim -t 10ps -novopt work.tb_fir
add wave UUT/clk, UUT/din, UUT/vin, UUT/dout, UUT/vout

run 10 ns
