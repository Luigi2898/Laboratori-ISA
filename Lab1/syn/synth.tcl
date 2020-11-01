source ./definition.tcl


set newPer [synth $norme $normdir $normdir 10.0]

synth $norme $normdir $normdirNC $newPer

set fp [open "newPer$normaltag.outGG" w]
puts $fp $newPer
close $fp

set newPer [synth $unfoldede $unfoldeddir $unfoldeddir 10.0]

synth $unfoldede $unfoldeddir $unfoldeddirNC $newPer

set fp [open "newPer$unfoldedtag.outGG" w]
puts $fp $newPer
close $fp


set newPer [synth $pipede $pipedir $pipedir 10.0]

synth $pipede $pipedir $pipedirNC $newPer

set fp [open "newPer$pipedtag.outGG" w]
puts $fp $newPer
close $fp

exit
