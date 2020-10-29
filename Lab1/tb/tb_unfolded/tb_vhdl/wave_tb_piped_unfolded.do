onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/clk
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_outputs/rst_n
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/vin
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/din
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/din8
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/state
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/input_buffer1/reg_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/load_buff
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/input_buffer2/reg_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/en_cnt_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/cnt_in/cnt_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/tc_cnt_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/tc_ack_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/state_load
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/load_state0
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/load_state1
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/load_state2
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/state_vect0_gen(0)/state_0_in/state_0/reg_out
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/state_vect1_gen(0)/state_1_in/state_1/reg_out
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/state_vect2_gen(0)/state_2_in/state_2/reg_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/start_pipe
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state0_pipe1_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state1_pipe1_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state2_pipe1_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state0_pipe1_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state1_pipe1_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state2_pipe1_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state0_pipe2_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state1_pipe2_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state2_pipe2_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state0_pipe2_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state1_pipe2_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state2_pipe2_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state0_pipe3_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state1_pipe3_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state2_pipe3_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state0_pipe3_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state1_pipe3_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state2_pipe3_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state0_pipe4_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state1_pipe4_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state2_pipe4_in
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state0_pipe4_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state1_pipe4_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/state2_pipe4_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_inputs/load_first_res
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_pipe/load_res2
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_pipe/load_res3
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_pipe/load_res4
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_pipe/load_res5
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_pipe/start_out
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/result_reg_gen(0)/result_reg/reg_out
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/result_reg_gen(1)/result_reg/reg_out
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/result_reg_gen(2)/result_reg/reg_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/out_cnt_mux
add wave -noupdate -radix decimal /tb_myfir_piped_unfolded/dut/datapath/dout
add wave -noupdate /tb_myfir_piped_unfolded/dut/datapath/cnt_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_outputs/tc_cnt_mux
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_outputs/en_cnt_mux
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_outputs/load_out
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_outputs/vout
add wave -noupdate /tb_myfir_piped_unfolded/dut/cu_outputs/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {97384 ps} 0}
configure wave -namecolwidth 307
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {360620 ps}
