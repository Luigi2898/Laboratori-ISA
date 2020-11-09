source ./backfoo.sh

source ./prepareForBack.sh

echo "Select an option to backannotate:"
echo " 1 - FIR - direct form (no gating)"
echo " 2 - FIR - unfolded (no gating)"
echo " 3 - FIR - unfolded and piped (no gating)"
echo " 4 - backannotate all (no gating)"
echo " 5 - FIR - direct form (gating)"
echo " 6 - FIR - unfolded (gating)"
echo " 7 - FIR - unfolded and piped (gating)"
echo " 8 - backannotate all (gating)"
echo " 9 - backannotate all (gating and no gating)"
read response
case $response in
    1)
        backAnn $noGated $normdir $normdirNC $normaltag
    ;;
    2)
        backAnn $noGated $unfoldeddir $unfoldeddirNC $unfoldedtag
    ;;
    3)
        backAnn $noGated $pipeddir $pipeddirNC $pipedtag
    ;;
    4)
        backAnn $noGated $normdir $normdirNC $normaltag
        backAnn $noGated $unfoldeddir $unfoldeddirNC $unfoldedtag
        backAnn $noGated $pipeddir $pipeddirNC $pipedtag
    ;;
    5)
        backAnn $gated $normdir $normdirNC $normaltagCKG
    ;;
    6)
        backAnn $gated $unfoldeddir $unfoldeddirNC $unfoldedtagCKG
    ;;
    7)
        backAnn $gated $pipeddir $pipeddirNC $pipedtagCKG
    ;;
    8)
        backAnn $gated $normdir $normdirNC $normaltagCKG
        backAnn $gated $unfoldeddir $unfoldeddirNC $unfoldedtagCKG
        backAnn $gated $pipeddir $pipeddirNC $pipedtagCKG
    ;;
    9)
        backAnn $noGated $normdir $normdirNC $normaltag
        backAnn $noGated $unfoldeddir $unfoldeddirNC $unfoldedtag
        backAnn $noGated $pipeddir $pipeddirNC $pipedtag
        backAnn $gated $normdir $normdirNC $normaltagCKG
        backAnn $gated $unfoldeddir $unfoldeddirNC $unfoldedtagCKG
        backAnn $gated $pipeddir $pipeddirNC $pipedtagCKG
    ;;  
esac

dir="../OldRes/res_$(date +%F)"_"$(date +%H)"-"$(date +%M)"-"$(date +%S)_synAndBack"
mkdir $dir
cp -r ./synthReport $dir 
cp -r ./netlist $dir
cp -r ./logs $dir
cp -r ./synthReportAfterBack $dir
cp -r ../vcd $dir
cp -r ../saif $dir