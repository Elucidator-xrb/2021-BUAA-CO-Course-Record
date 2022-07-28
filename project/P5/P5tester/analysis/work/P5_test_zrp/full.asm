.data
success: .space 4
vis: .space 32
a: .space 32
data: .space 1024
enter: .asciiz "\n"

.text
# 递归程序，求全排列
main: 
ori $sp, $0, 0x2ffc

ori $s0, $0, 1
ori $s1, $0, 4
ori $s2, $0, 5 # 阶数, 为5表示5的全排列，为4表示4的全排列
addu $s3, $s2, $s0
ori $s4, $0, 0

lui $a0, 0
jal dfs
nop

this: beq $0, $0, this
nop


dfs:
beq $a0, $s2, if
nop
beq $0, $0, else
nop

if:
ori $t0, $0, 1
for1:
	beq $t0, $s3, endfor1
	
	addu $t2, $t0, $t0
	addu $t2, $t2, $t2
	lw $t3, a($t2)
	
	sw $t3, data($s4)
	addu $s4, $s4, $s1
	
	addu $t0, $t0, $s0
	beq $0, $0, for1
	nop
endfor1:

beq $0, $0, return
nop

else:
	ori $t0, $0, 1
	for:
		beq $t0, $s3, endfor # t0 == 6
		nop
		
		#获取vis[i]
		addu $t1, $t0, $t0 #t1=t0*2
		addu $t2, $t1, $t1 #t2=t0*4
		lw $t3, vis($t2)
		beq $t3, $0, for_if
		nop
		beq $0, $0, next
		nop
		
		for_if:
		addu $t5, $a0, $a0
		addu $t5, $t5, $t5 # t5 = a0*4 = pos*4
		addu $t5, $t5, $s1 # t5 = pos*4+4
		sw $t0, a($t5)
		
		sw $s0, vis($t2)
		
		subu $sp, $sp, $s1
		sw $t2, 0($sp)
		subu $sp, $sp, $s1
		sw $t5, 0($sp)
		subu $sp, $sp, $s1
		sw $t0, 0($sp)
		subu $sp, $sp, $s1
		sw $ra, 0($sp)
		
		addu $a0, $a0, $s0
		jal dfs
		nop
		
		subu $a0, $a0, $s0
		
		lw $ra, 0($sp)
		addu $sp, $sp, $s1
		lw $t0, 0($sp)
		addu $sp, $sp, $s1
		lw $t5, 0($sp) # t5 = pos*4+4
		addu $sp, $sp, $s1
		lw $t2, 0($sp) # t2 = i*4
		addu $sp, $sp, $s1
		
		sw $0, a($t5)
		sw $0, vis($t2)
		
		next:
		addu $t0, $t0, $s0
		beq $0, $0, for
		nop
	endfor:
beq $0, $0, return
nop

return:
jr $ra
nop
