	.globl mergeSort
	.text
mergeSort:
	#Saving the start address and the size
	subu $sp, $sp, 8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	ble $a1, 1, exit_loop	#if size > 1
	srl $t1, $a1, 1		#t1 = size / 2 
	lw $a0, 0($sp)		#Loading arguments
	move $a1, $t1	
	subu $sp, $sp, 4	#Saving the stack pointer	
	sw $ra, ($sp)	-
	
	jal mergeSort		#Calling mergeSort(a, half)
	lw $ra, 0($sp)		#Loading previous stackpointer 		
	addu $sp, $sp, 4
	
	lw $a0, 0($sp)
	sll $t1, $t1, 2
	add $a0, $a0, $t1	#Calculating a + half	
	sub $a1, $a1, $t1	#Calculating size - half
	subu $sp, $sp, 4	
	sw $ra, ($sp)		#Saving stack pointer             
	jal mergeSort		#Calling mergeSort(a + half, size - half)
	lw $ra, 0($sp)		#Loading previous stack pointer
	addu $sp, $sp, 4	
	
	subu $sp, $sp, 4	#Saving stack pointer
	sw $ra, ($sp)
	jal merge
	lw $ra, 0($sp)		#Loading previous stack pointer
	addu $sp, $sp, 4
	
exit_loop:
	addu $sp, $sp, 8
	jr $ra		#Jump back to previous pointer