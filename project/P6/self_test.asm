.data

.text
lui $4, 0x9876
ori $4, $4, 0x5432
lui $6, 0xfedc
ori $6, $6, 0xba98
div $4, $6
mflo $7 # ??
mfhi $8 # ????

nop
nop
nop
nop

