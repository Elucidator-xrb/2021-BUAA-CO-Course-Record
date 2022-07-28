.data
matrix: .space 256					# int matrix[8][8] 8*8*4 Byte
str_enter: .asciiz "\n"
str_space: .asciiz " "

.macro getindex(%ans, %i, %j)			# row %i + column %j -> the real address offset %ans
	sll %ans, %i, 3 				# %ans = %i * 8
	add %ans, %ans, %j 				# %ans = %ans + %j
	sll %ans, %ans, 2 				# donnot forget 4 Byte a room
.end_macro

.text
li $v0, 5							#read in rows and columns
syscall
move $s0, $v0						#rows stored in $s0
li $v0, 5
syscall
move $s1, $v0						#columns stored in $s1

li $t0, 0							#set counter i:$t0 for outerloop
in_i:
beq $t0, $s0, in_i_end
	li $t1, 0						#set counter j:$t1 for innerloop
	in_j:
	beq $t1, $s0, in_j_end
	li $v0, 5
	syscall
	getindex($t2, $t0, $t1)
	sw $v0, matrix($t2)
	addi $t1, $t1, 1				#increment of j-$t1
	j in_j
	in_j_end:
addi $t0, $t0, 1					#increment of i-$t1
j in_i
in_i_end:

li $t0, 0
out_i:
beq $t0, $s0, out_i_end
	li $t1, 0
	out_j:
	beq $t1, $s1, out_j_end
	getindex($t2, $t0, $t1)
	lw $a0, matrix($t2)				#print matrix value
	li $v0, 1
	syscall
	la $a0 str_space				#print " "
	li $v0, 4
	addi $t1, $t1, 1
	j out_j
	out_j_end:
la $a0, str_enter
li $v0, 4
syscall
addi $t0, $t0, 1
j out_i
out_i_end:

li $v0, 10
syscall
	
	
	
	
	
	
	



