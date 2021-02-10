import sys

filename = sys.argv[1]

with open(filename) as inf:
    lines = inf.readlines()

neF = []

for l in lines:
    opcode = l[-8:-1]
    func1 = l[17:20]
    if opcode == "0110111":
        neF.append("LUI")
    elif opcode == "0010111":
        neF.append("AUIPC")
    elif opcode == "1101111" and func1 == "000":
        neF.append("BEQ")
    elif opcode == "0110011" and func1 == "000":
        neF.append("ADD")
print(neF)

with open("decoded_" + filename, 'w') as of:
    for l in neF:
        of.write(l + "\n")
