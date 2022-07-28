.data
map: .space 256


.text

.macro getIndex_8(%ans,%i,%j) 
	sll %ans, %i, 3
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.macro map_orient(%i, %j, %value) 	# ATTENTION: remember this macro will use $t2 - $t5
	addi $t2, $t0, %i
	addi $t3, $t1, %j
	getIndex_8($t4, $t2, $t3)
	li $t5, %value
	sw $t5, map($t4)
.end_macro

label:

li $t0, 15
li $t1, 15

mul $t2, $t0, $t1

div $t2, $t0, $t1
