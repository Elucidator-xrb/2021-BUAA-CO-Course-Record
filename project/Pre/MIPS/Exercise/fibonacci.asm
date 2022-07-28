.data
fibs: .space 48								# fibs 12 * 4Byte
size: .word 12
str_space: .asciiz " "
str_head: .asciiz "The Fibonacci numbers are:\n"

.text
la $t0, fibs								# load fibs' address to $t0

la $t5, size								# load size's address to $t5
lw $t5, 0($t5)								# load size's value to $t5

li $t2, 1									# load 1 to $t2
sw $t2, 0($t0)								# store $t2=1 to fibs[0]
sw $t2, 4($t0)								# store $t2=1 to fibs[1]

addi $t1, $t5, -2							# set counter i=size-2:$t1 for loop
loop: # $t0 moves continuously in the memory
lw $t3, 0($t0)								# load fibs[n] to $t3
lw $t4, 4($t0)								# load fibs[n+1] to $t4
add $t2, $t3, $t4
sw $t2, 8($t0)								# store $t5 to fibs[n+2]
addi $t0, $t0, 4							# move $n0:n 
addi $t1, $t1, -1							# decrement of counter i
bgtz $t1, loop

la $a0, fibs								# argument1 $a0: fibs address
la $a1, size								# argument2 $a1: fibs size
jal print									# use jal+label as function, we can also use .macro
li $v0, 10
syscall


print:
	move $t0, $a0							# $t0 is the formal argument of $a0 in function "print"
	move $t1, $a1							# $t1 is the formal argument of $a1 in function "print"
	
	la $a0, str_head
	li $v0, 4
	syscall
	
	out:
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	la $a0, str_space
	li $v0, 4
	syscall
	addi $t0, $t0, 4						#increment of address $t0
	addi $t1, $t1, -1						#decrement of couter $t1
	bgtz $t1, out
jr $ra
	
	



