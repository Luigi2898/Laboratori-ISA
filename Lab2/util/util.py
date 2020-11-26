import math as m
import numpy as np

#TODO: definire classe per gestire l'elemento della matrice (tipo di bit: punto, S, !S) ecc

class Dot:

    def __init__(self, typ, weight, value, one):
        self.t = typ
        self.w = weight
        self.v = value
        self.one = one
    
    def setBlack(self):
        self.v = 1

    def isBlack(self):
        return (self.v == 1)

    def __str__(self):
        return str(self.v)

    def __add__(self, other):
        return int(self.v + other.v)

    def __radd__(self, other):
        return int(self.v) + other


class Dadda:
    
    def __init__(self, height, parallelism): 
        self.L = 0
        self.l = []
        self.H = height
        self.P = parallelism
        self.W = parallelism * 2 - 1
        self.l.append(2)
        j = 0
        while self.l[j] < self.H:
            l_next = m.floor(3/2 * self.l[j])
            if not(l_next == self.l[j]):
                self.l.append(l_next)
                j = j + 1
        self.l = self.l[:-1]
        self.L = len(self.l)
        self.dotMatrix = []
        self.operators = np.zeros((self.L, 2, self.W)) # first row FA second row HA
        row = []
        for i in range(self.P):
            row.append(Dot("dot", 0, 1, 0))
        for i in range(0, self.W - self.P - 4):
            if i % 2 != 0:
                row.insert(i, Dot("one", 0, 1, 1))
            else :
                row.insert(i, Dot("!sign", 16 - int(i/2), 1, 0))
        row.insert(0, Dot("dot", 0, 0, 0))
        row.insert(self.W - self.P - 3, Dot("!sign", 0, 1, 0))
        row.insert(self.W - self.P - 2, Dot("sign", 0, 1, 0))
        row.insert(self.W - self.P - 1, Dot("sign", 0, 1, 0))
        self.dotMatrix.append(row)
        row = []
        row.append(Dot("dot", 0, 0, 0))
        for i in range(self.W - self.P - 4):
            row.append(Dot('dot', 0, 1, 0))
        row.append(Dot("!sign", 1, 1, 0))
        for i in range(self.P):
            row.append(Dot("dot", 0, 1, 0))
        row.append(Dot("dot", 0, 0, 0))
        row.append(Dot("sign", 0, 1, 0))
        self.dotMatrix.append(row)
        row = []
        for i in range(self.H - 3):
            for j in range(i*2 + 2):
                row.append(Dot("dot", 0, 0, 0))
            for j in range(i*2 + 2, self.W - 2*i - 4):
                row.append(Dot("dot", 0, 1, 0))
            row.append(Dot("dot", 0, 0, 0))
            row.append(Dot("sign", i + 1, 1, 0))
            for j in range(self.W - 2*i - 2, self.W):
                row.append(Dot("dot", 0, 0, 0))
            self.dotMatrix.append(row)
            row = []
        for i in range(29):
            row.append(Dot("dot", 0, 0, 0))
        for i in range(4):
            row.append(Dot("dot", 0, 1, 0))
        row.append(Dot("dot", 0, 0, 0))
        row.append(Dot("sign", self.H - 2, 1, 0))
        for i in range(30):
            row.append(Dot("dot", 0, 0, 0))
        self.dotMatrix.append(row)
        row = []

    def printMatrix(self, matrixToPrint):
        with open("out.txt", "w") as of:
            for row in matrixToPrint:
                for el in row:
                    of.write(el.__str__() + ' ')
                of.write('\n')
    
    def reductTree(self):
        for j in reversed(range(self.L)):
            reminder = 0
            for c in reversed(range(self.W)):
                if sum([sub[c] for sub in self.dotMatrix[:][:]]) + reminder > self.l[j]:
                    red = sum([sub[c] for sub in self.dotMatrix[:][:]]) + reminder - self.l[j]
                    FullAdder = int(red/2)
                    HalfAdder = int(red%2)
                    self.operators[j, 0, c] = FullAdder
                    self.operators[j, 1, c] = HalfAdder
                    reminder = FullAdder + HalfAdder
                    for aDot in [col[c] for col in self.dotMatrix[:][:]]:
                        if aDot.isBlack():
                            print(aDot)
                    print("C")


                


        
            

d = Dadda(17, 33)
d.reductTree()