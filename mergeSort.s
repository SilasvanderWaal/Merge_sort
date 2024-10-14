.globl mergeSort
	.text
mergeSort:
	#Saving the start address and the size
	
mergeSort_loop:
	ble $a1, 1, exit_loop		#if size > 1
	move $s0, $a0
	move $s1, $a1			
	srl $s3, $s1, 1			#s3 = size / 2 
	move $a1, $s3
	move $a0, $s0
		
	subu $sp, $sp, 4		#Saving the stack pointer	
	sw $ra, ($sp)
	jal mergeSort_loop		#Calling mergeSort(a, half)
	lw $ra, 0($sp)			#Loading previous stackpointer 		
	addu $sp, $sp, 4
	
	sll $t1, $s3, 2
	add $a0, $s0, $t3		#Calculating a + half	
	sub $a1, $s1, $s3		#Calculating size - half
	
	subu $sp, $sp, 4	
	sw $ra, ($sp)			#Saving stack pointer             
	jal mergeSort_loop		#Calling mergeSort(a + half, size - half)
	lw $ra, 0($sp)			#Loading previous stack pointer
	addu $sp, $sp, 4	
	
	move $a0, $s0
	move $a1, $s1
	subu $sp, $sp, 4		#Saving stack pointer
	sw $ra, ($sp)
	jal merge
	lw $ra, ($sp)			#Loading previous stack pointer
	addu $sp, $sp, 4
	
exit_loop:
	jr $ra				#Jump back