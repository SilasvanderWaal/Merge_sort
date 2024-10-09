	.data
buffer_array: .space 40

	.globl merge
	.text
merge: 
	srl $t0, $a1, 1		#t0 = size / 2 -> int half
	li $t1, 0		#t1 = i
	add $t2, $zero, $0	#t2 = j
	li $t3, 0		#t3 = k
	add $t4, $zero, $a1	#t4 = size
	add $t5, $zero, $a0	#t5 = a[]
	add $t6, $zero, $t5	#t6 = current address
	li $t7, 0		#t7 = buffer
	
for_loop
	bge $t1, $t4, end_for_loop
	lw $t7, (t6)
	
	addi $t6, $t6, 4
	
	j for_loop	
	