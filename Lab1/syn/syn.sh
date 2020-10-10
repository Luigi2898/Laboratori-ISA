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
if [ ! -d synthReport ]    # ← see 'man bash' for valid conditional statements.
then
    mkdir synthReport
fi
if [ ! -d netlist ]    # ← see 'man bash' for valid conditional statements.
then
    mkdir netlist
fi

source /software/scripts/init_synopsys_64.18
design_vision -f synth.tcl
