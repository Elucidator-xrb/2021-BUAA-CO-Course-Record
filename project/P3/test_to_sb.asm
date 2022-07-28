ori $s0, $0, 0x1234
lui $s1, 0x5678
ori $s2, $s1, 0x1234

ori $t0, $0, 0
sw $s2, 0($t0)
loop:
sh $s2, 4($t0)
sh $s2, 6($t0)

sb $s2, 8($t0)
sb $s2, 9($t0)

j loop

lb $t1, 0($t0)
lb $t2, 1($t0)
lb $t3, 2($t0)
lb $t4, 3($t0)
lb $t5, 4($t0)
lb $t6, 5($t0)