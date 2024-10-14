	.data

	.globl merge
	.text
	# a0 -> Start address array
	# a1 -> Size of the array
merge: 
	subu $sp, $sp, 28
	#Saving arguments from previous rutin
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $ra, 24($sp)
	
	sll $t0, $a1, 2
	sub $sp, $sp, $t0
	
	srl $s0, $a1, 1		#s0 = size / 2
	li $s1, 0		#s1 = i
	add $s2, $zero, $s0	#s2 = j
	li $s3, 0		#s3 = k
	move $s4, $a1		#s4 = size
	move $s5, $a0		#s5 = a[]
	li $t0, 0		#t0 = Adress buffer

for_loop:
	bge $s1, $s4, end_for_loop		#Check if i <= size
	sll $t1, $s1, 2				#t1 = i *4
	add $t0, $s5, $t1
	lw $t2, ($t0)				#t2 = a[i]
	add $t0, $sp, $t1
	sw $t2, ($t0)				#Save t2 to b[i]
	addi $s1, $s1, 1			#i++
	j for_loop
	
end_for_loop:
	li $s1, 0
	
while_loop:
	bge $s1, $s0, while_loop_2		#Checking while loop conditions 
	bge $s2, $s4, while_loop_2
	
	sll $t0, $s1, 2
	add $t0, $t0, $sp
	lw $t1, ($t0)			#Loading in b[i]
	sll $t0, $s2, 2
	add $t0, $t0, $sp
	lw $t2, ($t0)			#loading in b[j]
	bgt $t1, $t2, if		#if(b[j] <= b[j]) go to if
	
else:
	sll $t0, $s2, 2
	add $t0, $t0, $sp
	lw $t1, ($t0)			#load b[j]
	sll $t0, $s3, 2
	add $t0, $t0, $s5
	sw $t1, ($t0)			#save b[j] to a[k]
	addi $s2, $s2, 1		#j++
	j k_increment
if:
	sll $t0, $s1, 2	
	add $t0, $t0, $sp		
	lw $t1, ($t0)		#Load b[i]
	sll $t0, $s3, 2
	add $t0, $t0, $s5
	sw $t1, ($t0)			#save b[i] to a[k]
	addi $s1, $s1, 1		#i++

k_increment:
	addi $s3, $s3, 1		#k++
	j while_loop
	
end_while_loop:
while_loop_2:
	bge $s1, $s0, end_while_loop_2		#Branch if i is equal or greather than half
	sll $t0, $s1, 2				#i * 4
	add $t0, $t0, $sp			#add i*4 + stack pointer
	lw $t1, ($t0)				#Load vlaue from stack at index i
	sll $t0, $s3, 2				#j * 4
	add $t0, $t0, $s5			# a[k]
	sw $t1, ($t0)				#Load value from a[k]
	addi $s1, $s1, 1			#i++
	addi $s3, $s3, 1			#k++	
	j while_loop_2

end_while_loop_2:
while_loop_3:
	bge $s2, $s4, end_while_loop_3		#Branch if i is equal or greather than size
	sll $t0, $s2, 2				#t0 = j * 4
	add $t0, $t0, $sp			#add t0 to stack pointer
	lw $t1, ($t0)				
	sll $t0, $s3, 2
	add $t0, $t0, $s5
	sw $t1, ($t0)
	addi $s2, $s2, 1
	addi $s3, $s3, 1
	j while_loop_3
end_while_loop_3:
	#Move up stack pointer for b[]
	sll $t0, $a1, 2
	addu $sp, $sp, $t0
	#Restoring the state before the rutin
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $ra, 24($sp)
	#Moving the stackpointer down 8 addresses
	addu $sp, $sp, 28
	jr $ra

