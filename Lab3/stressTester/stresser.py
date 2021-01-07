with open("stress.s", 'w') as of:
    of.write("__start:\n")
    of.write("loop:	\nbeq x16,x0,done:\n")
    for i in range(1024):
        of.write("add x10,x10,x9")
        of.write("slt x11,x10,x13")
        of.write("beq x11,x0,loop")
