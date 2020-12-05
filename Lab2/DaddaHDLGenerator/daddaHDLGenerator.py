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
    PP1      : in  std_logic_vector (N downto 0);
    PP2      : in  std_logic_vector (N downto 0);
    PP3      : in  std_logic_vector (N downto 0);
    PP4      : in  std_logic_vector (N downto 0);
    PP5      : in  std_logic_vector (N downto 0);
    PP6      : in  std_logic_vector (N downto 0);
    PP7      : in  std_logic_vector (N downto 0);
    PP8      : in  std_logic_vector (N downto 0);
    PP9      : in  std_logic_vector (N downto 0);
    PP10     : in  std_logic_vector (N downto 0);
    PP11     : in  std_logic_vector (N downto 0);
    PP12     : in  std_logic_vector (N downto 0);
    PP13     : in  std_logic_vector (N downto 0);
    PP14     : in  std_logic_vector (N downto 0);
    PP15     : in  std_logic_vector (N downto 0);
    PP16     : in  std_logic_vector (N downto 0);
    PP17     : in  std_logic_vector (N downto 0);
    PP_sign : in  std_logic_vector (N / 2 downto 0);
    SUM     : out std_logic_vector (2 * N - 1 downto 0)
  ) ;
end DADDA;

architecture structural of DADDA is
  
  component FA IS
    port(
		A, B, Cin : IN STD_LOGIC;
		S, Co : OUT STD_LOGIC
	);	
  end component FA;

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
        sig = u.INTERNAL_SIG %(level, i)
        dots = u.countDot(d.tree[level].matrix[:][i])
        if not(dots == 0):
            dec = u.SIGNAL %(sig, u.SLV % (65 - 1))
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
    assignements.append(u.assign(signals[0][i], inBit))

with open("DADDA.vhd", 'a') as of:
    of.write("\nbegin\n\n")
    for ass in assignements:
        of.write(ass + "\n")
    of.write("\n\n")

#Definition of operands

FAindex = 0
HAindex = 0
for level in range(d.L):
    FullA = reversed(d.operators[level][1])
    HalfA = reversed(d.operators[level][0])
    i = 0
    for fA, hA in zip(FullA, HalfA):
        i += 1
        if fA != 0:
            for j in range(fA):
                i1 = u.downto(signals[level][3 * j], i, i)
                i2 = u.downto(signals[level][3 * j + 1], i, i)
                i3 = u.downto(signals[level][3 * j + 2], i, i)
                os = u.downto(signals[level + 1][j // 3], i, i)
                oc = u.downto(signals[level + 1][j // 3 + 1], i + 1, i + 1)
                with open("DADDA.vhd", 'a') as of:
                    of.write(u.FA % (FAindex, i1, i2, i3, os, oc) + '\n')
                FAindex += 1
        if hA != 0:
            for j in range(hA):
                i1 = u.downto(signals[level][3 * j + 3 * fA], i, i)
                i2 = u.downto(signals[level][3 * j + 1 + 3 * fA], i, i)
                os = u.downto(signals[level + 1][j // 3 + fA], i, i)
                oc = u.downto(signals[level + 1][j // 3 + 1 + fA], i + 1, i + 1)
                with open("DADDA.vhd", 'a') as of:
                    of.write(u.HA % (HAindex, i1, i2, os, oc) + '\n')
                HAindex += 1
        
            
            


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
    of.write("\n\nend architecture ;")