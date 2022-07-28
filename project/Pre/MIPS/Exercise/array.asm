.data
array: .space 40  				#Array 10*4(int)
str:   .asciiz "The numbers are:\n"
space: .asciiz " "

.text
li $v0, 5
syscall          				#input an integer n
move $s0, $v0					#save n to $s0
li $t0, 0        				#variable i for loop

loop_in:
beq $t0, $s0, loop_in_end 
li $v0, 5						#read the following input
syscall
sll $t1, $t0, 2					#$t1 = $t0 << 2, means $t1 = 4 * i
sw $v0, array($t1) 				#save the input to array + $t1
addi $t0, $t0, 1 				#auto-increment of i-$t0
j loop_in

loop_in_end:
la $a0, str
li $v0, 4 						#output the hint
syscall
li $t0, 0

loop_out:
beq $t0, $s0, loop_out_end
sll $t1, $t0, 2
lw $a0, array($t1)				#output things store in array
li $v0, 1						
syscall
la $a0, space					#output the space as seperator
li $v0, 4
syscall
addi $t0, $t0, 1
j loop_out

loop_out_end:
li $v0, 10						#exit
syscall		





