import sys
from pathlib import Path

for inputPath in sys.argv[1:]:
    powerFileName = Path(inputPath).name
    fPower = open(inputPath, 'r')
    outputFileName = 'elab_' + powerFileName
    outputPath = Path(inputPath).parent / outputFileName
    fOut = open(str(outputPath), 'w')
    inputLines = fPower.readlines()
    for line in inputLines:
        ls = line.split(' ')
        if 'Total Internal Power' in line or 'Total Switching Power' in line or 'Total Leakage Power' in line or 'Total Power:' in line:
            try:
                power = ls[ls.index('\t')-1]
            except:
                power = ls[-2]
            fOut.write(power + "\n")
            print(power)