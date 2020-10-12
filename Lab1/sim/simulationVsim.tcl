vsim -t 10ps -novopt work.tb_fir
vsim add wave myfir/clk, myfir/din, myfir/vin, myfir/dout, myfir/vout

run 10 ns
