.globl mergeSort
	.text
mergeSort:
	#Saving the start address and the size
	subu $sp, $sp, 24
	sw $s0, ($sp)
	sw $s1, 4($sp)
	sw $s3, 8($sp)
	sw $ra, 12($sp)
	sw $a0, 16($sp)
	sw $a1, 20($sp)
	
	move $s0, $a0
	move $s1, $a1
	
	ble $s1, 1, exit_loop		#if size > 1		
	srl $s3, $s1, 1			#s2 = size / 2 
	
	#Loading in the values for mergeSort(a, half)
	move $a0, $s0
	move $a1, $s3
	jal mergeSort			#Calling merSort(a, half)
	
	sll $t0, $s3, 2			#Calculating offset for the new adress
	add $a0, $s0, $t0		#Calculating a + half	
	sub $a1, $s1, $s3		#Calculating size - half
	jal mergeSort			#Calling mergeSort(a + half, size - half)	
	
	move $a0, $s0
	move $a1, $s1
	jal merge			#Calling merge(a, size)
	
exit_loop:
	#loading previous values 
	lw $s0, ($sp)
	lw $s1, 4($sp)
	lw $s3, 8($sp)
	lw $ra, 12($sp)
	addu $sp, $sp, 24
	jr $ra				#Jump back
