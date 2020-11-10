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
        backAnn $noGated $normdir $normdirNC $normaltag $tbtagNormal
    ;;
    2)
        backAnn $noGated $unfoldeddir $unfoldeddirNC $unfoldedtag $tbtagUnfolded
    ;;
    3)
        backAnn $noGated $pipeddir $pipeddirNC $pipedtag $tbtagPiped
    ;;
    4)
        backAnn $noGated $normdir $normdirNC $normaltag $tbtagNormal
        backAnn $noGated $unfoldeddir $unfoldeddirNC $unfoldedtag $tbtagUnfolded
        backAnn $noGated $pipeddir $pipeddirNC $pipedtag $tbtagPiped
    ;;
    5)
        backAnn $gated $normdir $normdirNC $normaltagCKG $tbtagNormal
    ;;
    6)
        backAnn $gated $unfoldeddir $unfoldeddirNC $unfoldedtagCKG $tbtagUnfolded
    ;;
    7)
        backAnn $gated $pipeddir $pipeddirNC $pipedtagCKG $tbtagPiped
    ;;
    8)
        backAnn $gated $normdir $normdirNC $normaltagCKG $tbtagNormal
        backAnn $gated $unfoldeddir $unfoldeddirNC $unfoldedtagCKG $tbtagUnfolded
        backAnn $gated $pipeddir $pipeddirNC $pipedtagCKG $tbtagPiped
    ;;
    9)
        backAnn $noGated $normdir $normdirNC $normaltag $tbtagNormal
        backAnn $noGated $unfoldeddir $unfoldeddirNC $unfoldedtag $tbtagUnfolded
        backAnn $noGated $pipeddir $pipeddirNC $pipedtag $tbtagPiped
        backAnn $gated $normdir $normdirNC $normaltagCKG $tbtagNormal
        backAnn $gated $unfoldeddir $unfoldeddirNC $unfoldedtagCKG $tbtagUnfolded
        backAnn $gated $pipeddir $pipeddirNC $pipedtagCKG $tbtagPiped
    ;;  
esac

dir="./OldRes/res_$(date +%F)"_"$(date +%H)"-"$(date +%M)"-"$(date +%S)_synAndBack"
mkdir $dir
cp -r ./syn/synthReport $dir 
cp -r ./syn/netlist $dir
cp -r ./syn/logs $dir
cp -r ./syn/synthReportAfterBack $dir
cp -r ./vcd $dir
cp -r ./saif $dir