source ./definition.tcl

set newPer [synth $unfoldede $unfoldeddir $unfoldeddir 10.0 0]

synth $unfoldede $unfoldeddir $unfoldeddirNC $newPer 0

set fp [open "newPer$unfoldedtag.outGG" w]
puts $fp $newPer
close $fp

exit