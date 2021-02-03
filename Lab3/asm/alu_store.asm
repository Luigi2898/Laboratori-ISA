li x8, 88 # x8 = 88
li x3, 8196  # x3 = 8195 
srai x5, x8, 9
andi x9, x8, 89
xor x11, x9, x5
slt x15, x8, x5
sw x11, 8(x3) # 
