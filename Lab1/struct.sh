SRC_OK=0
TB_OK=0
if [ -d "src" ]; then
	cd src
	if [ ! -e *.vhd ]; then
		echo "Non sono presenti file .vhd nella cartella scr"
	else
		SRC_OK=1
	fi
	cd ..
else
	mkdir src
	echo "La cartella src è stata creata, aggiungere i file .vhd"
fi
if [ -d "tb" ]; then
	cd tb	
	if [ ! -e *.v ]; then
		echo "Non sono presenti file .v nella cartella tb"
	else
		TB_OK=1	
	fi
	cd ..
else
	mkdir tb
	echo "La cartella tb è stata creata, aggiungere i file .v"
fi
if [ ! -d "sim" ]; then
	mkdir sim
	echo "La cartella sim non era presente ed è stata creata"
fi
