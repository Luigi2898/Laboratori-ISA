import math as m
import numpy as np
from copy import deepcopy


CSA          = "CSA_%d : CSA generic map(%d)\n            port map(%s, %s, %s, %s, %s);"
HA           = "HA_%d : HA port map(%s, %s, %s, %s);"
SIGNAL       = "signal %s : %s"
SLV          = "std_logic_vector(%d downto 0);"
STDL         = "std_logic;"
PP_EXT       = "PP_ext(%d)(%s)"
INTERNAL_SIG = "internal_%d_%d"
PP           = "PP(%d)(%s)"

def countDot(list):
    cnt = 0
    for aDot in list:
        if aDot == 1:
            cnt += 1
    return cnt

def assign(target, source):
    assignement = target + ' <= '
    for i, aPiece in enumerate(source):
        if i == len(source) - 1:
            assignement = assignement + aPiece + ' ;'
        else:
            assignement = assignement + aPiece + ' & '
    return assignement

def downto(signal, r):
    if r[0] == r[1]:
        signal_dt = signal + "( " + str(r[0]) + " )"
    else:
        signal_dt = signal + "( " + str(r[0]) + " downto " + str(r[1]) + " )"
    return signal_dt

class DotMatrix:

    def __init__(self, W = None, H = None, matrix = None):
        
        if matrix == None:
            self.matrix = []
            self.W = W
            self.H = H
            for _ in range(H):
                row = []
                for _ in range(W):
                    d = Dot()
                    row.append(d)
                self.matrix.append(row)
        else:
            self.matrix = matrix
            self.H = len(matrix[:][:])
            self.W = len(matrix[0][:])

    def populate(self, parallelism):
        #signals = []
       # ass = []
        for i, aDot in enumerate(reversed(self.matrix[0][self.W - parallelism : self.W])):
            aDot.setBlack( i, 0)
        #row = "PP(0)"
        self.matrix[0][self.W - parallelism - 1].setSign(0)
        #row = "S(0) & " + row 
        self.matrix[0][self.W - parallelism - 2].setSign(0)
       # row = "S(0) & " + row
        self.matrix[0][self.W - parallelism - 3].setSignNeg(0)
        #row = "not(S(0)) & " + row
        #signals.append(deepcopy(row))
        for pos, row in enumerate(self.matrix[1:-2][:]):
            i = 0
            for index, aDot in enumerate(reversed(row)):
                if index == 2 * (pos + 1) - 2:
                    aDot.setSign(pos)
                if index >= 2 * (pos + 1) and index < 2 * (pos + 1) + parallelism:
                    aDot.setBlack( i,pos + 1)
                    i = i + 1
                if index == 2 * (pos + 1) + parallelism:
                    aDot.setSignNeg(pos + 1)
                if index == 2 * (pos + 1) + parallelism + 1:
                    aDot.setOne(pos + 1)
        for index, aDot in enumerate(self.matrix[-2][2 : parallelism + 2]):
            aDot.setBlack( index, self.H - 2)
        self.matrix[-2][parallelism + 3].setSign(self.H - 3)
        self.matrix[-2][1].setOne(self.H - 2)
        for index, aDot in enumerate(self.matrix[-1][1 : parallelism]):
            aDot.setBlack( index, self.H - 1)
        self.matrix[-1][parallelism + 1].setSign(self.H - 1)

    def reduct(self, lTarget):
        nextLevel = deepcopy(self)
        operators = [[0] * (self.W - 1), [0] * (self.W - 1)]
        reminder = 0
        for c in reversed(range(self.W)):
            col = [row[c] for row in nextLevel.matrix]
            if sum(col) + reminder > lTarget:
                red = (sum(col) + reminder) - lTarget
                HalfAdders = int(red % 2)
                FullAdders = int(red / 2)
                operators[0][c] =  HalfAdders
                operators[1][c] = FullAdders
                reminder = HalfAdders + FullAdders
                toDel = sum(col) - lTarget
                if toDel > 0:
                    deleted = 0
                    for aDot in col:
                        if aDot.isPresent():
                            aDot.setEmpty()
                            deleted = deleted + 1
                            if deleted == toDel:
                                break
        return nextLevel, operators

    def compress(self):
        for c in range(self.W):
            col = [row[c] for row in self.matrix]
            col = sorted(col ,reverse=True)
            for i, el in enumerate(col):
                self.matrix[i][c] = el

    def getFirstNonEmpty(self, row):
        for i, aDot in enumerate(reversed(self.matrix[:][row])):
            if aDot.isBlack():
                return i

class Dot:

    def __init__(self):
        self.t = "none"
        self.w = 0
        self.v = 0
        self.one = 0
        self.h = 0
    
    def setBlack(self, w, h):
        self.t = "dot"
        self.w = w
        self.v = 1
        self.one = 0
        self.h = h

    def setOne(self, w):
        self.t = "one"
        self.w = w
        self.v = 1
        self.one = 1
    
    def setWhite(self, w):
        self.t = "none"
        self.w = w
        self.v = 0
        self.one = 0
    
    def setSign(self, w):
        self.t = "sign"
        self.w = w
        self.v = 1
        self.one = 0

    def setSignNeg(self, w):
        self.t = "!sign"
        self.w = w
        self.v = 1
        self.one = 0

    def setEmpty(self):
        self.t = "none"
        self.w = 0
        self.v = 0
        self.one = 0

    def isPresent(self):
        return (self.v == 1)

    def isOne(self):
        return self.t == "one"

    def isSign(self):
        return self.t == "sign"

    def isSignNeg(self):
        return self.t == "!sign"

    def isEmpty(self):
        return self.t == "none"

    def isBlack(self):
        return self.t == "dot"

    def setCarry(self):
        self.t = "carry"
        self.w = 0
        self.v = 1
        self.one = 0

    def __str__(self):
        return str(self.v)

    def __add__(self, other):
        return int(self.v + other.v)

    def __radd__(self, other):
        return int(self.v) + other

    def __gt__(self, other):
        return(self.v > other.v)
    
    def __eq__(self, other):
        if isinstance(other, Dot):
            return self.v == other.v
        else:
            return self.v == other

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
        dotMatrix = DotMatrix(W=self.W, H=self.H)
        dotMatrix.populate(self.P)
        dotMatrix.compress()
        self.tree = [dotMatrix]
        self.operators = [] # first row FA second row HA
        
    def printMatrix(self, matrixToPrint, of):
        for row in matrixToPrint:
            for el in row:
                of.write(el.__str__() + ',')
            of.write('\n')
        of.write("2,")
        for _ in range(len(row)-1):
            of.write('0,')
        of.write('\n')
    
    def reductTree(self):
        for i in range(1, self.L + 1):
            nl, op = self.tree[i - 1].reduct(self.l[self.L - i])
            nl.compress()
            self.tree.append(nl)
            self.operators.append(op.copy())
            
class signal():
    
    def __init__(self):
        self.start = 0
        self.name = ""
        self.p = 0
    
    def setName(self, name):

        self.name = name

    def setPar(self, par):

        self.p = par

    def setStart(self, start):
        self.start = start

    def downto(self, offset, bit):
        start = offset - self.start
        if start < 0:
            end = offset + bit - self.start - start
            start = 0
        else:
            end = offset + bit - self.start

        return (end, start)


    
        
                


        
            

