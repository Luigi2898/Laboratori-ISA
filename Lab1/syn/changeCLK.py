import sys

VHDLFile = sys.argv[1]
outGGFile = sys.argv[2:]
VHDLFileName = VHDLFile.split('/')[-1]
VHDLFilePath = VHDLFile[:-len(VHDLFileName)]
inVHDlines = open(VHDLFile, 'r').readlines()

for perF in outGGFile :
    newPer = open(perF, 'r').readline()
    if len(perF.split('.')) == 2 :
        fileN, ext = perF.split('.')
        CKGing = ''
    else :
        fileN, CKGing, ext = perF.split('.')
    tag = fileN.split('_')[1]
    outVHDLfile = VHDLFilePath + VHDLFileName.split('.')[0] + '_' + tag + '_' + CKGing + '.vhd'
    outVHD = open(outVHDLfile, 'w')
    for line in inVHDlines :
        if 'time' in line :
            pos = line.find('10')
            newLine = line[ : pos] + newPer[:-1] + line[pos + 2 : ]
            outVHD.write(newLine)
        else :
            outVHD.write(line)
    outVHD.close()



