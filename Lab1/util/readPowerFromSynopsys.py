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
        if 'Cell Internal Power' in line or 'Net Switching Power' in line or 'Total Dynamic Power' in line or 'Cell Leakage Power' in line:
            try:
                power = ls[ls.index('uW')-1]
            except:
                power = ls[ls.index('uW\n')-1]
            fOut.write(power + "\n")
            print(power)

