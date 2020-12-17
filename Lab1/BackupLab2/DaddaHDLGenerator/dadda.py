from util import Dadda
import util as u

#
#            def print2VHD(self):
#        CSAindex = 1
#        HAindex = 1
#        declarations = []
#        signals = []
#        for level in range(self.L):
#            for i in range(self.H):
#                name = INTERNAL_SIG %(level, i)
#                dec = SIGNAL %(name, SLV % countDot(self.tree[level].matrix[:][i]))
#                signals.append(name)
#                declarations.append(dec)
#            print(signals)
#            print(declarations)
#        for level, op in enumerate(self.operators):
#            FullA = op[1]
#            while not(FullA.count(0) == len(FullA)):
#                CSApar = 0
#                first = True
#                for i, _ in enumerate(reversed(FullA)):
#                    if not(FullA[i] == 0):
#                        if first:
#                            firstI = i
#                            first = False
#                        FullA[i] = FullA[i] - 1
#                        CSApar = CSApar + 1
#                if not(CSApar == 0):
#                    if level == 0:
#                       # input1 = INTERNAL_SIG % (self.tree[level][][].w, self.tree[level][][].w, self.self.tree[level][][].t)
#                        input2
#                        input3
#                        outS
#                        outC
#                        declarations.append(input1)
#                        declarations.append(input2)
#                        declarations.append(input3)
#                        declarations.append(outS)
#                        declarations.append(outC)
#                    print(CSA % (CSAindex, CSApar, input1, input2, input3, outS, outC))
#                    CSAindex = CSAindex + 1
#            HalfA = op[0]
#            while not(HalfA.count(0) == len(HalfA)):
#                for i, _ in enumerate(reversed(HalfA)):
#                    if not(HalfA[i] == 0):
#                        HalfA[i] = HalfA[i] - 1
#                        print(HA % (HAindex, "asd", "asd", "asd", "asd"))
#                        HAindex = HAindex + 1
#        

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
        name = u.INTERNAL_SIG %(level, i)
        dots = u.countDot(d.tree[level].matrix[:][i])
        if not(dots == 0):
            dec = u.SIGNAL %(name, u.SLV % dots)
            row.append(name)
            declarations.append(dec)
    signals.append(row)

#Sign extension

assignements = []
for i, aRow in enumerate(d.tree[0].matrix):
    inBit = []
    for aDot in aRow:
        if aDot.isSign():
            b = "S(" + str(aDot.w) + ")"
            inBit.append(b)
        elif aDot.isSignNeg():
            b = "not(S(" + str(aDot.w) + "))"
            inBit.append(b)
        elif aDot.isBlack():
            b = "PP(" + str(aDot.h) + ")" + "(" + str(aDot.w) + ")"
            inBit.append(b)
        elif aDot.isOne():
            b = "\'1\'"
            inBit.append(b)
    assignements.append(u.assign(signals[0][i], inBit))

with open("first.vhd", 'w') as of:
    for de in declarations:
        of.write(de + "\n")
    for ass in assignements:
        of.write(ass + "\n")

#Definition of operands

CSAtree = []
HAtree = []
for level in range(d.L):
    FullA = d.operators[level][1]
    h = 0
    while not(FullA.count(0) == len(FullA)):
        CSApar = 0
        first = True
        for i, _ in enumerate(reversed(FullA)):
            if not(FullA[i] == 0):
                if first:
                    firstI = i
                    first = False
                FullA[i] = FullA[i] - 1
                CSApar = CSApar + 1
        if not(CSApar == 0):
            input1 = u.downto(signals[level][h], firstI + CSApar, firstI)
            input2 = u.downto(signals[level][h + 1], firstI + CSApar, firstI)
            input3 = u.downto(signals[level][h + 2], firstI + CSApar, firstI)
            outS = u.downto(signals[level + 1][h - 2], firstI + CSApar, firstI)
            outC = u.downto(signals[level + 1][h - 1], firstI + CSApar - 1, firstI - 1)
            CSAtree.append(u.CSA % (CSAindex, CSApar, input1, input2, input3, outS, outC))
            with open("first.vhd", 'a') as of:
                of.write(u.CSA % (CSAindex, CSApar, input1, input2, input3, outS, outC) + '\n')
            CSAindex = CSAindex + 1
        h = h + 3
    HalfA = d.operators[level][0]
    while not(HalfA.count(0) == len(HalfA)):
        for i, _ in enumerate(reversed(HalfA)):
            if not(HalfA[i] == 0):
                HalfA[i] = HalfA[i] - 1
                HAtree.append(u.HA % (HAindex, "asd", "asd", "asd", "asd"))
                with open("first.vhd", 'a') as of:
                    of.write(u.HA % (HAindex, "asd", "asd", "asd", "asd") + '\n')
                HAindex = HAindex + 1
