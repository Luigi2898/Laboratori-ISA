onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_data_buffer/clk
add wave -noupdate /tb_data_buffer/buff_on
add wave -noupdate /tb_data_buffer/load
add wave -noupdate /tb_data_buffer/flush
add wave -noupdate /tb_data_buffer/rst_n
add wave -noupdate /tb_data_buffer/buff_full
add wave -noupdate -radix decimal /tb_data_buffer/data_ext
add wave -noupdate -radix decimal /tb_data_buffer/data_out0
add wave -noupdate -radix decimal /tb_data_buffer/data_out1
add wave -noupdate -radix decimal /tb_data_buffer/data_out2
add wave -noupdate -radix decimal /tb_data_buffer/dut/buff_reg_gen(0)/buff_reg_gen1/buff_reg/reg_out
add wave -noupdate -radix decimal /tb_data_buffer/dut/buff_reg_gen(1)/buff_reg_gen2/buff_reg/reg_out
add wave -noupdate /tb_data_buffer/dut/cnt/en
add wave -noupdate /tb_data_buffer/dut/cnt/rst
add wave -noupdate /tb_data_buffer/dut/cnt/cnt_end
add wave -noupdate /tb_data_buffer/dut/cnt/cnt_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {37541 ps} 0}
configure wave -namecolwidth 409
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
WaveRestoreZoom {0 ps} {414850 ps}
