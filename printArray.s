	.data
format_string: .asciiz "%d "
newline_string: .asciiz "\n"
	
	.globl printArray
	.text
printArray: 
	#Moving the stackpointer down 8 addresses
	subu $sp, $sp, 16
	#Saving 
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	
	move $s0, $a0	# s0 = array start
	move $s1, $a1	# s1 = array size
	li $s2, 0	# s2 = loop counter
	
	la $a0, newline_string
	jal print
		
print_loop:
	bge $s2, $s1, stop_rutin
	la $a0, format_string
	sll $t0, $s2, 2
	add $t0, $t0, $s0
	lw $a1, ($t0)
	jal print
	addi $s2, $s2, 1
	j print_loop
	
stop_rutin:
	la $a0, newline_string
	jal print
	
	#Restoring the state before the rutin
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addu $sp, $sp, 16
	
	jr $ra
	
