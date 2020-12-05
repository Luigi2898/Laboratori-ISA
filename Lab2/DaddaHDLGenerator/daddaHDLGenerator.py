from util import Dadda
import util as u
from copy import deepcopy

with open("DADDA.vhd", 'w') as of:
    of.write(u.START)

d = Dadda(17, 33)
d.reductTree()
with open("outDotNotation.txt", 'w') as of:
    for el in d.tree:
        d.printMatrix(el.matrix, of)


CSAindex = 1
HAindex = 1
declarations = []
signals = []

#Definitions of signals

for level in range(d.L + 1):
    row = []
    for i in range(d.H):
        sig = (u.INTERNAL_SIG %(level, i), 0, 0)
        dots = u.countDot(d.tree[level].matrix[:][i])
        if not(dots == 0):
            dec = u.SIGNAL %(sig[0], u.SLV % (65 - 1))
            row.append(sig)
            declarations.append(dec)
    signals.append(row)

#Sign extension

assignements = []
for i, aRow in enumerate(d.tree[0].matrix):
    inBit = []
    for aDot in aRow:
        if aDot.isEmpty():
            b = "\'0\'"
            inBit.append(b)
        if aDot.isSign():
            b = "PP_sign(" + str(aDot.w) + ")"
            inBit.append(b)
        elif aDot.isSignNeg():
            b = "not(PP_sign(" + str(aDot.w) + "))"
            inBit.append(b)
        elif aDot.isBlack():
            b = "PP" + str(aDot.h + 1) + "(" + str(aDot.w) + ")"
            inBit.append(b)
        elif aDot.isOne():
            b = "\'1\'"
            inBit.append(b)
    assignements.append(u.assign(signals[0][i][0], inBit))

with open("DADDA.vhd", 'a') as of:
    of.write("\nbegin\n\n")
    for ass in assignements:
        of.write(ass + "\n")
    of.write("\n\n")

#Definition of operands

FAindex = 0
HAindex = 0
outSig = []
for level in range(d.L):
    FullA = list(reversed(d.operators[level][1]))
    HalfA = list(reversed(d.operators[level][0]))
    i = 0
    for fA, hA in zip(FullA, HalfA):
        if fA != 0:
            for j in range(fA):
                i1 = u.downto(signals[level][3 * j][0], i, i)
                i2 = u.downto(signals[level][3 * j + 1][0], i, i)
                i3 = u.downto(signals[level][3 * j + 2][0], i, i)
                d.tree[level].matrix[3*j][i].touch()
                d.tree[level].matrix[3*j + 1][i].touch()
                d.tree[level].matrix[3*j + 2][i].touch()
                os = u.downto(signals[level + 1][j // 3][0], i, i)
                oc = u.downto(signals[level + 1][j // 3 + 1][0], i + 1, i + 1)
                k = 0
                while os in outSig:
                    os = u.downto(signals[level + 1][j // 3 + k][0], i, i)
                    k += 1
                outSig.append(os)

                k = 0
                while oc in outSig:
                    oc = u.downto(signals[level + 1][j // 3 + 1 + k][0], i + 1, i + 1)
                    k += 1
                outSig.append(oc)
                with open("DADDA.vhd", 'a') as of:
                    of.write(u.FA % (FAindex, i1, i2, i3, os, oc) + '\n')
                FAindex += 1
        if hA != 0:
            for j in range(hA):
                i1 = u.downto(signals[level][2 * j + 3 * fA][0], i, i)
                i2 = u.downto(signals[level][2 * j + 1 + 3 * fA][0], i, i)
                d.tree[level].matrix[2 * j + 3 * fA][i].touch()
                d.tree[level].matrix[2 * j + 1 + 3 * fA][i].touch()
                os = u.downto(signals[level + 1][j // 2 + fA][0], i, i)
                oc = u.downto(signals[level + 1][j // 2 + 1 + fA][0], i + 1, i + 1)
                k = 0
                while os in outSig:
                    os = u.downto(signals[level + 1][j // 3 + k][0], i, i)
                    k += 1
                outSig.append(os)
                k = 0
                while oc in outSig:
                    oc = u.downto(signals[level + 1][j // 3 + 1 + k][0], i + 1, i + 1)
                    k += 1
                outSig.append(oc)
                with open("DADDA.vhd", 'a') as of:
                    of.write(u.HA % (HAindex, i1, i2, os, oc) + '\n')
                HAindex += 1
        i += 1
        
    for j, row in enumerate(d.tree[level].matrix):
        for i, aDot in enumerate(reversed(row)):
            try:
                if not(aDot.isTouched()):
                    o = u.downto(signals[level + 1][j - 3 * FullA[i] - HalfA[i]][0], i, i)
                    k = 0
                    while o in outSig:
                        o = u.downto(signals[level + 1][j - 3 * FullA[i] - HalfA[i] + k][0], i, i)
                        k += 1
                    outSig.append(o)
                    with open("DADDA.vhd", 'a') as of:
                        of.write(u.assignS( o, u.downto(signals[level][j][0], i, i)) + ';\n')
            except:
                pass
           


lines = []
with open("DADDA.vhd", 'r') as inf:
    lines = inf.readlines()

with open("DADDA.vhd", 'w') as of:
    for l in lines:
        if "end component HA;" in l:
            of.write(l)
            for de in declarations:
                of.write(de + '\n')
            of.write('\n\n')
        else:
            of.write(l)



with open("DADDA.vhd", 'a') as of:
    of.write("\n\nSUM <= unsigned( " + signals[6][0][0] + " ) + unsigned( " + signals[6][1][0] + " ) ;\n")
    of.write("\n\nend architecture ;")