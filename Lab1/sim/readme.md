### This directory contains script useful to perform simulations.
In particular:
- simulation.sh: Simulates direct form
- simulationUnfolded.sh: Simulates unfolded architecture
- simulationUnfoldedPiped.sh: Simulates unfolded and pipelined architecture

They all compile necessary files, start modelsim and execute simulationVsim.tcl that runs simulation itself.

While backVsim.tcl and backVsimNC.tcl simulates for back annotation, they in fact produce .vcd files too; they handle respectively netlist at 10ns and at 4Tmin.
