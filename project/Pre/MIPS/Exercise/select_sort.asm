.data
array: .space 400
stack: .space 100
msg_1: .asciiz "Please enter the number of the sequence:\n"
msg_2: .asciiz "Please enter a number:\n"
msg_3: .asciiz "The sorted sequence is:"
msg_sp: .asciiz " "
				

.globl main
.text
main:
	la $sp, stack
	addiu $sp, $sp, 100			# place $sp to the top of the stack
	addiu $sp, $sp, -20
	
	jal input					# call function "input"
	nop
	move $t0, $v0				# get returned value
	
	move $a0, $t0				# call function "sort"
	sw $t0, 16($sp)	# 0-16 : main.$a0~$a3
	jal sort
	nop
	lw $t0, 16($sp)

	move $a0, $t0
	jal output
	nop
	
	addiu $sp, $sp, 20 
li $v0, 10
syscall
	

input:
	la $a0, msg_1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0				# consider $t0 as num
	
	li $t1, 0					# consider $t1 as i
	for_1_begin:				# for(i=0;i<n;++i){
		slt $t2, $t1, $t0
		beqz $t2, for_1_end
		nop
		
		la $t2, array
		li $t3, 4
		mult $t3, $t1
		mflo $t3				# $t3 : i*4
		addu $t2, $t2, $t3		# $t2 : array[i] , array + i*4
		
		la $a0, msg_2
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		sw $v0, 0($t2)
		
		addi $t1, $t1, 1 		# ++i
		j for_1_begin
		nop
	for_1_end:
move $v0, $t0					# return value to $v0 
jr $ra
nop


output:
move $t0, $a0					# receieve argument from $a0 : num
	la $a0, msg_3
	li $v0, 4
	syscall
	
	li $t1, 0
	for_2_begin:
		slt $t2, $t1, $t0
		beqz $t2, for_2_end
		nop
		
		la $t2, array
		li $t3, 4
		mult $t3, $t1
		mflo $t3				# $t3 : i*4
		addu $t2, $t2, $t3		# $t2 : array[i] , array + i*4
		
		lw $a0, 0($t2)
		li $v0, 1
		syscall
		
		la $a0, msg_sp
		li $v0, 4
		syscall		
	
		addi $t1, $t1, 1
		j for_2_begin
		nop	
	for_2_end:
jr $ra
nop


sort:
addiu $sp, $sp, -32
move $t0, $a0					# receieve argument from $a0 : num
	li $t1, 0
	for_3_begin:
		slt $t2, $t1, $t0
		beqz $t2, for_3_end
		nop
		
		la $t2, array
		li $t3, 4
		mult $t1, $t3
		mflo $t3
		addu $t2, $t2, $t3		# current address (data before which are all sorted)
		
		# prepare to call the function
		move $a0, $t0			# prepare argument $a0 : num
		move $a1, $t1 			# prepare argument $a1 : offset from array - to get starting number
		
		sw $t2, 28($sp)		# starting to use stack to maintain data
		sw $t1, 24($sp)
		sw $t0, 20($sp)
		sw $ra, 16($sp)
		jal findmin
		nop
		lw $ra, 16($sp)
		lw $t0, 20($sp)
		lw $t1, 24($sp)
		lw $t2, 28($sp)
		# end of calling a function , get the address of the chosen number in $v0 as the return value
		
		lw $t3, 0($v0)			# swap $t2 and $v0, place the chosen number in order
		lw $t4, 0($t2)
		sw $t3, 0($t2)
		sw $t4, 0($v0)
		
		addi $t1, $t1, 1
		j for_3_begin
		nop
	for_3_end:
addiu $sp, $sp, 32
jr $ra
nop

# MUST think clear about address/value in register
findmin:		# leaf function
move $t0, $a0					# receive argument from $a0 : num
move $t1, $a1					# receive argument from $a1 : offset from array - to get starting number
	la $t2, array
	li $t3, 4
	mult $t1, $t3
	mflo $t3
	add $t2, $t2, $t3
	  lw $v1, 0($t2)				# initialize $v0, load the first starting number
	  move $v0, $t2
	addi $t1, $t1, 1
	
	for_4_begin:				# for(;offset<num;++offset)
		slt $t2, $t1, $t0
		beqz $t2, for_4_end
		nop
		
		la $t2, array
		li $t3, 4
		mult $t1, $t3
		mflo $t3
		add $t2, $t2, $t3
		
		lw $t3, 0($t2)				
		slt $t4, $t3, $v1
		beqz $t4 if_end
		nop
		if_begin:
			lw $v1, 0($t2)
			move $v0, $t2
		if_end:
		
		addi $t1, $t1, 1
		j for_4_begin
		nop
	for_4_end:
jr $ra
nop
		
	

