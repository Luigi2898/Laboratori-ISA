
foreach filei $(ls ../src) {
    analyze -f vhdl -lib WORK ../src/$filei
}
