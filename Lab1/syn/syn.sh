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
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
else
    echo "La cartella synthreport è presente, la elimino e la ricreo"
    rm -r synthReport
    mkdir synthReport
    cd synthReport
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
fi
if [ ! -d netlist ]
then
    echo "La cartella netlist non è presente, la creo"
    mkdir netlist
    cd netlist
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
else
    rm -r netlist
    mkdir netlist
    cd netlist
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
fi
if [ ! -d synthReportAfterBack ]
then
    echo "La cartella synthReportAfterBack non è presente, la creo"
    mkdir synthReportAfterBack
    cd synthReportAfterBack
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
else
    rm -r synthReportAfterBack
    mkdir synthReportAfterBack
    cd synthReportAfterBack
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
fi
if [ ! -d logs ]
then
    echo "La cartella logs non è presente, la creo"
    mkdir logs
    cd logs
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
else
    rm -r logs
    mkdir logs
    cd logs
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
fi
if [ ! -d savings ]
then
    echo "La cartella savings non è presente, la creo"
    mkdir savings
    cd savings
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
else
    rm -r savings
    mkdir savings
    cd savings
    mkdir gating
    cd gating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    mkdir noGating
    cd noGating
    mkdir fir
    mkdir firUnfolded
    mkdir firNC
    mkdir firUnfoldedNC
    mkdir firUnfoldedPiped
    mkdir firUnfoldedPipedNC
    cd ..
    cd ..
fi
echo "Select an option to synthesize:"
echo " 1 - FIR - direct form (no gating)"
echo " 2 - FIR - unfolded (no gating)"
echo " 3 - FIR - unfolded and piped (no gating)"
echo " 4 - synthesize all (no gating)"
echo " 5 - FIR - direct form (gating)"
echo " 6 - FIR - unfolded (gating)"
echo " 7 - FIR - unfolded and piped (gating)"
echo " 8 - synthesize all (gating)"
echo " 9 - synthesize all (gating and no gating)"
read response
source /software/scripts/init_synopsys_64.18
case $response in
    1)
        dc_shell-xg-t -f synthFIR.tcl
    ;;
    2)
        dc_shell-xg-t -f synthUNF.tcl
    ;;
    3)
        dc_shell-xg-t -f synthPIPE.tcl
    ;;
    4)
        dc_shell-xg-t -f synth.tcl
    ;;
    5)
        dc_shell-xg-t -f synthFIRCKG.tcl
    ;;
    6)
        dc_shell-xg-t -f synthUNFCKG.tcl
    ;;
    7)
        dc_shell-xg-t -f synthPIPECKG.tcl
    ;;
    8)
        dc_shell-xg-t -f synthCKG.tcl
    ;;
    9)
        dc_shell-xg-t -f synthandCKG.tcl
    ;;  
esac
python3 changeCLK.py ../src/testbenchComponents/clk_gen.vhd *.outGG
dir="../OldRes/res_$(date +%F)"_"$(date +%T)_justSyn"
cp -r synthReport $dir
cp -r netlist $dir
cp -r logs $dir
cp -r savings $dir
