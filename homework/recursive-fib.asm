.data
stack: .space 1000

.text
la $sp, stack
addiu $sp, $sp, 1000

li $v0, 5
syscall
move $s0, $v0
jal fib

fib:
addiu $sp, $sp, -12
sw $s0, 8($sp)