ori $t0, $0, 2
ori $t1, $0, 5
sll $t2, $t0, 5
bgtz $t0, loop

# beq
# bne
bgez $t0, loop
bgtz $t0, loop
blez $t0, loop
bltz $t0, loop

loop: 