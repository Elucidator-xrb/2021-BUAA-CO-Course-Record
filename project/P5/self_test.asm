ori $t1, $0, 1
lui $t2, 0xffff
ori $t2, $t2, 0xffff
bgezal $t1, label1
nop
label1:
bgezal $t2, label2
sw $31, 4($0)
addu $t2, $t2, $t2
addu $t2, $t2, $t2
label2:
lw $31, 4($0)
ori $20, $0, 0
bgezal $20, label3
sw $31, 0($0)
label3:
subu $9, $t1, $31



