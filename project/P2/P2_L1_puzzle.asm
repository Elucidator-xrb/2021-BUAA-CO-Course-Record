.data
map: 	.space 256
stack: 	.space 8192

.macro getindex_8(%ans,%i,%j) 
	sll %ans, %i, 3
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.macro setmap(%i, %j, %value) 	# map[x + %i][y + %j] = %value
	addi $t2, $t0, %i			# ATTENTION: remember this macro will use $t2 - $t5
	addi $t3, $t1, %j
	getindex_8($t4, $t2, $t3)
	li $t5, %value
	sw $t5, map($t4)
.end_macro

.text
la $sp, stack
addiu $sp, $sp, 8192

main:
	li $v0, 5
	syscall
	move $s0, $v0						# $s0: N - (global)
	li $v0, 5
	syscall
	move $s1, $v0						# $s1: M - (global)
	
	li $t0, 0
	for_i_begin:
	slt $t2, $t0, $s0
	beqz $t2, for_i_end
	
		li $t1, 0
		for_j_begin:
		slt $t2, $t1, $s1
		beqz $t2, for_j_end
			
			li $v0, 5
			syscall
			getindex_8($t2, $t0, $t1)
			sw $v0, map($t2)
			
		addi $t1, $t1, 1
		j for_j_begin
		for_j_end:
	
	addi $t0, $t0, 1
	j for_i_begin
	for_i_end:
	
	li $v0, 5
	syscall
	move $t0, $v0
	addi $t0, $t0, -1						# $t0: x1
					
	li $v0, 5
	syscall
	move $t1, $v0
	addi $t1, $t1, -1						# $t1: y1
	
	li $v0, 5
	syscall
	move $s2, $v0
	addi $s2, $s2, -1						# $s2: x2 - (global)
	
	li $v0, 5
	syscall
	move $s3, $v0
	addi $s3, $s3, -1						# $s3: y2 - (global)
	
	li $s4, 0				# $s4: cnt - (global)
	
	getindex_8($t2, $t0, $t1)
	li $t3, 1
	sw $t3, map($t2)
	
	move $a0, $t0
	move $a1, $t1
	
	jal dfs
	
	move $a0, $s4
	li $v0, 1
	syscall

li $v0, 10
syscall
	
dfs:
addiu $sp, $sp, -12
move $t0, $a0								# $t0: x
move $t1, $a1								# $t1: y
	
	if_reach_begin:
		bne $t0, $s2, if_reach_end
		bne $t1, $s3, if_reach_end
		
		addi $s4, $s4, 1
		j return
	if_reach_end:

	
	if_east_begin:
		addi $a0, $t0, 1
		addi $a1, $t1, 0
		sw $ra, 8($sp)
		jal isAble
		lw $ra, 8($sp)
		
		beqz $v0, if_east_end
		
		setmap(1,0,1)
		
		addi $a0, $t0, 1
		addi $a1, $t1, 0
		sw $t0, 8($sp)
		sw $t1, 4($sp)
		sw $ra, 0($sp)
		jal dfs
		lw $ra, 0($sp)
		lw $t1, 4($sp)
		lw $t0, 8($sp)
		
		setmap(1,0,0)
	if_east_end:
	
	if_west_begin:
		addi $a0, $t0, -1
		addi $a1, $t1, 0
		sw $ra, 8($sp)
		jal isAble
		lw $ra, 8($sp)
		
		beqz $v0, if_west_end
		
		setmap(-1,0,1)
		
		addi $a0, $t0, -1
		addi $a1, $t1, 0
		sw $t0, 8($sp)
		sw $t1, 4($sp)
		sw $ra, 0($sp)
		jal dfs
		lw $ra, 0($sp)
		lw $t1, 4($sp)
		lw $t0, 8($sp)
		
		setmap(-1,0,0)
	if_west_end:
	
	if_north_begin:
		addi $a0, $t0, 0
		addi $a1, $t1, 1
		sw $ra, 8($sp)
		jal isAble
		lw $ra, 8($sp)
		
		beqz $v0, if_north_end
		
		setmap(0,1,1)
		
		addi $a0, $t0, 0
		addi $a1, $t1, 1
		sw $t0, 8($sp)
		sw $t1, 4($sp)
		sw $ra, 0($sp)
		jal dfs
		lw $ra, 0($sp)
		lw $t1, 4($sp)
		lw $t0, 8($sp)
		
		setmap(0,1,0)
	if_north_end:

	if_south_begin:
		addi $a0, $t0, 0
		addi $a1, $t1, -1
		sw $ra, 8($sp)
		jal isAble
		lw $ra, 8($sp)
		
		beqz $v0, if_south_end
		
		setmap(0,-1,1)
		
		addi $a0, $t0, 0
		addi $a1, $t1, -1
		sw $t0, 8($sp)
		sw $t1, 4($sp)
		sw $ra, 0($sp)
		jal dfs
		lw $ra, 0($sp)
		lw $t1, 4($sp)
		lw $t0, 8($sp)
		
		setmap(0,-1,0)
	if_south_end:
	
return:
addiu $sp, $sp, 12
jr $ra

	
isAble:	# using $t2, $t3 to avoid maintaining the $t0, $t1 in father_function
move $t2, $a0			# $t2: x
move $t3, $a1			# $t3: y
	bgt $0, $t2,	set_0
	bge $t2, $s0,	set_0
	bgt $0, $t3,	set_0
	bge $t3, $s1, 	set_0
	
	getindex_8($t4, $t2, $t3)
	lw $t5, map($t4)
	bnez $t5, set_0
	
set_1:
li $v0, 1
jr $ra
	
set_0:
li $v0, 0
jr $ra	
