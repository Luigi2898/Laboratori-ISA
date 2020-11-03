#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sat Oct 31 17:24:11 2020                
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
set init_top_cell MYFIR
set init_verilog ../syn/netlist/firNC/MYFIR.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD
init_design
init_design
set init_design_netlisttype verilog
set init_design_settop 1
set init_top_cell MYFIR
set init_verilog ../syn/netlist/firNC/MYFIR.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD
init_design
set init_design_netlisttype verilog
set init_design_settop 1
set init_top_cell MYFIR
set init_verilog ../syn/netlist/firNC/myfir.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site FreePDK45_38x28_10R_NP_162NW_34O -r 1.0 0.6 0.5 0.5 0.5 0.5
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site FreePDK45_38x28_10R_NP_162NW_34O -r 0.97208721011 0.599789 0.57 0.56 0.57 0.56
uiSetTool select
getIoFlowFlag
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site FreePDK45_38x28_10R_NP_162NW_34O -r 1.00 0.6 5 5 5 5
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
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign
setLayerPreference shield -isVisible 0
setLayerPreference unknowState -isVisible 0
setLayerPreference metalFill -isVisible 0
setLayerPreference wire -isVisible 0
setLayerPreference via -isVisible 0
setLayerPreference patch -isVisible 0
setLayerPreference trim -isVisible 0
setLayerPreference shield -isVisible 1
setLayerPreference unknowState -isVisible 1
setLayerPreference metalFill -isVisible 1
setLayerPreference wire -isVisible 1
setLayerPreference via -isVisible 1
setLayerPreference patch -isVisible 1
setLayerPreference trim -isVisible 1
getDrawView
setDrawView fplan
win
dumpToGIF ./ss_myfir_preCTS.fplan.gif
getDrawView
setDrawView amoeba
win
dumpToGIF ./ss_myfir_preCTS.amoeba.gif
getDrawView
setDrawView place
win
dumpToGIF ./ss_myfir_preCTS.place.gif
checkPlace checkplace.ss.rpt
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
getDrawView
setDrawView fplan
win
dumpToGIF ./ss_myfir_postOpt.fplan.gif
getDrawView
setDrawView amoeba
win
dumpToGIF ./ss_myfir_postOpt.amoeba.gif
getDrawView
setDrawView place
win
dumpToGIF ./ss_myfir_postOpt.place.gif
checkPlace checkplace.ss.rpt
getFillerMode -quiet
addFiller -cell FILLCELL_X8 FILLCELL_X4 FILLCELL_X32 FILLCELL_X2 FILLCELL_X16 FILLCELL_X1 -prefix FILLER
setLayerPreference shield -isVisible 0
setLayerPreference unknowState -isVisible 0
setLayerPreference metalFill -isVisible 0
setLayerPreference wire -isVisible 0
setLayerPreference via -isVisible 0
setLayerPreference patch -isVisible 0
setLayerPreference trim -isVisible 0
setLayerPreference shield -isVisible 1
setLayerPreference unknowState -isVisible 1
setLayerPreference metalFill -isVisible 1
setLayerPreference wire -isVisible 1
setLayerPreference via -isVisible 1
setLayerPreference patch -isVisible 1
setLayerPreference trim -isVisible 1
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
getDrawView
setDrawView fplan
win
dumpToGIF ./ss_myfir_postNanoRoute.fplan.gif
getDrawView
setDrawView amoeba
win
dumpToGIF ./ss_myfir_postNanoRoute.amoeba.gif
getDrawView
setDrawView place
win
dumpToGIF ./ss_myfir_postNanoRoute.place.gif
checkPlace checkplace.ss.rpt
setAnalysisMode -analysisType onChipVariation
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
optDesign -postRoute -hold
getDrawView
setDrawView fplan
win
dumpToGIF ./ss_myfir_postFinalECO.fplan.gif
getDrawView
setDrawView amoeba
win
dumpToGIF ./ss_myfir_postFinalECO.amoeba.gif
getDrawView
setDrawView place
win
dumpToGIF ./ss_myfir_postFinalECO.place.gif
checkPlace checkplace.ss.rpt
saveDesign MYFIR.enc
reset_parasitics
extractRC
rcOut -setload MYFIR.setload -rc_corner my_rc
rcOut -setres MYFIR.setres -rc_corner my_rc
rcOut -spf MYFIR.spf -rc_corner my_rc
rcOut -spef MYFIR.spef -rc_corner my_rc
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -slackReports -numPaths 50 -prefix MYFIR_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix MYFIR_postRoute -outDir timingReports
get_power_analysis_mode -leakage_power_view -quiet
get_power_analysis_mode -analysis_view -quiet
get_power_analysis_mode -state_dependent_leakage -quiet
get_power_analysis_mode -dynamic_power_view -quiet
get_power_analysis_mode -analysis_view -quiet
setLayerPreference violation -isVisible 1
violationBrowser -all -no_display_false
violationBrowserClose
verifyConnectivity -type all -error 1000 -warning 50
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
reportGateCount -level 5 -limit 100 -outfile MYFIR.gateCount
saveNetlist MYFIR_innovus.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network MYFIR_innovus.sdf
gui_select -rect {77.858 64.909 70.304 63.514}
deselectAll
selectObject Pin DP_mult_76_G9_U225/ZN
deselectAll
selectInst DP_mult_76_G9_U22
deselectAll
selectWire 57.0600 56.7350 61.5000 56.8050 3 DP_mult_8__9_
deselectAll
selectInst FILLER_2185
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./powerAnal
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
read_activity_file -format VCD -scope /tb_fir/UUT -start {} -end {} -block {} ../vcd/design.vcd
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile ./powerAnal/MYFIR.rpt
deselectAll
report_power -outfile ./powerReport/power.txt -clock_network { MY_CLK } -hierarchy all -sort { total }
selectInst FILLER_1863
deselectAll
selectInst DP_mult_76_G7_U226
