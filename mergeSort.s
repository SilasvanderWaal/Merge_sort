	.globl mergeSort
	.text
	subu $sp, $sp, 16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
mergeSort:
	ble $a1, 1, exit_loop
	move $s0, $a0		#s0 = base address
    	move $s1, $a1		#s1 = size
	srl $s2, $s1, 1		#s2 = size / 2 = half
	move $a1, $s2		#mergeSort(a, half);
	jal mergeSort
	
	add $a0, $s0, $s2	#mergeSort(a + half, size - half);
	sub $a1, $s1, $s2
	jal mergeSort
	
	move $a0, $s0		#merge(a, size);
	move $a1, $s1
	jal merge
	
exit_loop:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addu $sp, $sp, 16
	jr $ra
