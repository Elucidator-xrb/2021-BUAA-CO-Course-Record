.data
Ge: .space 256					# int Ge[8][8]  8*8*4 Byte
dp: .space 9600				# int dp[Smax=300][Vmax=8] 300*8*4 Byte

.macro getindex(%ans, %i, %j)					# (%i * 8 + %j) * 4
	sll %ans, %i, 3						# %ans = %i * 8
	add %ans, %ans, %j						# %ans = %ans + %j
	sll %ans, %ans, 2						# %ans = %ans * 4
.end_macro

.text
buildGraph:
	li $v0, 5
	syscall
	move $s0, $v0 							# $s0: n
	li $v0, 5
	syscall
	move $s1, $v0							# $s1: m
	
	li $t0, 0								# $t0: i in for()
	for_readGraph_begin:
		slt $t1, $t0, $s1					# i<m than $t1=1
		beqz $t1, for_readGraph_end
		
		li $v0, 5
		syscall
		move $t2, $v0
		li $v0, 5
		syscall
		move $t3, $v0
		
		li $t5, 1
		getindex($t4, $t2, $t3)
		sw $t5, Ge($t4)
		getindex($t4, $t3, $t2)
		sw $t5, Ge($t4)		
		
		addi $t0, $t0, 1
		j for_readGraph_begin
	for_readGraph_end:
nop

dpStatus:
	li $t0, 1
	getindex($t1, $t0, $t0)					# $t0 = 1, make use of it
	sw $t0, dp($t1)
	
	sllv $t3, $t0, $s0						# $t3 = 1<<n
	li $t0, 1								# $t0: S
	for_S_begin:							# for(S=1;S<(1<<n);++S)
		slt $t4, $t0, $t3
		beqz $t4, for_S_end
		
		li $t1, 1							# $t1: v
		for_v_begin:						# for(v=1;v<=n;++v)
			sgt $t4, $t1, $s0
			bnez $t4, for_v_end
			
			if_canFindPre_begin:
				addi $t3, $t1, -1
				li $t4, 1
				sllv $t4, $t4, $t3				# $t4 = 1<<(v-1)
				and $t3, $t0, $t4				# $t3 = S & (1<<(v-1))	
				beqz $t3, if_canFindPre_end
		
				xor $t3, $t0, $t4				# $t3: Spre
				li $t2, 1						# $t2: u
				for_u_begin:					# for(u=1;u<=n;++u)
					sgt $t4, $t2, $s0
					bnez $t4, for_u_end
					
					if_canFindDp_begin:
						addi $t4, $t2, -1
						li $t5, 1
						sllv $t5, $t5, $t4			# $t5 = 1<<(u-1)
						and $t4, $t0, $t5			# $t4 = S & (1<<(u-1))
						beqz $t4, if_canFindDp_end
									
						getindex($t4 ,$t2, $t1)		
						lw $t4, Ge($t4)			# $t4 = Ge[u][v]
						getindex($t5, $t3, $t2)		
						lw $t5, dp($t5)			# $t5 = dp[Spre][v]
						and $t4, $t4, $t5			# $t4 = dp[Spre][v] & Ge[u][v]
						getindex($t5, $t0, $t1)		# $t5 : offset of dp[S][v]
						lw $t6, dp($t5)			# $t6 = dp[S][v]
						or $t6, $t6, $t4			# $t6 = $t6 | $t4
						sw $t6, dp($t5)			# store back
					if_canFindDp_end:
			
					#li $a0, 9
					#li $v0, 1
					#syscall			
			
					addi $t2, $t2, 1
					j for_u_begin
				for_u_end:
				
			if_canFindPre_end:			
		
			addi $t1, $t1, 1
			j for_v_begin
		for_v_end:
		
		addi $t0, $t0, 1
		j for_S_begin
	for_S_end:
	
	
	li $t0, 1								# $t0: i
	for_i_begin:							# for(i=1;i<=n;++i)
		sgt $t1, $t0, $s0
		bnez $t1, for_i_end
		
		if_canCircle_begin:
			li $t2, 1
			getindex($t1, $t0, $t2)
			lw $t1, Ge($t1)				# $t1: Ge[i][1]
			li $t2, 1
			sllv $t2, $t2, $s0				# 1<<n
			addi $t2, $t2, -1				# (1<<n)-1
			getindex($t3, $t2, $t0)	
			lw $t3, dp($t3)				# $t3: dp[(1<<n)-1][i]
			and $t4, $t3, $t1				
			beqz $t4, if_canCircle_end
			
			li $a0, 1
			li $v0, 1
			syscall		
			
			li $v0, 10
			syscall
			
		if_canCircle_end:
		
		addi $t0, $t0, 1
		j for_i_begin
	for_i_end:
	
	li $a0, 0
	li $v0, 1
	syscall

li $v0, 10
syscall





