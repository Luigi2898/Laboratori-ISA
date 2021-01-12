#This script synthesizes the three architectures

source ./definition.tcl

#DIRECT FORM architecture

set newPer [synth $norme $normdir $normdir 10.0 0]

synth $norme $normdir $normdirNC $newPer 0

set fp [open "newPer$normaltag.outGG" w]
puts $fp $newPer
close $fp

#UNFOLDED architecture

set newPer [synth $unfoldede $unfoldeddir $unfoldeddir 10.0 0]

synth $unfoldede $unfoldeddir $unfoldeddirNC $newPer 0

set fp [open "newPer$unfoldedtag.outGG" w]
puts $fp $newPer
close $fp

#UNFOLDED & PIPED architecture

set newPer [synth $pipede $pipeddir $pipeddir 10.0 0]

synth $pipede $pipeddir $pipeddirNC $newPer 0

set fp [open "newPer$pipedtag.outGG" w]
puts $fp $newPer
close $fp

exit
