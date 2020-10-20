onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_myfir_unfolded/clk
add wave -noupdate /tb_myfir_unfolded/rst_n
add wave -noupdate /tb_myfir_unfolded/vin
add wave -noupdate -radix decimal /tb_myfir_unfolded/din
add wave -noupdate -radix decimal /tb_myfir_unfolded/dut/datapath/input_buffer/buff_reg_gen(0)/buff_reg_gen1/buff_reg/reg_out
add wave -noupdate /tb_myfir_unfolded/dut/cu_inputs/load_buff
add wave -noupdate -radix unsigned /tb_myfir_unfolded/dut/datapath/input_buffer/cnt/cnt
add wave -noupdate -radix decimal /tb_myfir_unfolded/dut/datapath/input_buffer/buff_reg_gen(1)/buff_reg_gen2/buff_reg/reg_out
add wave -noupdate -color Gold -radix decimal /tb_myfir_unfolded/dut/datapath/input_buffer/buff_reg_gen(2)/buff_reg_gen2/buff_reg/reg_out
add wave -noupdate -color Gold -radix decimal /tb_myfir_unfolded/dut/datapath/input_buffer/buff_reg_gen(3)/buff_reg_gen2/buff_reg/reg_out
add wave -noupdate -color Gold -radix decimal /tb_myfir_unfolded/dut/datapath/input_buffer/buff_reg_gen(4)/buff_reg_gen2/buff_reg/reg_out
add wave -noupdate /tb_myfir_unfolded/dut/cu_inputs/buff_full
add wave -noupdate /tb_myfir_unfolded/dut/cu_inputs/load_state
add wave -noupdate /tb_myfir_unfolded/dut/cu_inputs/load_res
add wave -noupdate -radix decimal /tb_myfir_unfolded/dut/datapath/result_reg_gen(0)/result_reg/reg_out
add wave -noupdate -radix decimal /tb_myfir_unfolded/dut/datapath/result_reg_gen(1)/result_reg/reg_out
add wave -noupdate -radix decimal /tb_myfir_unfolded/dut/datapath/result_reg_gen(2)/result_reg/reg_out
add wave -noupdate /tb_myfir_unfolded/dut/cu_inputs/start_out
add wave -noupdate /tb_myfir_unfolded/dut/cu_outputs/en_cnt_mux
add wave -noupdate -radix unsigned /tb_myfir_unfolded/dut/datapath/mux_cnt/cnt
add wave -noupdate /tb_myfir_unfolded/dut/cu_outputs/tc_cnt_mux
add wave -noupdate /tb_myfir_unfolded/dut/cu_inputs/flush_cnt
add wave -noupdate /tb_myfir_unfolded/dut/datapath/input_buffer/cnt/reset_0
add wave -noupdate /tb_myfir_unfolded/dut/cu_inputs/state
add wave -noupdate /tb_myfir_unfolded/dut/cu_outputs/load_out
add wave -noupdate -radix decimal /tb_myfir_unfolded/dut/datapath/output_buffer/reg_out
add wave -noupdate /tb_myfir_unfolded/dut/cu_outputs/state
add wave -noupdate /tb_myfir_unfolded/vout
add wave -noupdate -radix decimal /tb_myfir_unfolded/dout
add wave -noupdate -radix decimal /tb_myfir_unfolded/dut/datapath/out_mux/out_mux
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {113847 ps} 0}
configure wave -namecolwidth 347
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {208720 ps}
