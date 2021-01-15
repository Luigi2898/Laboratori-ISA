variable unfoldeddir "firUnfolded"
variable normdir "fir"
variable pipeddir "firUnfoldedPiped"

variable unfoldeddirNC "firUnfoldedNC"
variable normdirNC "firNC"
variable pipeddirNC "firUnfoldedPipedNC"

variable unfoldedtag "_UNFOLDED_"
variable normaltag "_NORMAL_"
variable pipedtag "_PIPED_"

variable norme "myfir"
variable unfoldede "myfir_unfolded"
variable pipede "myfir_piped_unfolded"

proc synth {ent dir odir per CKG} {
    if { $CKG == 1 } {
        variable gated "gating"
    } else {
        variable gated "noGating"
    }
    set power_preserve_rtl_hier_names true
    catch {analyze -f vhdl -lib WORK -autoread {../src/commonComponents} > ./logs/$gated/$odir/analyzeCC.log} analCC
    if { $analCC == ""} {
        puts "Analisi di ../src/commonComponents avvenuta con successo"
    } else {
        puts "Analisi di ../src/commonComponents NON avvenuta con successo"
        puts $analCC
    }
    variable analdir "{../src/$dir}"
    catch {analyze -f vhdl -lib WORK -autoread "$analdir" > ./logs/$gated/$odir/$dir.log} analdes
    if { $analdes == ""} {
        puts "Analisi di ../src/$dir avvenuta con successo"
    } else {
        puts "Analisi di ../src/$dir NON avvenuta con successo"
        puts $analdes
    }
    catch {elaborate $ent -arch beh -lib WORK > ./logs/$gated/$odir/elaboration.log} elabo
    if { $elabo == ""} {
        puts "Elaborazione di ../src/$dir avvenuta con successo"
    } else {
        puts "Elaborazione di ../src/$dir NON avvenuta con successo"
        puts $elabo
    }
    write -hierarchy -format ddc -output savings/$gated/$odir/$ent.beforesyn.ddc
    uniquify
    link
    create_clock -name MY_CLK -period $per CLK
    set_dont_touch_network MY_CLK
    set_clock_uncertainty 0.07 [get_clocks MY_CLK]
    set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
    set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
    set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
    set_load $OLOAD [all_outputs]
    if { $CKG == 1 } {
	catch {compile -exact_map -gate_clock > ./logs/$gated/$odir/compilation.log} compo
    } else {
	catch {compile -exact_map > ./logs/$gated/$odir/compilation.log} compo
    }
    
    if { $compo == ""} {
        puts "Compilazione di ../src/$dir avvenuta con successo"
    } else {
        puts "Compilazione di ../src/$dir NON avvenuta con successo"
        puts $compo
    }
    report_timing > synthReport/$gated/$odir/timing.txt
    report_area  > synthReport/$gated/$odir/area.txt
    report_power > synthReport/$gated/$odir/power.txt
    report_power -net > synthReport/$gated/$odir/power-net.txt
    report_power -cell > synthReport/$gated/$odir/power-cell.txt
    report_power -hierarchy > synthReport/$gated/$odir/power-hierarchy.txt
    report_power -verbose > synthReport/$gated/$odir/power-verbose.txt
    ungroup -all -flatten
    change_names -hierarchy -rules verilog
    write_sdf netlist/$gated/$odir/myfir.sdf
    write -f verilog -hierarchy -output netlist/$gated/$odir/myfir.v
    write_sdc netlist/$gated/$odir/myfir.sdc
    write -hierarchy -format ddc -output savings/$gated/$odir/$ent.ddc
    set pathW [get_timing_paths -nworst 1]
    set sl [ get_attribute $pathW slack ]
    set per [ get_attribute [ get_clocks MY_CLK ] period ]
    set dat [expr $per - $sl]
    set newPer [expr $dat * 4.0]
    return $newPer
}

