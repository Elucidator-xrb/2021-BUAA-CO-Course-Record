.data

.text
lui $4, 0x9876
ori $4, $4, 0x5432
lui $6, 0xfedc
ori $6, $6, 0xba98
div $4, $5
mflo $7 # ษฬ
mfhi $8 # ำเสý

nop
nop
nop
nop

this: j this
nop