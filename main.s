	.data
vek: .word 2,6, 5, 3, 1, -5, 4, 3, 10, 2,0
antal: .word 11


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
	
	
	
