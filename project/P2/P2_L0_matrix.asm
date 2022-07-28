.data
matrix_a: .word 0:64
matrix_b: .word 0:64
matrix_c: .word 0:64

.macro getindex_8(%ans, %i, %j)						# ( i * 8 + j ) * 4
	sll %ans, %i, 3
	add %ans, %ans, %j 
	sll %ans, %ans, 2
.end_macro

.text
li $v0, 5
syscall
move $s0, $v0										# $s0 : n


getMatrix_a:
	li $t0, 0											# $t0 : row
	for_row1_begin:
	slt $t2, $t0, $s0									# row < n ? 1 : 0
	beqz $t2, for_row1_end

		li $t1, 0										# $t1 : col
		for_col1_begin:
		slt $t2, $t1, $s0								# col < n ? 1 : 0
		beqz $t2, for_col1_end
	
			li $v0, 5
			syscall
			move $t3, $v0								# $t3 : store value temporary
			getindex_8($t2, $t0, $t1)
			sw $t3, matrix_a($t2)
	
		addi $t1, $t1, 1
		j for_col1_begin
		for_col1_end:

	addi $t0, $t0, 1
	j for_row1_begin
	for_row1_end:


getMatrix_b:
	li $t0, 0											# $t0 : row
	for_row2_begin:
	slt $t2, $t0, $s0									# row < n ? 1 : 0
	beqz $t2, for_row2_end

		li $t1, 0										# $t1 : col
		for_col2_begin:
		slt $t2, $t1, $s0								# col < n ? 1 : 0
		beqz $t2, for_col2_end
	
			li $v0, 5
			syscall
			move $t3, $v0								# $t3 : store value temporary
			getindex_8($t2, $t0, $t1)
			sw $t3, matrix_b($t2)
	
		addi $t1, $t1, 1
		j for_col2_begin
		for_col2_end:

	addi $t0, $t0, 1
	j for_row2_begin
	for_row2_end:

calMatrix_c:
	li $t0, 0											# $t0 : row
	for_row3_begin:
	slt $t2, $t0, $s0									# row < n ? 1 : 0
	beqz $t2, for_row3_end

		li $t1, 0										# $t1 : col
		for_col3_begin:
		slt $t2, $t1, $s0								# col < n ? 1 : 0
		beqz $t2, for_col3_end
		
			li $s1, 0									# initial $s1 for tmp_sum
		
			li $t2, 0									# $t2 : i
			for_i_begin:
			slt $t3, $t2, $s0							#  i  < n ? 1 : 0
			beqz $t3, for_i_end
	
				getindex_8($t3, $t0, $t2)					# [row][col]  also the addr of matrix_c
				getindex_8($t4, $t2, $t1)					# [col][row]
				lw $t8, matrix_a($t3)
				lw $t9, matrix_b($t4)
				mult $t8, $t9
				mflo $t5
				add $s1, $s1, $t5
			
			addi $t2, $t2, 1
			j for_i_begin
			for_i_end:
			
			getindex_8($t3, $t0, $t1)
			sw $s1, matrix_c($t3)
	
		addi $t1, $t1, 1
		j for_col3_begin
		for_col3_end:
		
	addi $t0, $t0, 1
	j for_row3_begin
	for_row3_end:

printMatrix_c:
	li $t0, 0											# $t0 : row
	for_row4_begin:
	slt $t2, $t0, $s0									# row < n ? 1 : 0
	beqz $t2, for_row4_end

		li $t1, 0										# $t1 : col
		for_col4_begin:
		slt $t2, $t1, $s0								# col < n ? 1 : 0
		beqz $t2, for_col4_end
	
			getindex_8($t2, $t0, $t1)
			lw $a0, matrix_c($t2)
			li $v0, 1
			syscall
			
			li $a0, 32
			li $v0, 11
			syscall
	
		addi $t1, $t1, 1
		j for_col4_begin
		for_col4_end:
		
		li $a0, 10
		li $v0, 11
		syscall

	addi $t0, $t0, 1
	j for_row4_begin
	for_row4_end:


li $v0, 10
syscall