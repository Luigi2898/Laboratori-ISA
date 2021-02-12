import sys
import random

with open(sys.argv[1], 'r') as inf:
    inlines = inf.readlines()

for i, l in enumerate(inlines):
    if 'v:' in l:
        for j in range(int(sys.argv[2])):
            inlines.insert(i + 1, f'    .word  {random.randint(-25,25)}' + '\n')
    if '__start:' in l:
        inlines[i + 1] = f'    li x16,{sys.argv[2]}          # put {sys.argv[2]} in x16   ' + '\n'
        break

with open(sys.argv[1], 'w') as of:
    for l in inlines:
        of.write(l)
