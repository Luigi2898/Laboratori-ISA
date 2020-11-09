source ./definition.tcl

set newPer [synth $norme $normdir $normdir 10.0 1]

synth $norme $normdir $normdirNC $newPer 1

set fp [open "newPer$normaltag.CKG.outGG" w]
puts $fp $newPer
close $fp

exit