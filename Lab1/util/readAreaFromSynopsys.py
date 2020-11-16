import sys
from pathlib import Path

for inputPath in sys.argv[1:]:
    areaFileName = Path(inputPath).name
    fArea = open(inputPath, 'r')
    outputFileName = 'elab_' + areaFileName
    outputPath = Path(inputPath).parent / outputFileName
    fOut = open(str(outputPath), 'w')
    inputLines = fArea.readlines()
    for line in inputLines:
        if 'area' in line:
            ls = line.split(' ')
            area = ls[-1]
            try:
                float(area)
                fOut.write(area)
            except:
                pass
