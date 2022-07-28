.data
seq: .space 30

.text
li $v0, 5
syscall
move $s0, $v0											# $s0 : N

save_character:
	li $t0, 0											# $t0 : i
	for_i_begin:
	slt $t1, $t0, $s0
	beqz $t1, end_i_end
	
		li $v0, 12
		syscall
		sb $v0, seq($t0)
		
		#li $v0, 12		# throw the "\n"
		#syscall

	addi $t0, $t0, 1
	j for_i_begin
	end_i_end:
	
judge_seq:
	li $t0, 0											# $t0 : i
	addi $t1, $s0, -1									# $t1 : j
	for_ij_begin:
		sle $t2, $t0, $t1
		beqz $t2, for_ij_end
	
		lb $t8, seq($t0)
		lb $t9, seq($t1)
		bne $t8, $t9, for_ij_end
	
		addi $t0, $t0, 1
		addi $t1, $t1, -1
		j for_ij_begin
	for_ij_end:
	
	if_ji_begin:
		sgt $t2, $t0, $t1
		beqz $t2, if_ji_else
	
		li $a0, 1
		j if_ji_end
	if_ji_else:
		li $a0, 0
	if_ji_end:
	
	li $v0, 1
	syscall

li $v0, 10
syscall
	
	
