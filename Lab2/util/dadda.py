import math


num = range(17)
with open('out.txt', 'w') as of:
    for i in num:
        ran = range(35 * i, 35 * i + 35)
        for j in range(16 - i):
            of.write('\t')
        for j in ran.__reversed__():
            of.write('*' + '\t')
        of.write('\n')


l = []
l.append(2)
j = 0

while l[j] < 17:
    l.append(math.floor((3/2) * l[j-1]))
    j = j + 1

print("L = ", l.__len__() - 1)
print(l[0:-1])