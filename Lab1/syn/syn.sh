if [ -d work ]    # ← see 'man test' for available unary and binary operators.
then
    echo "Ho trovato la cartella work, per rendere deterministici i risultati procedo con la rimozione e la creazione della cartella"
    rm *.log
    rm *.svf
    rm -rf work
    mkdir work
else
    echo "La cartella work non è presente, la creo"
    mkdir work
fi
if [ ! -d synthReport ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella synthreport non è presente, la creo"
    mkdir synthReport
    cd synthReport
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
if [ ! -d netlist ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella netlist non è presente, la creo"
    mkdir netlist
    cd netlist
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
if [ ! -d synthReportAfterBack ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella synthReportAfterBack non è presente, la creo"
    mkdir synthReportAfterBack
    cd synthReportAfterBack
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
if [ ! -d logs ]    # ← see 'man test' for available unary and binary operators.
then
    echo "La cartella logs non è presente, la creo"
    mkdir logs
    cd logs
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    cd ..
fi
source /software/scripts/init_synopsys_64.18
dc_shell-xg-t -f synth.tcl
dir="../OldRes/res_$(date +%F)"_"$(date +%T)_justSyn"
cp -r synthReport $dir
cp -r netlist $dir
cp -r logs $dir
