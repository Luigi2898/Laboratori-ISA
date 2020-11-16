#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Nov 13 14:47:06 2020                
#                                                     
#######################################################

#@(#)CDS: Innovus v17.11-s080_1 (64bit) 08/04/2017 11:13 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 17.11-s080_1 NR170721-2155/17_11-UB (database version 2.30, 390.7.1) {superthreading v1.44}
#@(#)CDS: AAE 17.11-s034 (64bit) 08/04/2017 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 17.11-s053_1 () Aug  1 2017 23:31:41 ( )
#@(#)CDS: SYNTECH 17.11-s012_1 () Jul 21 2017 02:29:12 ( )
#@(#)CDS: CPE v17.11-s095
#@(#)CDS: IQRC/TQRC 16.1.1-s215 (64bit) Thu Jul  6 20:18:10 PDT 2017 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set init_design_netlisttype verilog
set init_design_settop 1
set init_top_cell MYFIR_PIPED_UNFOLDED
set init_verilog ../LastChanceOfSynthesysAndBackannotation/netlist/gating/firUnfoldedPipedNC/myfir.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD
set init_design_netlisttype verilog
set init_design_settop 1
set init_top_cell MYFIR_PIPED_UNFOLDED
set init_verilog ../LastChanceOfSynthesysAndBackannotation/netlist/gating/firUnfoldedPipedNC/myfir.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site FreePDK45_38x28_10R_NP_162NW_34O -r 1 0.6 5 5 5 5
uiSetTool select
getIoFlowFlag
fit
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top metal1 bottom metal1 left metal2 right metal2} -width {top 0.8 bottom 0.8 left 0.8 right 0.8} -spacing {top 0.8 bottom 0.8 left 0.8 right 0.8} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -extend_corner {} -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -inst * -module {}
globalNetConnect VSS -type pgpin -pin VSS -inst * -module {}
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { VSS VDD } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
gui_select -rect {29.481 91.038 4.938 89.711}
pan -60.364 -9.287
pan 8.642 16.419
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign
fit
pan -2.033 11.691
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
fit
getFillerMode -quiet
addFiller -cell FILLCELL_X8 FILLCELL_X4 FILLCELL_X32 FILLCELL_X2 FILLCELL_X16 FILLCELL_X1 -prefix FILLER
fit
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
fit
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
saveDesign MYFIR_PIPED_UNFOLDED.enc
getDrawView
setDrawView fplan
win
dumpToGIF ./ss_FirUnfPipedDie.fplan.gif
getDrawView
setDrawView amoeba
win
dumpToGIF ./ss_FirUnfPipedDie.amoeba.gif
getDrawView
setDrawView place
win
dumpToGIF ./ss_FirUnfPipedDie.place.gif
checkPlace checkplace.ss.rpt
setLayerPreference allM0 -isSelectable 0
setLayerPreference allM1 -isSelectable 0
setLayerPreference allM2Cont -isSelectable 0
setLayerPreference allM2 -isSelectable 0
setLayerPreference allM3Cont -isSelectable 0
setLayerPreference allM3 -isSelectable 0
setLayerPreference allM4Cont -isSelectable 0
setLayerPreference allM4 -isSelectable 0
setLayerPreference allM5Cont -isSelectable 0
setLayerPreference allM5 -isSelectable 0
setLayerPreference allM6Cont -isSelectable 0
setLayerPreference allM6 -isSelectable 0
setLayerPreference allM7Cont -isSelectable 0
setLayerPreference allM7 -isSelectable 0
setLayerPreference allM8Cont -isSelectable 0
setLayerPreference allM8 -isSelectable 0
setLayerPreference allM9Cont -isSelectable 0
setLayerPreference allM9 -isSelectable 0
setLayerPreference allM10Cont -isSelectable 0
setLayerPreference allM10 -isSelectable 0
setLayerPreference allM0 -isSelectable 1
setLayerPreference allM1 -isSelectable 1
setLayerPreference allM2Cont -isSelectable 1
setLayerPreference allM2 -isSelectable 1
setLayerPreference allM3Cont -isSelectable 1
setLayerPreference allM3 -isSelectable 1
setLayerPreference allM4Cont -isSelectable 1
setLayerPreference allM4 -isSelectable 1
setLayerPreference allM5Cont -isSelectable 1
setLayerPreference allM5 -isSelectable 1
setLayerPreference allM6Cont -isSelectable 1
setLayerPreference allM6 -isSelectable 1
setLayerPreference allM7Cont -isSelectable 1
setLayerPreference allM7 -isSelectable 1
setLayerPreference allM8Cont -isSelectable 1
setLayerPreference allM8 -isSelectable 1
setLayerPreference allM9Cont -isSelectable 1
setLayerPreference allM9 -isSelectable 1
setLayerPreference allM10Cont -isSelectable 1
setLayerPreference allM10 -isSelectable 1
setLayerPreference allM0 -isVisible 0
setLayerPreference allM1 -isVisible 0
setLayerPreference allM2Cont -isVisible 0
setLayerPreference allM2 -isVisible 0
setLayerPreference allM3Cont -isVisible 0
setLayerPreference allM3 -isVisible 0
setLayerPreference allM4Cont -isVisible 0
setLayerPreference allM4 -isVisible 0
setLayerPreference allM5Cont -isVisible 0
setLayerPreference allM5 -isVisible 0
setLayerPreference allM6Cont -isVisible 0
setLayerPreference allM6 -isVisible 0
setLayerPreference allM7Cont -isVisible 0
setLayerPreference allM7 -isVisible 0
setLayerPreference allM8Cont -isVisible 0
setLayerPreference allM8 -isVisible 0
setLayerPreference allM9Cont -isVisible 0
setLayerPreference allM9 -isVisible 0
setLayerPreference allM10Cont -isVisible 0
setLayerPreference allM10 -isVisible 0
setLayerPreference allM1 -isVisible 1
setLayerPreference allM2Cont -isVisible 1
setLayerPreference allM2Cont -isVisible 0
setLayerPreference allM2 -isVisible 1
setLayerPreference allM3Cont -isVisible 1
setLayerPreference allM3Cont -isVisible 0
setLayerPreference allM3 -isVisible 1
setLayerPreference allM4Cont -isVisible 1
setLayerPreference allM4Cont -isVisible 0
setLayerPreference allM4 -isVisible 1
setLayerPreference allM8 -isVisible 1
setLayerPreference allM7 -isVisible 1
setLayerPreference allM6 -isVisible 1
setLayerPreference allM5 -isVisible 1
setLayerPreference allM0 -isVisible 1
setLayerPreference allM2Cont -isVisible 1
setLayerPreference allM3Cont -isVisible 1
setLayerPreference allM4Cont -isVisible 1
setLayerPreference allM5Cont -isVisible 1
setLayerPreference allM6Cont -isVisible 1
setLayerPreference allM7Cont -isVisible 1
setLayerPreference allM8Cont -isVisible 1
setLayerPreference allM9Cont -isVisible 1
setLayerPreference allM9 -isVisible 1
setLayerPreference allM10Cont -isVisible 1
setLayerPreference allM10 -isVisible 1
setLayerPreference densityMap -isVisible 1
setLayerPreference pinDensityMap -isVisible 1
setLayerPreference timingMap -isVisible 1
setLayerPreference metalDensityMap -isVisible 1
setLayerPreference powerDensity -isVisible 1
setLayerPreference groupmain_Congestion -isVisible 1
::fit main.layout.win
setLayerPreference congestObj -isVisible 0
setLayerPreference congestObj -isVisible 1
setLayerPreference pinDensityMap -isVisible 0
setLayerPreference densityMap -isVisible 0
setLayerPreference metalDensityMap -isVisible 0
setLayerPreference timingMap -isVisible 0
setLayerPreference metalDensityMap -isVisible 1
pan 5.845 19.312
pan -2.287 -24.141
setLayerPreference densityMap -isVisible 1
setLayerPreference pinDensityMap -isVisible 1
setLayerPreference timingMap -isVisible 1
setLayerPreference densityMap -isVisible 0
setLayerPreference pinDensityMap -isVisible 0
setLayerPreference timingMap -isVisible 0
setLayerPreference metalDensityMap -isVisible 0
setLayerPreference powerDensity -isVisible 0
setLayerPreference groupmain_Congestion -isVisible 0
setLayerPreference trackObj -isVisible 1
setLayerPreference nonPrefTrackObj -isVisible 1
setLayerPreference trackObj -isVisible 0
setLayerPreference nonPrefTrackObj -isVisible 0
setLayerPreference mGrid -isVisible 1
setLayerPreference pGrid -isVisible 1
setLayerPreference userGrid -isVisible 1
setLayerPreference iGrid -isVisible 1
setLayerPreference fmGrid -isVisible 1
setLayerPreference fiGrid -isVisible 1
setLayerPreference fpGrid -isVisible 1
setLayerPreference gcell -isVisible 1
setLayerPreference trimGridObj -isVisible 1
setLayerPreference pgViaGridObj -isVisible 1
setLayerPreference mGrid -isVisible 0
setLayerPreference pGrid -isVisible 0
setLayerPreference userGrid -isVisible 0
setLayerPreference iGrid -isVisible 0
setLayerPreference fmGrid -isVisible 0
setLayerPreference fiGrid -isVisible 0
setLayerPreference fpGrid -isVisible 0
setLayerPreference gcell -isVisible 0
setLayerPreference trimGridObj -isVisible 0
setLayerPreference pgViaGridObj -isVisible 0
setDrawView fplan
setDrawView ameba
setDrawView place
create_ccopt_clock_tree_spec -immediate
ctd_win -id ctd_window
selectInst DATAPATH_pipe1_state2_0_clk_gate_REG_OUT_reg/latch
zoomSelected
deselectInst DATAPATH_pipe1_state2_0_clk_gate_REG_OUT_reg/latch
selectObject IO_Pin CLK
zoomSelected
selectInst DATAPATH_state_2_1_clk_gate_REG_OUT_reg/latch
zoomSelected
deselectInst DATAPATH_state_2_1_clk_gate_REG_OUT_reg/latch
deselectAll
fit
reset_parasitics
extractRC
rcOut -setload MYFIR_PIPED_UNFOLDED.setload -rc_corner my_rc
rcOut -setres MYFIR_PIPED_UNFOLDED.setres -rc_corner my_rc
rcOut -spf MYFIR_PIPED_UNFOLDED.spf -rc_corner my_rc
rcOut -spef MYFIR_PIPED_UNFOLDED.spef -rc_corner my_rc
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix MYFIR_PIPED_UNFOLDED_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix MYFIR_PIPED_UNFOLDED_postRoute -outDir timingReports
setAnalysisMode -analysisType onChipVariation
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
optDesign -postRoute -hold
saveDesign MYFIR_PIPED_UNFOLDED.enc
reset_parasitics
extractRC
rcOut -setload MYFIR_PIPED_UNFOLDED.setload -rc_corner my_rc
rcOut -setres MYFIR_PIPED_UNFOLDED.setres -rc_corner my_rc
rcOut -spf MYFIR_PIPED_UNFOLDED.spf -rc_corner my_rc
rcOut -spef MYFIR_PIPED_UNFOLDED.spef -rc_corner my_rc
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix MYFIR_PIPED_UNFOLDED_postRoute -outDir timingReports
verifyConnectivity -type all -error 1000 -warning 50
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
reportGateCount -level 5 -limit 100 -outfile MYFIR_PIPED_UNFOLDED.gateCount
saveNetlist MYFIR_PIPED_UNFOLDED.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network MYFIR_PIPED_UNFOLDED.sdf
selectWire 50.0300 50.4350 53.5200 50.5050 3 DATAPATH_mult_225_I5_n39
deselectAll
selectInst DATAPATH_state_2_3_REG_OUT_reg_1_
deselectAll
selectInst DATAPATH_mult_225_I2_U17
deselectAll
selectInst DATAPATH_mult_221_I2_U21
deselectAll
selectInst DATAPATH_pipe1_state1_0_REG_OUT_reg_4_
deselectAll
selectInst FILLER_809
deselectAll
selectInst FILLER_809
deselectAll
selectWire 5.1300 14.7550 131.4800 14.9250 1 VSS
deselectAll
selectInst DATAPATH_mult_225_I4_U260
deselectAll
reset_parasitics
extractRC
rcOut -setload MYFIR_PIPED_UNFOLDED.setload -rc_corner my_rc
rcOut -setres MYFIR_PIPED_UNFOLDED.setres -rc_corner my_rc
rcOut -spf MYFIR_PIPED_UNFOLDED.spf -rc_corner my_rc
rcOut -spef MYFIR_PIPED_UNFOLDED.spef -rc_corner my_rc
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
read_activity_file -format VCD -scope /tb_fir/UUT -start {} -end {} -block {} ../vcd/myfir_UnfPiped.vcd
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//MYFIR_PIPED_UNFOLDED.rpt
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
read_activity_file -format VCD -scope /tb_fir/UUT -start {} -end {} -block {} ../vcd/myfir_UnfPiped.vcd
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//MYFIR_PIPED_UNFOLDED.rpt
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
read_activity_file -format VCD -scope /tb_fir/UUT -start {} -end {} -block {} ../vcd/myfir_UnfPiped.vcd
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//MYFIR_PIPED_UNFOLDED.rpt
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
read_activity_file -format VCD -scope /tb_fir/UUT -start {} -end {} -block {} ../vcd/design_UnfPiped.vcd
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//MYFIR_PIPED_UNFOLDED.rpt
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
read_activity_file -format VCD -scope /tb_fir/UUT -start {} -end {} -block {} ../vcd/design_UnfPiped.vcd
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//MYFIR_PIPED_UNFOLDED.rpt
encMessage warning 0
encMessage debug 0
encMessage info 0
restoreDesign /home/isa25/Desktop/Laboratori-ISA/Lab1/innovus_UnfPiped/MYFIR_PIPED_UNFOLDED.enc.dat MYFIR_PIPED_UNFOLDED
