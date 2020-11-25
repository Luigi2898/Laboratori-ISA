import math as m
import numpy as np

class Dadda:
    
    def __init__(self, height, parallelism): 
        self.L = 0
        self.l = []
        self.H = height
        self.dotMatrix = np.zeros((height, parallelism * 2 + 2))
        self.P = parallelism
        self.l.append(2)
        j = 0
        while self.l[j] < self.H:
            l_next = m.floor(3/2 * self.l[j])
            if not(l_next == self.l[j]):
                self.l.append(l_next)
                j = j + 1
        self.l = self.l[:-1]
        self.L = len(self.l)
        print(self.dotMatrix)
            

d = Dadda(17, 33)
