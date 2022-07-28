ori $28, $0, 0
ori $29, $0, 0
lui $13, 21434
subu $13, $13, $30
ori $30, $0, 0
lw $30, 12($30)
j label1
ori $16, $0, 0
lw $13, 4($16)
addiu $30, $16, 0
label1: lui $30, 30311
jal label2
ori $16, $0, 16
ori $13, $30, 21518
label2: addu $16, $16, $31
jr $16
nop
addu $13, $30, $16
j label3
addiu $13, $30, 0
ori $13, $16, 57153
label3: ori $16, $30, 57624
addiu $13, $16, 0
lui $16, 10970
beq $30, $13, label4
addiu $30, $16, 0
lui $30, 64967
label4: ori $30, $0, 0
sw $30, 8($30)
subu $30, $30, $16
addiu $16, $30, 0
subu $13, $13, $13
jal label5
ori $16, $0, 16
lui $30, 21825
label5: addu $16, $16, $31
jalr $13, $16
nop
jal label6
ori $16, $0, 16
ori $16, $30, 26154
label6: addu $16, $16, $31
jalr $16, $16
nop
ori $16, $16, 36781
ori $16, $0, 0
sw $13, 0($16)
beq $16, $30, label7
subu $30, $30, $16
ori $13, $30, 54625
label7: lui $13, 12006
ori $16, $16, 16890
addu $16, $16, $30
j label8
lui $30, 62358
addiu $30, $13, 0
label8: addu $16, $16, $16
subu $13, $16, $13
jal label9
ori $30, $0, 16
subu $16, $16, $13
label9: addu $30, $30, $31
jalr $16, $30
nop
jal label10
ori $30, $0, 16
addiu $30, $16, 0
label10: addu $30, $30, $31
jr $30
nop
beq $13, $30, label11
ori $16, $0, 0
sw $30, 8($16)
subu $30, $13, $13
label11: lui $13, 40229
ori $13, $13, 45005
beq $16, $16, label12
lui $16, 6447
addu $13, $13, $16
label12: ori $30, $0, 0
sw $16, 4($30)
ori $16, $0, 0
sw $30, 8($16)
jal label13
ori $16, $0, 16
ori $16, $13, 38507
label13: addu $16, $16, $31
jr $16
nop
subu $13, $30, $16
ori $30, $0, 0
sw $30, 12($30)
jal label14
ori $13, $0, 16
lui $13, 39562
label14: addu $13, $13, $31
jalr $30, $13
nop
addu $13, $30, $30
ori $16, $0, 0
sw $30, 12($16)
jal label15
ori $16, $0, 16
subu $16, $30, $16
label15: addu $16, $16, $31
jr $16
nop
j label16
ori $30, $0, 0
lw $13, 12($30)
addu $30, $30, $16
label16: subu $30, $13, $16
ori $16, $0, 0
sw $16, 4($16)
ori $13, $30, 30951
beq $30, $30, label17
ori $30, $30, 20183
ori $30, $0, 0
sw $30, 0($30)
label17: ori $13, $13, 1968
lui $13, 4847
addiu $30, $13, 0
beq $30, $13, label18
ori $16, $0, 0
sw $13, 0($16)
addiu $13, $16, 0
label18: addu $16, $30, $13
addiu $30, $13, 0
ori $30, $0, 0
sw $13, 0($30)
addu $16, $30, $13
j label19
lui $16, 58031
addu $13, $16, $30
label19: ori $16, $0, 0
sw $30, 0($16)
jal label20
ori $30, $0, 16
addu $13, $13, $16
label20: addu $30, $30, $31
jalr $16, $30
nop
subu $13, $30, $16
j label21
ori $16, $0, 0
lw $13, 8($16)
ori $30, $0, 0
sw $30, 8($30)
label21: addiu $30, $30, 0
beq $16, $30, label22
addiu $13, $13, 0
addu $13, $30, $13
label22: addu $13, $13, $13
ori $13, $16, 30998
jal label23
ori $13, $0, 16
ori $30, $30, 58754
label23: addu $13, $13, $31
jr $13
nop
beq $13, $30, label24
lui $13, 29412
ori $13, $0, 0
sw $13, 4($13)
label24: lui $30, 42444
ori $16, $0, 0
sw $16, 4($16)
j label25
lui $13, 21700
ori $30, $16, 63062
label25: addu $30, $16, $30
ori $16, $0, 0
lw $16, 8($16)
addiu $13, $16, 0
ori $30, $16, 45810
beq $13, $30, label26
addu $30, $16, $30
subu $30, $30, $13
label26: addiu $16, $16, 0
subu $16, $13, $30
lui $30, 25523
subu $16, $30, $13
j label27
subu $16, $30, $13
lui $13, 16164
label27: ori $16, $16, 17800
beq $16, $16, label28
lui $16, 12551
lui $16, 38789
label28: addiu $13, $16, 0
addu $16, $13, $16
j label29
ori $13, $0, 0
sw $16, 0($13)
ori $13, $16, 30192
label29: ori $13, $0, 0
sw $30, 8($13)
subu $30, $13, $16
j label30
ori $16, $0, 0
lw $13, 12($16)
subu $16, $16, $13
label30: addiu $16, $13, 0
addiu $13, $16, 0
ori $30, $0, 0
sw $30, 4($30)
subu $30, $16, $16
ori $16, $0, 0
sw $13, 0($16)
jal label31
ori $13, $0, 16
subu $16, $16, $16
label31: addu $13, $13, $31
jalr $16, $13
nop
addiu $30, $13, 0
addu $13, $13, $13
jal label32
ori $13, $0, 16
ori $13, $30, 59141
label32: addu $13, $13, $31
jr $13
nop
subu $30, $30, $30
ori $13, $0, 0
lw $30, 12($13)
ori $13, $13, 52494
jal label33
ori $13, $0, 16
addu $30, $13, $30
label33: addu $13, $13, $31
jr $13
nop
ori $16, $0, 0
lw $13, 4($16)
jal label34
ori $30, $0, 16
addu $13, $13, $16
label34: addu $30, $30, $31
jr $30
nop
addu $16, $30, $16
addu $30, $30, $16
lui $13, 33120
addiu $16, $16, 0
lui $30, 39971
ori $16, $16, 47176
ori $13, $0, 0
sw $13, 4($13)
lui $16, 1095
ori $30, $0, 0
lw $13, 0($30)
ori $30, $30, 57960
jal label35
ori $30, $0, 16
addu $13, $30, $13
label35: addu $30, $30, $31
jalr $16, $30
nop
addu $30, $13, $30
ori $13, $30, 13018
ori $16, $16, 36807
addu $30, $16, $13
beq $16, $13, label36
ori $16, $16, 19639
lui $16, 37522
label36: ori $16, $13, 43928
addu $16, $30, $16
beq $13, $30, label37
ori $16, $30, 43028
ori $30, $0, 0
sw $13, 8($30)
label37: addiu $16, $13, 0
ori $16, $0, 0
sw $30, 8($16)
jal label38
ori $16, $0, 16
lui $16, 47522
label38: addu $16, $16, $31
jr $16
nop
jal label39
ori $30, $0, 16
ori $13, $30, 41599
label39: addu $30, $30, $31
jalr $30, $30
nop
addiu $30, $16, 0
subu $13, $13, $30
beq $13, $13, label40
subu $30, $16, $16
subu $16, $16, $30
label40: ori $30, $13, 24009
jal label41
ori $16, $0, 16
addu $30, $30, $13
label41: addu $16, $16, $31
jr $16
nop
jal label42
ori $16, $0, 16
lui $30, 45390
label42: addu $16, $16, $31
jalr $30, $16
nop
addiu $30, $30, 0
addiu $30, $16, 0
jal label43
ori $13, $0, 16
lui $30, 57601
label43: addu $13, $13, $31
jalr $13, $13
nop
addiu $16, $30, 0
beq $16, $13, label44
addiu $16, $30, 0
addiu $30, $13, 0
label44: addiu $30, $30, 0
ori $16, $16, 58357
j label45
ori $13, $0, 0
sw $13, 4($13)
addiu $16, $30, 0
label45: ori $13, $13, 11248
addiu $13, $13, 0
lui $13, 33337
ori $16, $0, 0
sw $30, 0($16)
ori $30, $16, 17851
j label46
addiu $13, $13, 0
ori $16, $0, 0
sw $30, 0($16)
label46: ori $16, $16, 23785
jal label47
ori $30, $0, 16
addiu $30, $16, 0
label47: addu $30, $30, $31
jr $30
nop
ori $30, $0, 0
sw $13, 0($30)
ori $30, $16, 12749
ori $30, $0, 0
lw $13, 4($30)
jal label48
ori $13, $0, 16
lui $16, 56339
label48: addu $13, $13, $31
jalr $13, $13
nop
ori $13, $0, 0
lw $16, 12($13)
addiu $30, $30, 0
addu $30, $30, $16
jal label49
ori $30, $0, 16
addiu $16, $13, 0
label49: addu $30, $30, $31
jalr $16, $30
nop
ori $30, $0, 0
lw $13, 12($30)
addu $16, $16, $13
subu $16, $16, $13
addiu $30, $13, 0
jal label50
ori $30, $0, 16
addiu $13, $30, 0
label50: addu $30, $30, $31
jalr $30, $30
nop
jal label51
ori $16, $0, 16
ori $13, $13, 24022
label51: addu $16, $16, $31
jalr $30, $16
nop
jal label52
ori $16, $0, 16
subu $13, $13, $13
label52: addu $16, $16, $31
jalr $30, $16
nop
subu $13, $13, $13
jal label53
ori $16, $0, 16
addu $16, $30, $13
label53: addu $16, $16, $31
jr $16
nop
addiu $30, $13, 0
ori $16, $13, 1829
lui $13, 46507
subu $30, $13, $13
ori $13, $0, 0
sw $30, 4($13)
ori $16, $0, 0
sw $13, 8($16)
ori $13, $30, 59630
ori $16, $0, 0
sw $16, 8($16)
j label54
addu $13, $30, $16
ori $16, $30, 13996
label54: lui $16, 52187
ori $16, $16, 57852
j label55
ori $16, $0, 0
sw $13, 0($16)
ori $16, $16, 8977
label55: addiu $30, $13, 0
addiu $13, $16, 0
j label56
lui $16, 62069
lui $30, 943
label56: lui $16, 31875
jal label57
ori $13, $0, 16
subu $13, $16, $30
label57: addu $13, $13, $31
jalr $16, $13
nop
addiu $13, $16, 0
ori $13, $16, 34127
jal label58
ori $16, $0, 16
subu $30, $30, $30
label58: addu $16, $16, $31
jalr $16, $16
nop
jal label59
ori $16, $0, 16
addu $16, $16, $16
label59: addu $16, $16, $31
jr $16
nop
subu $30, $30, $16
ori $13, $13, 17283
addiu $13, $16, 0
jal label60
ori $30, $0, 16
addiu $30, $13, 0
label60: addu $30, $30, $31
jr $30
nop
ori $30, $0, 0
lw $16, 4($30)
subu $16, $13, $16
j label61
subu $30, $30, $16
ori $16, $13, 40498
label61: ori $13, $16, 34920
beq $16, $13, label62
addu $13, $16, $13
ori $13, $0, 0
lw $16, 0($13)
label62: ori $16, $0, 0
sw $30, 0($16)
lui $16, 7561
jal label63
ori $13, $0, 16
ori $30, $30, 26809
label63: addu $13, $13, $31
jr $13
nop
ori $13, $0, 0
sw $30, 0($13)
addiu $13, $13, 0
ori $16, $0, 0
sw $30, 8($16)
ori $16, $0, 0
lw $16, 12($16)
addu $13, $13, $30
subu $30, $13, $16
jal label64
ori $16, $0, 16
addiu $13, $16, 0
label64: addu $16, $16, $31
jr $16
nop
j label65
ori $13, $0, 0
sw $16, 4($13)
ori $13, $0, 0
sw $13, 0($13)
label65: ori $30, $0, 0
lw $16, 8($30)
addiu $16, $13, 0
lui $16, 32198
ori $13, $16, 16084
ori $13, $0, 0
sw $30, 4($13)
subu $13, $13, $13
jal label66
ori $16, $0, 16
ori $30, $16, 35578
label66: addu $16, $16, $31
jr $16
nop
addiu $13, $16, 0
subu $13, $13, $16
addiu $16, $13, 0
j label67
lui $13, 26931
ori $16, $16, 6619
label67: ori $30, $16, 31602
jal label68
ori $13, $0, 16
subu $16, $13, $30
label68: addu $13, $13, $31
jr $13
nop
jal label69
ori $30, $0, 16
lui $13, 1677
label69: addu $30, $30, $31
jr $30
nop
lui $30, 64314
j label70
addiu $30, $16, 0
addu $13, $13, $16
label70: subu $16, $30, $13
ori $30, $0, 0
lw $30, 4($30)
ori $13, $0, 0
sw $30, 4($13)
jal label71
ori $16, $0, 16
lui $30, 7269
label71: addu $16, $16, $31
jalr $30, $16
nop
lui $13, 59146
addiu $16, $13, 0
addu $13, $30, $16
jal label72
ori $30, $0, 16
addu $30, $13, $30
label72: addu $30, $30, $31
jalr $16, $30
nop
lui $30, 5080
addiu $30, $13, 0
addu $13, $30, $13
lui $30, 26371
beq $30, $16, label73
ori $30, $13, 62479
ori $30, $0, 0
sw $13, 0($30)
label73: ori $16, $0, 0
sw $16, 12($16)
j label74
subu $16, $16, $16
ori $13, $30, 13116
label74: ori $16, $0, 0
lw $16, 4($16)
j label75
ori $13, $0, 0
sw $13, 0($13)
ori $16, $30, 30706
label75: addiu $30, $13, 0
addu $13, $16, $13
j label76
lui $13, 43245
addu $13, $13, $13
label76: ori $16, $0, 0
sw $16, 0($16)
j label77
ori $13, $0, 0
sw $16, 8($13)
ori $13, $0, 0
sw $16, 12($13)
label77: ori $13, $16, 50480
ori $16, $0, 0
sw $30, 4($16)
subu $16, $16, $13
ori $13, $0, 0
lw $16, 12($13)
addu $16, $30, $16
subu $30, $13, $16
jal label78
ori $30, $0, 16
addiu $30, $13, 0
label78: addu $30, $30, $31
jalr $16, $30
nop
beq $30, $13, label79
subu $16, $30, $13
addiu $30, $16, 0
label79: addiu $16, $16, 0
ori $16, $0, 0
sw $30, 4($16)
lui $13, 33244
ori $16, $0, 0
lw $30, 0($16)
ori $30, $0, 0
lw $30, 0($30)
lui $13, 4876
j label80
subu $16, $30, $16
addiu $16, $16, 0
label80: ori $16, $0, 0
lw $30, 12($16)
beq $30, $30, label81
lui $13, 33484
ori $16, $0, 0
lw $30, 12($16)
label81: ori $16, $0, 0
sw $30, 4($16)
ori $16, $13, 39501
j label82
addiu $13, $16, 0
ori $16, $16, 57712
label82: addu $16, $13, $13
j label83
ori $13, $16, 42698
ori $30, $13, 7246
label83: lui $16, 52279
jal label84
ori $13, $0, 16
ori $13, $13, 36863
label84: addu $13, $13, $31
jr $13
nop
subu $30, $13, $30
subu $13, $16, $16
jal label85
ori $30, $0, 16
subu $13, $16, $30
label85: addu $30, $30, $31
jr $30
nop
subu $16, $13, $16
j label86
ori $13, $0, 0
sw $13, 0($13)
addu $30, $13, $30
label86: subu $16, $30, $30
beq $30, $13, label87
addu $30, $30, $13
subu $30, $30, $13
label87: ori $30, $30, 33315
beq $16, $16, label88
ori $30, $0, 0
lw $13, 0($30)
subu $16, $30, $30
label88: ori $30, $0, 0
sw $16, 8($30)
ori $16, $13, 14853
subu $13, $16, $30
ori $16, $0, 0
sw $13, 12($16)
jal label89
ori $30, $0, 16
addiu $30, $30, 0
label89: addu $30, $30, $31
jalr $16, $30
nop
lui $13, 19163
jal label90
ori $30, $0, 16
addu $13, $13, $13
label90: addu $30, $30, $31
jalr $30, $30
nop
jal label91
ori $16, $0, 16
ori $16, $16, 17763
label91: addu $16, $16, $31
jr $16
nop
lui $13, 29110
subu $16, $16, $13
addu $30, $16, $16
lui $16, 63644
ori $16, $0, 0
lw $30, 12($16)
subu $30, $13, $30
addiu $30, $13, 0
ori $30, $0, 0
sw $16, 0($30)
ori $16, $13, 58524
addiu $13, $30, 0
addu $16, $30, $13
addu $30, $16, $30
lui $30, 28903
lui $13, 11606
addiu $16, $16, 0
lui $30, 54803
ori $16, $0, 0
lw $13, 0($16)
ori $13, $0, 0
lw $30, 0($13)
addu $13, $30, $16
jal label92
ori $13, $0, 16
ori $30, $30, 16072
label92: addu $13, $13, $31
jalr $16, $13
nop
ori $13, $30, 27121
subu $30, $30, $13
beq $13, $30, label93
lui $16, 5261
lui $16, 29139
label93: addu $16, $13, $30
addiu $30, $16, 0
beq $30, $13, label94
addu $13, $30, $13
ori $13, $0, 0
lw $13, 8($13)
label94: ori $16, $30, 25255
addu $30, $16, $16
ori $13, $0, 0
lw $13, 4($13)
lui $16, 39906
jal label95
ori $30, $0, 16
addu $30, $30, $30
label95: addu $30, $30, $31
jalr $13, $30
nop
beq $30, $30, label96
lui $30, 51130
ori $30, $0, 0
lw $16, 8($30)
label96: ori $13, $0, 0
sw $16, 8($13)
beq $16, $13, label97
ori $13, $0, 0
lw $13, 0($13)
lui $16, 5103
label97: ori $16, $0, 0
lw $13, 4($16)
jal label98
ori $16, $0, 16
lui $13, 10338
label98: addu $16, $16, $31
jalr $13, $16
nop
ori $13, $0, 0
lw $13, 4($13)
addiu $16, $13, 0
addu $16, $30, $16
jal label99
ori $16, $0, 16
addu $30, $13, $30
label99: addu $16, $16, $31
jr $16
nop
ori $30, $0, 0
lw $30, 0($30)
beq $16, $13, label100
lui $16, 2624
addu $16, $16, $16
label100: addu $16, $30, $13
jal label101
ori $30, $0, 16
ori $13, $30, 54209
label101: addu $30, $30, $31
jalr $30, $30
nop
beq $16, $16, label102
ori $16, $0, 0
sw $30, 12($16)
lui $13, 49557
label102: ori $16, $0, 0
lw $13, 8($16)
ori $13, $0, 0
sw $13, 4($13)
ori $13, $30, 40921
beq $13, $16, label103
lui $16, 8966
subu $13, $13, $16
label103: subu $16, $13, $30
addiu $30, $16, 0
jal label104
ori $13, $0, 16
subu $30, $30, $16
label104: addu $13, $13, $31
jr $13
nop
addiu $13, $13, 0
addu $16, $16, $30
ori $16, $13, 41889
ori $16, $0, 0
lw $13, 0($16)
ori $16, $16, 38678
jal label105
ori $30, $0, 16
subu $16, $13, $16
label105: addu $30, $30, $31
jr $30
nop
addiu $30, $16, 0
ori $16, $0, 0
lw $13, 12($16)
addu $16, $16, $13
subu $30, $30, $30
ori $13, $30, 60295
jal label106
ori $16, $0, 16
addu $13, $30, $30
label106: addu $16, $16, $31
jalr $30, $16
nop
jal label107
ori $30, $0, 16
addu $30, $30, $16
label107: addu $30, $30, $31
jalr $16, $30
nop
addiu $16, $13, 0
jal label108
ori $13, $0, 16
addiu $13, $13, 0
label108: addu $13, $13, $31
jalr $13, $13
nop
jal label109
ori $30, $0, 16
addiu $30, $16, 0
label109: addu $30, $30, $31
jalr $30, $30
nop
addu $13, $30, $16
jal label110
ori $13, $0, 16
lui $16, 9774
label110: addu $13, $13, $31
jr $13
nop
lui $30, 56111
ori $13, $13, 43275
jal label111
ori $30, $0, 16
lui $30, 33427
label111: addu $30, $30, $31
jalr $30, $30
nop
j label112
ori $13, $0, 0
sw $13, 4($13)
addiu $30, $16, 0
label112: subu $16, $30, $13
j label113
ori $13, $16, 42235
ori $13, $13, 4686
label113: lui $16, 49144
j label114
ori $13, $30, 53612
lui $16, 57410
label114: ori $13, $0, 0
sw $30, 0($13)
jal label115
ori $30, $0, 16
ori $16, $13, 18561
label115: addu $30, $30, $31
jr $30
nop
beq $16, $16, label116
addiu $30, $13, 0
lui $13, 60814
label116: ori $13, $30, 7713
addiu $16, $13, 0
addiu $30, $16, 0
ori $16, $13, 35928
ori $30, $0, 0
sw $30, 12($30)
lui $13, 61360
ori $16, $0, 0
sw $13, 4($16)
j label117
lui $13, 21438
ori $13, $0, 0
lw $30, 0($13)
label117: addiu $30, $13, 0
jal label118
ori $13, $0, 16
subu $13, $30, $16
label118: addu $13, $13, $31
jr $13
nop
lui $16, 1158
lui $16, 62395
ori $13, $0, 0
sw $16, 0($13)
lui $30, 48790
jal label119
ori $30, $0, 16
subu $30, $16, $30
label119: addu $30, $30, $31
jr $30
nop
lui $13, 8696
ori $30, $0, 0
lw $30, 12($30)
lui $30, 59507
lui $13, 33305
addiu $30, $30, 0
j label120
lui $13, 33938
ori $13, $0, 0
sw $16, 8($13)
label120: subu $16, $30, $13
addiu $13, $16, 0
ori $13, $0, 0
lw $16, 4($13)
ori $30, $0, 0
lw $30, 0($30)
addiu $16, $30, 0
addu $16, $16, $30
lui $30, 3842
addu $16, $16, $16
lui $30, 42004
beq $13, $30, label121
ori $30, $30, 43837
ori $13, $0, 0
lw $13, 8($13)
label121: ori $30, $0, 0
sw $16, 0($30)
jal label122
ori $16, $0, 16
ori $16, $30, 1498
label122: addu $16, $16, $31
jr $16
nop
addu $13, $13, $13
ori $16, $0, 0
lw $30, 8($16)
addiu $13, $13, 0
addu $30, $13, $16
ori $13, $16, 14349
jal label123
ori $30, $0, 16
ori $30, $16, 20254
label123: addu $30, $30, $31
jalr $30, $30
nop
beq $16, $30, label124
ori $30, $0, 0
sw $30, 0($30)
subu $13, $13, $16
label124: addiu $30, $13, 0
ori $30, $16, 4295
lui $30, 25069
lui $30, 25448
ori $30, $0, 0
sw $16, 8($30)
addiu $13, $13, 0
addiu $30, $13, 0
ori $13, $13, 48880
j label125
ori $16, $16, 61291
ori $16, $30, 45464
label125: ori $13, $0, 0
sw $30, 12($13)
ori $30, $13, 14851
ori $30, $0, 0
lw $13, 0($30)
ori $13, $0, 0
sw $30, 4($13)
