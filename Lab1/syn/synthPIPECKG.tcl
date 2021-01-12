#This script synthesizes the UNFOLDED & PIPED architecture

source ./definition.tcl

set newPer [synth $pipede $pipeddir $pipeddir 10.0 1]

synth $pipede $pipeddir $pipeddirNC $newPer 1

set fp [open "NoCKGnewPer$pipedtag.CKG.outGG" w]
puts $fp $newPer
close $fp

exit
