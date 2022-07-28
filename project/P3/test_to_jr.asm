ori $t0, $0, 123
ori $t1, $0, 125
subu $t2, $t1, $t0

ori $s0, $0, 0
ori $t3, $0, 2
loop:
addu $s0, $s0, $t3
beq $s0, $t2, loop

ori $v0, $v0, 0
lui $a0, 1
jal no_fun
sw $a0, 0($v0)


no_fun:
sw $a0, 4($v0)
jr $ra

