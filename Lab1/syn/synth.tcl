
foreach filei fileList {
    filen = $filei + ".vhd"
    analyze -f vhdl -lib WORK ../src/$filen
}
