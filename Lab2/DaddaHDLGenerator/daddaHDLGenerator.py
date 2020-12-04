from util import Dadda
import util as u
from copy import deepcopy

with open("DADDA.vhd", 'w') as of:
    of.write("""library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.array_std.all;


entity DADDA is
  generic(N : integer := 32; N_PP : integer := 17);
  port (
    PP      : in  PP_array;
    PP_sign : in  std_logic_vector (N / 2 downto 0);
    SUM     : out std_logic_vector (2 * N - 1 downto 0)
  ) ;
end DADDA;

architecture structural of DADDA is
  
  component CSA is
    generic (N : integer := 32);
      port (
          IN0 : in  std_logic_vector (N-1 downto 0);
          IN1 : in  std_logic_vector (N-1 downto 0);
          IN2 : in  std_logic_vector (N-1 downto 0);
          S   : out std_logic_vector (N-1 downto 0);
          C   : out std_logic_vector (N-1 downto 0)
      );
  end component CSA;

  component HA is
    port(
		    A, B  : in  std_logic;
		    S, Co : out std_logic
    );
  end component HA;\n\n""")

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
        sig = u.signal()
        sig.setName(u.INTERNAL_SIG %(level, i))
        dots = u.countDot(d.tree[level].matrix[:][i])
        start = d.tree[level].getFirstNonEmpty(i)
        sig.setStart(start)
        if not(dots == 0):
            sig.setPar(dots)
            dec = u.SIGNAL %(sig.name, u.SLV % (sig.p - 1))
            row.append(deepcopy(sig))
            declarations.append(dec)
    signals.append(row)

#Sign extension

assignements = []
for i, aRow in enumerate(d.tree[0].matrix):
    inBit = []
    for aDot in aRow:
        if aDot.isSign():
            b = "PP_sign(" + str(aDot.w) + ")"
            inBit.append(b)
        elif aDot.isSignNeg():
            b = "not(PP_sign(" + str(aDot.w) + "))"
            inBit.append(b)
        elif aDot.isBlack():
            b = "PP(" + str(aDot.h) + ")" + "(" + str(aDot.w) + ")"
            inBit.append(b)
        elif aDot.isOne():
            b = "\'1\'"
            inBit.append(b)
    assignements.append(u.assign(signals[0][i].name, inBit))

with open("DADDA.vhd", 'a') as of:
    of.write("\nbegin\n\n")
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
            input1 = u.downto(signals[level][h].name, signals[level][h].downto(firstI, CSApar))
            input2 = u.downto(signals[level][h + 1].name, signals[level][h + 1].downto(firstI, CSApar))
            input3 = u.downto(signals[level][h + 2].name, signals[level][h + 2].downto(firstI, CSApar))
            outS = u.downto(signals[level + 1][h // 3].name, signals[level + 1][h // 3].downto(firstI, CSApar))
            outC = u.downto(signals[level + 1][h // 3 + 1].name, signals[level + 1][h // 3 + 1].downto(firstI - 1, CSApar))
            CSAtree.append(u.CSA % (CSAindex, CSApar + 1, input1, input2, input3, outS, outC))
            with open("DADDA.vhd", 'a') as of:
                of.write(u.CSA % (CSAindex, CSApar + 1, input1, input2, input3, outS, outC) + '\n')
            CSAindex = CSAindex + 1
        h = h + 3
    HalfA = d.operators[level][0]
    h = 0
    while not(HalfA.count(0) == len(HalfA)):
        for i, _ in enumerate(reversed(HalfA)):
            if not(HalfA[i] == 0):
                HalfA[i] = HalfA[i] - 1
                input1 = u.downto(signals[level][h].name, (i, i))
                input2 = u.downto(signals[level][h + 1].name, (i, i))
                outS = u.downto(signals[level + 1][h // 3].name, (abs(i - signals[level + 1][h // 3].start), abs(i - signals[level + 1][h // 3].start)))
                outC = u.downto(signals[level + 1][h // 3 + 1].name, (abs(i - 1 - signals[level + 1][h // 3 + 1].start), abs(i - 1 - signals[level + 1][h // 3 + 1].start)))
                HAtree.append(u.HA % (HAindex, input1, input2, outS, outC))
                with open("DADDA.vhd", 'a') as of:
                    of.write(u.HA % (HAindex, input1, input2, outS, outC) + '\n')
                HAindex = HAindex + 1

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
    of.write("\n\nend architecture ;")