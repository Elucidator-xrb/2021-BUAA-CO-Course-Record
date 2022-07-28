.data
a: .space 128

.text
# int n = 32;
# a[0] = 0£¬ a[1] = 1;
# for(int i = 8; i < 128; i+=4)
# a[i] = a[i-1] + a[i-2]

lui $s0, 0
ori $s0, 128 # s0 = n

lui $a0, 0
sw $0, a($a0) # a[0] = 0

lui $s1, 0
ori $s1, 1 # s1 === 1

lui $s2, 0
ori $s2, 4 # s2 === 4

ori $a0, 4
sw $s1, a($a0) # a[1] = 1

lui $t0, 0
ori $t0, 8

for:
	beq $t0, $s0, endfor
	nop
	
	subu $t1, $t0, $s2  # t1 = i-1
	subu $t2, $t1, $s2  # t2 = i-2
	
	lw $t3, a($t1) # t3 = a[i-1]
	lw $t4, a($t2) # t4 = a[i-2]
	
	addu $t5, $t3, $t4
	
	sw $t5, a($t0)
	
	addu $t0, $t0, $s2
	beq $0, $0, for
	nop
endfor:

this: beq $0, $0, this
nop