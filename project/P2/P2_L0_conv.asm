.data
f: .space 400
h: .space 400
g: .space 400
stack: .space 100

.macro getindex(%ans, %i, %j, %rank)
	mult %i, %rank 
	mflo %ans
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.text
la $sp, stack
addiu $sp, $sp, 100

readInfo:
	li $v0, 5
	syscall
	move $s0, $v0									# $s0: fm
	li $v0, 5
	syscall
	move $s1, $v0									# $s1: fn
	li $v0, 5
	syscall
	move $s2, $v0									# $s2: hm
	li $v0, 5
	syscall
	move $s3, $v0									# $s3: hn
	
readMatrix:
	li $t0, 0
	for_fi_begin:									# read in f
	slt $t2, $t0, $s0
	beqz $t2, for_fi_end
	
		li $t1, 0
		for_fj_begin:
		slt $t2, $t1, $s1
		beqz $t2, for_fj_end
		
			li $v0, 5
			syscall
			getindex($t2, $t0, $t1, $s1)
			sw $v0, f($t2)
		
		addi $t1, $t1, 1
		j for_fj_begin
		for_fj_end:
	
	addi $t0, $t0, 1
	j for_fi_begin
	for_fi_end:
	
	
	li $t0, 0										# read in h
	for_hi_begin:
	slt $t2, $t0, $s2
	beqz $t2, for_hi_end
	
		li $t1, 0
		for_hj_begin:
		slt $t2, $t1, $s3
		beqz $t2, for_hj_end
		
			li $v0, 5
			syscall
			getindex($t2, $t0, $t1, $s3)
			sw $v0, h($t2)
		
		addi $t1, $t1, 1
		j for_hj_begin
		for_hj_end:
	
	addi $t0, $t0, 1
	j for_hi_begin
	for_hi_end:
	
# try to create the sense of calling a funtion
# let us suppose $s0, $s1, $s2, $s3 above are global variables so that they are visiable in the following function
# so while maintaining the variables and using the regiseters, we try not to use the $s0-$s3
# calGmatrix is not called by other funtion, so we donnot need to maintain $ra

calGmatrix:
addiu $sp, $sp, -8
	sub $t2, $s0, $s2
	addi $t2, $t2, 1
	move $s4, $t2									# $s4: gm
	sub $t2, $s1, $s3
	addi $t2, $t2, 1
	move $s5, $t2									# $s5: gn
	
	li $t0, 0
	for_gi_begin:
	slt $t2, $t0, $s4
	beqz $t2, for_gi_end
	
		li $t1, 0
		for_gj_begin:
		slt $t2, $t1, $s5
		beqz $t2, for_gj_end
		
			getindex($a0, $t0, $t1, $s1)
			sw $t1, 4($sp)
			sw $t0, 0($sp)
			jal doConvolution					
			lw $t0, 0($sp)
			lw $t1, 4($sp)	
			
			move $a0, $v1
			li $v0, 1
			syscall
			
			li $a0, 32
			li $v0, 11
			syscall
		
		addi $t1, $t1, 1
		j for_gj_begin
		for_gj_end:	
		
		li $a0, 10
		li $v0, 11
		syscall 
 
	addi $t0, $t0, 1
	j for_gi_begin
	for_gi_end: 
addiu $sp, $sp, 8

li $v0, 10
syscall
	
	
doConvolution:
addiu $sp, $sp, -8
sw $s4, 4($sp)
sw $s5, 0($sp)
move $s4, $a0

	li $s5, 0
	
	li $t0, 0
	for_coni_begin:
	slt $t2, $t0, $s2
	beqz $t2, for_coni_end
	
		li $t1, 0
		for_conj_begin:
		slt $t2, $t1, $s3
		beqz $t2, for_conj_end
		
			getindex($t2, $t0, $t1, $s1)
			add $t3, $t2, $s4					# offset($t2) from the former_offset($s4)
			lw $t8, f($t3)
			getindex($t2, $t0, $t1, $s3)
			lw $t9, h($t2)
			mult $t8, $t9
			mflo $t2
			add $s5, $s5, $t2
		
		addi $t1, $t1, 1
		j for_conj_begin
		for_conj_end:
	
	addi $t0, $t0, 1
	j for_coni_begin
	for_coni_end:

move $v1, $s5
lw $s5, 0($sp)
lw $s4, 4($sp) 
addiu $sp, $sp, 8
jr $ra

	
	
	
	
	
	
