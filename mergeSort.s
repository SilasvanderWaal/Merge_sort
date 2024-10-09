	.data

	.globl mergeSort
	.text
	sudu $sp, $sp, 12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
mergeSort:
	ble $a1, 1, 
	div $a1, 2
	mflo $a1
	j mergeSort
	
exit_loop
