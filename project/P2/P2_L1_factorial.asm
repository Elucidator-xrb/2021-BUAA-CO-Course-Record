.data
ans: .space 10000

.text

li $v0, 5
syscall
move $s0, $v0								# $s0: N
li $s1, 0									# $s1: len
li $t0, 1
sw $t0, ans($0)							# ans[0] = 1

li $t0, 2									# $t0: num
for_num_begin:
bgt $t0, $s0, for_num_end

	li $t1, 0								# $t1: i
	for_mult_begin:
	bgt $t1, $s1, for_mult_end
	
		sll $t2, $t1, 2
		lw $t3, ans($t2)
		mult $t0, $t3
		mflo $t3
		sw $t3, ans($t2)
	
	addi $t1, $t1, 1
	j for_mult_begin
	for_mult_end:
	
	li $t1, 0								# $t1: i
	for_carry_begin:
	bgt $t1, $s1, for_carry_end
	
		sll $t2, $t1, 2		# $t2: i*4
		lw $t3, ans($t2)		# $t3: ans[i]
		li $t4, 10
		div $t3, $t4
		mflo $t8				# $t8: ans[i]/10
		mfhi $t9				# $t9: ans[i]%10
		sw $t9, ans($t2)		# ans[i] = ans[i]%10
		
		if_extend_begin:
			beqz $t8, if_extend_end
			
			addi $t4, $t2, 4	# $t4: (i+1)*4
			lw $t5, ans($t4)	# $t5: ans[i+1]
			add $t5, $t5, $t8
			sw $t5, ans($t4)
			
			bne $t1, $s1, if_extend_end
				addi $s1, $s1, 1
		if_extend_end:
	
	addi $t1, $t1, 1
	j for_carry_begin
	for_carry_end:

addi $t0, $t0, 1
j for_num_begin
for_num_end:

move $t0, $s1
for_print_begin:
blt $t0, $0, for_print_end

	sll $t2, $t0, 2
	lw $a0, ans($t2)
	li $v0, 1
	syscall

addi $t0, $t0, -1
j for_print_begin
for_print_end:

li $v0, 10
syscall
