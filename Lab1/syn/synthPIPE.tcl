#This script synthesizes the UNFOLDED & PIPED architecture

source ./definition.tcl

set newPer [synth $pipede $pipeddir $pipeddir 10.0]

synth $pipede $pipeddir $pipeddirNC $newPer

set fp [open "NoCKGnewPer$pipedtag.outGG" w]
puts $fp $newPer
close $fp

exit
