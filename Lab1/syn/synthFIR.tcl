source ./definition.tcl

set newPer [synth $norme $normdir $normdir 10.0 0]

synth $norme $normdir $normdirNC $newPer 0

set fp [open "newPer$normaltag.outGG" w]
puts $fp $newPer
close $fp

exit