SRC_OK=0
TB_OK=0
if [ -d "src" ]; then
	cd src
	if [ ! -e *.vhd ]; then
		echo "Non sono presenti file .vhd nella cartella scr"
	else
		SRC_OK=1
	fi
else
	mkdir src
	echo "La cartella src è stata creata, aggiungere i file .vhd"
fi
cd ..
if [ -d "tb" ]; then
	cd tb	
	if [ ! -e *.v ]; then
		echo "Non sono presenti file .v nella cartella tb"
	else
		TB_OK=1	
	fi
else
	mkdir tb
	echo "La cartella tb è stata creata, aggiungere i file .v"
fi
cd ..
if [ ! -d "sim" ]; then
	mkdir sim
	echo "La cartella sim non era presente ed è stata creata"
fi
cd sim
if [ -d "work" ]; then
	rm -r work
	echo "La cartella sim/work era presente ed è stata rimossa"
fi
if [ $TB_OK != 0 ] && [ $SRC_OK != 0 ]; then
	source /software/scripts/init_msim6.2g
	vlib work
	vcom -reportprogress 300 -work  ./work ../src/*.vhd
	vlog -reportprogress 300 -work ./work ../tb/*.v
	vsim
fi

#vsim
