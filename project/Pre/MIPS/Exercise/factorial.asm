.data
# hasn't written yet

.text
main:
	li $v0, 5
	syscall 
	move $s0, $v0
	
	move $a0, $s0
	jal factorial
	move $a0, $v0
	
	li $v0, 1
	syscall	
li $v0, 10
syscall
	

factorial:
	bne $a0, 1, work
li $v0, 1
jr $ra

work:
move $t0, $a0
addiu $sp, -8
	sw $ra, 4($sp)
	sw $t0, 0($sp)
	
	addi $t1, $t0,	1
	move $a0, $t1
	jal factorial
	
	lw $t0, 0($sp)
	lw $ra, 4($sp)
	
	mult $t0, $v0
	mflo $v0
addiu $sp, 8
jr $ra
	
	
