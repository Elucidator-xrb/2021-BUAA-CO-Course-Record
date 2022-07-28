.data
IsUsed: .space 100
Array: .space 100
stack: .space 500

.text
la $sp, stack
addiu $sp, $sp, 1000

main:
	li $v0, 5
	syscall
	move $s0, $v0											# $s0: N   	(Global)

	li $a0, 0
	jal fullPermutation
	
li $v0, 10
syscall


fullPermutation:
addiu $sp, $sp, -12
sw $s1, 8($sp)
move $s1, $a0												# $s1: index	(fullPermutation)	
	
	if_need_print_begin:
	 sge $t0, $s1, $s0
	 beqz $t0, if_need_print_end
		
		li $t0, 0
		for_print_begin:
		slt $t1, $t0, $s0
		beqz $t1, for_print_end
		
			sll $t2, $t0, 2
			lw $a0, Array($t2)
			li $v0, 1
			syscall
			
			li $a0, 32
			li $v0, 11
			syscall 
		
		addi $t0, $t0, 1
		j for_print_begin 
		for_print_end:
		
		li $a0, 10
		li $v0, 11
		syscall
		
		j return
		
	if_need_print_end:
	
	li $t0, 0
	for_next_permutation_begin:
	slt $t1, $t0, $s0
	beqz $t1, for_next_permutation_end
	
		if_isUsed_begin:
		sll $t2, $t0, 2
		lw $t3, IsUsed($t2)
		bnez $t3, if_isUsed_end
								# $t0: i
			addi $t1, $t0, 1		# $t1: i+1
			sll $t2, $s1, 2		# $t2: 4*index 	addr of Array[index]
			sll $t3, $t0, 2		# $t3: 4*i	 	addr of IsUsed[i]
			sw $t1, Array($t2)
			li $t4, 1
			sw $t4, IsUsed($t3)
			
			addi $a0, $s1, 1
			
			sw $t0, 4($sp)
			sw $ra, 0($sp)
			jal fullPermutation
			lw $ra, 0($sp)
			lw $t0, 4($sp)
			
			sll $t3, $t0, 2		# $t3: 4*i
			li $t4, 0
			sw $t4, IsUsed($t3)
		
		if_isUsed_end:
	
	addi $t0, $t0, 1
	j for_next_permutation_begin
	for_next_permutation_end:

return:	
lw $s1, 8($sp)
addiu $sp, $sp, 12
jr $ra
	
