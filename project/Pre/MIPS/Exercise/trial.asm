.data
array: .space 320		# array[10][8]


.macro getindex(%ans, %i, %j)					# (%i * 8 + %j) * 4
	sll %ans, %i, 3						# %ans = %i * 8
	add %ans, %ans, %j						# %ans = %ans + %j
	sll %ans, %ans, 2						# %ans = %ans * 4
.end_macro

.text
li $t0, 1
li $t1, 3
li $t5, 8
getindex($t2, $t0, $t1)
sw $t5, array($t2)
getindex($t2, $t0, $t1)
lw $t2, array($t2)