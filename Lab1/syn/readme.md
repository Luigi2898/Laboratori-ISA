### This directory contains synthesis scripts.
In particular:
- syn.sh: prepares all useful directories, removing and recreating work directory if present, synthesizes one of the chosen configuration (it asks with a menu what to synthesize) calling a different tcl script for every configuration, at the end it calls a python script: changeCLK.py
- synth.tcl synthCKG.tcl synthFIR.tcl synthFIRCKG.tcl synthPIPE.tcl synthPIPECKG.tcl synthUNF.tcl synthUNFCKG.tcl: depending on the type of synthesis to perform they call a function in definition.tcl
- definition.tcl: contains definition of the synthesis script, with all the commands to perform synthesis and reporting; it generates a file .outGG that stores four time the value of minimum period, calculated by timinig report automatic reading
- *.outGG: all this files store four times the minimun period
- changeCLK.py: reading .outGG files produces a clockg_gen.vhd replica with the right value of period, so that during back annotation simulations will be performed with right period
- backSyn.tcl backSynNC.tcl: perform back annotation, reading the netlist and producing power reports
