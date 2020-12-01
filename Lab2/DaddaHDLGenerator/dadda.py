from util import Dadda

#            self.printMatrix(self.tree[i - self.L].matrix)
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
with open("outGG.txt", 'w') as of:
    pass
for el in d.tree:
    d.printMatrix(el.matrix)
for op in d.operators:
    print(op)