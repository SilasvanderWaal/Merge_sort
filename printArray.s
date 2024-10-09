	.data
format_string: .asciiz "%d "
newline_string: .asciiz "\n"
	
	.globl printArray
	.text
printArray: 
	#Moving the stackpointer down 8 addresses
	subu $sp, $sp, 32
	#Saving arguments from previous rutin
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)	
	sw $a3, 12($sp)
	sw $s0, 16($sp)
	sw $s1, 20($sp)
	sw $s2, 24($sp)
	sw $ra, 28($sp)
	
	move $s0, $a0	# s0 = array start
	move $s1, $a1	# s1 = array size
	li $s2, 0	# s2 = loop counter
	
	la $a0, newline_string
	jal print
		
print_loop:
	bge $s2, $s1, stop_rutin
	la $a0, format_string
	lw $a1, ($s0)
	jal print
	addi $s0, $s0, 4	#move to the next adress in the array
	addi $s2, $s2, 1
	j print_loop
	
	
stop_rutin:
	la $a0, newline_string
	jal print
	
	#Restoring the state before the rutin
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)	
	lw $a3, 12($sp)
	lw $s0, 16($sp)
	lw $s1, 20($sp)
	lw $s2, 24($sp)
	lw $ra, 28($sp)
	addu $sp, $sp, 32
	
	jr $ra
	
