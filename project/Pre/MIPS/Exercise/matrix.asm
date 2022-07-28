.data


.text
li $v0, 5
syscall
move $s0, $v0					# $s0: n
li $v0, 5
syscall
move $s1, $v0						# $s1: m

li $s2, 0							# $s2: cur_address
li $t0, 1							# $t0: i in for_i_n()
for_i_n_begin:
	sgt $t2, $t0, $s0
	bnez $t2, for_i_n_end
	
	li $t1, 1						# $t1: j in for_j_m()
	for_j_m_begin:
		sgt $t2, $t1, $s1
		bnez $t2, for_j_m_end
	
		li $v0, 5
		syscall
		beqz $v0, if_not_zero_end
		if_not_zero_begin:
			sw $t0, 0($s2)
			sw $t1, 4($s2)
			sw $v0, 8($s2)
			addiu $s2, $s2, 12
		if_not_zero_end:
	
		addi $t1, $t1, 1
		j for_j_m_begin
	for_j_m_end:
	
	addi $t0, $t0, 1
	j for_i_n_begin
for_i_n_end:

for_address_back_begin:
	beqz $s2, for_address_back_end
	
	addiu $s2, $s2, -12
	
	lw $a0, 0($s2)
	li $v0, 1
	syscall
	  li $a0, 32   # print space
	  li $v0, 11
	  syscall
	lw $a0, 4($s2)
	li $v0, 1
	syscall
	  li $a0, 32	# print space
	  li $v0, 11
	  syscall
	lw $a0, 8($s2)
	li $v0, 1
	syscall
	  li $a0, 10	# print "\n"
	  li $v0, 11
	  syscall
	
	j for_address_back_begin
for_address_back_end:

li $v0, 10
syscall