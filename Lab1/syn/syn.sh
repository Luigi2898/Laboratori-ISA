#Checks for correct directory configuration and fixes it
if [ -d work ]
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
if [ ! -d synthReport ]
then
    echo "La cartella synthreport non è presente, la creo"
    mkdir synthReport
    cd synthReport
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
else
    echo "La cartella synthreport è presente, la elimino e la ricreo"
    rm -r synthReport
    mkdir synthReport
    cd synthReport
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
fi
if [ ! -d netlist ]
then
    echo "La cartella netlist non è presente, la creo"
    mkdir netlist
    cd netlist
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
else
    rm -r netlist
    mkdir netlist
    cd netlist
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
fi
if [ ! -d synthReportAfterBack ]
then
    echo "La cartella synthReportAfterBack non è presente, la creo"
    mkdir synthReportAfterBack
    cd synthReportAfterBack
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
else
    rm -r synthReportAfterBack
    mkdir synthReportAfterBack
    cd synthReportAfterBack
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
fi
if [ ! -d logs ]
then
    echo "La cartella logs non è presente, la creo"
    mkdir logs
    cd logs
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
else
    rm -r logs
    mkdir logs
    cd logs
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
fi
if [ ! -d savings ]
then
    echo "La cartella savings non è presente, la creo"
    mkdir savings
    cd savings
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
else
    rm -r savings
    mkdir savings
    cd savings
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
fi
source /software/scripts/init_synopsys_64.18
dc_shell-xg-t -f synth.tcl
dir="../OldRes/res_$(date +%F)"_"$(date +%T)_justSyn"
cp -r synthReport $dir
cp -r netlist $dir
cp -r logs $dir
cp -r savings $dir
