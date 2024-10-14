	.data
vek: .word 4, 5, 2, 2, 1, 6, 7, 9, 5, 10
antal: .word 10

	.text
	.globl main
main:
	la $a0, vek
	lw $a1, antal
	jal mergeSort
	
	la $a0, vek
	lw $a1, antal
	jal printArray
	
	li $v0, 10
	syscall
	
	
	
