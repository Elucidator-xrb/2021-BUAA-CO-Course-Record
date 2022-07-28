ori $4,$0,104
ori $2,$0,23
ori $7,$0,22
ori $24,$0,121
ori $20,$0,44
ori $21,$0,83
ori $27,$0,98
ori $23,$0,85
ori $12,$0,62
ori $15,$0,6
sb $20,24($2)
sw $7,-88($4)
sb $27,8($7)
sb $20,-63($4)
lw $9,18($7)
beq $3,$20,branch2
jal branch3
branch3:
lui $5,32815
sh $2,31($24)
beq $4,$16,branch4
lh $17,82($4)
lb $14,-30($20)
beq $0,$12,branch5
sh $0,141($23)
lui $5,30807
jal branch6
addu $10,$21,$8
lb $8,-101($24)
addu $8,$2,$12
addu $9,$24,$15
jal branch8
addu $22,$18,$25
beq $12,$27,branch9
beq $15,$19,branch10
lw $8,22($7)
beq $22,$25,branch11
nop
j branch12
sb $2,-33($20)
branch5:
sw $26,258($27)
branch9:
j branch13
branch11:
subu $6,$11,$27
addu $14,$6,$19
sw $10,31($23)
branch6:
branch13:
lh $10,44($27)
branch14:
addu $25,$21,$14
sh $11,102($15)
branch1:
lui $8,40234
nop
jal branch16
sw $3,342($12)
branch2:
branch12:
sh $25,93($24)
branch8:
jal branch18
sb $0,16($27)
branch10:
branch17:
j branch19
jal branch21
branch18:
j branch22
branch19:
addu $18,$25,$9
branch15:
branch22:
sh $19,-13($21)
sh $23,174($12)
sw $10,237($21)
sw $25,218($12)
lh $5,-27($24)
nop
branch7:
branch16:
nop
j branch23
sh $3,124($4)
branch20:
lb $9,48($12)
branch4:
lh $26,-1($2)
beq $19,$0,branch24
branch23:
branch24:
branch25:
subu $17,$20,$25
branch21:
lb $14,-21($7)
