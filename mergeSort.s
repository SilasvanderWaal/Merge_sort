	.data

	.globl mergeSort
	.text
	subu $sp, $sp, 12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
mergeSort:
	ble $a1, 1, exit_loop
	move $t0, $a0		#t0 = base address
    	move $t1, $a1		#t1 = size
	srl $t2, $t0, 1		#t2 = size / 2 = half
	move $a1, $t2		#mergeSort(a, half);
	jal mergeSort
	
	add $a0, $t0, $t2	#mergeSort(a + half, size - half);
	sub $a1, $t1, $t2
	jal mergeSort
	
	move $a0, $t0		#merge(a, size);
	move $a1, $t1
	jal merge
	
	jr $ra
exit_loop
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addu $sp, $sp, 12
	jr $ra