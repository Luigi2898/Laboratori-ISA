source ./definition.tcl

set newPer [synth $unfoldede $unfoldeddir $unfoldeddir 10.0 1]

synth $unfoldede $unfoldeddir $unfoldeddirNC $newPer 1

set fp [open "newPer$unfoldedtag.CKG.outGG" w]
puts $fp $newPer
close $fp

exit