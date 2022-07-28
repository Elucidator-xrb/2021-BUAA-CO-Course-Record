li $t0, -1
li $t0, -1
beqz $t1, label
nop
label:

mfc0 $k0, $14
move $s2, $0

addi $t1, $t1, 0x100
ori $t1, $t1, 0x10000
beq $t1, 1, label