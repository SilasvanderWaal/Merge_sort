	.globl merge
	.text
	# a0 -> Start address array
	# a1 -> Size of the array
merge: 
	#Saving arguments from previous rutin
	subu $sp, $sp, 28
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $ra, 24($sp)
	
	srl $s0, $a1, 1		#s0 = size / 2
	move $s1, $zero		#s1 = i
	move $s2, $s0		#s2 = j
	move $s3, $zero		#s3 = k
	move $s4, $zero		#s4 = loop counter
	move $s5, $a0		#s5 = base adress of array
	
	#Dynamicly allocating memory on the stack for b[]
	sll $t0, $a1, 2
	subu $sp, $sp, $t0

for_loop:
	bge $s4, $a1, while_loop	#Check if i <= size
	sll $t1, $s4, 2			#t1 = i *4
	add $t2, $s5, $t1
	lw $t3, ($t2)			#t2 = a[i]
	add $t4, $sp, $t1
	sw $t3, ($t4)			#Save t2 to b[i]
	addi $s4, $s4, 1		#i++
	j for_loop
	
while_loop:
	bge $s2, $a1, while_loop_2
	bge $s1, $s0, while_loop_3	#Checking while loop conditions 
	
	sll $t1, $s1, 2			#i*4 for array offset
	add $t1, $t1, $sp		#add offset to the stack pointer
	lw $t2, ($t1)			#Loading in b[i]
	sll $t3, $s2, 2			#j*4 for array offest
	add $t3, $t3, $sp		#add offset to the stackpointer
	lw $t4, ($t3)			#loading in b[j]
	ble $t2, $t4, if		#if(b[j] <= b[j]) go to if
	
else:
	sll $t5, $s3, 2
	add $t5, $s5, $t5
	sw $t4, ($t5)
	addi $s2, $s2, 1		#j++
	j k_increment
if:
	sll $t5, $s3, 2			#k*4 for array offset
	add $t5, $s5, $t5		#adding k*4 to base array
	sw $t2, ($t5)			#Saving b[j] to a[k]
	addi $s1, $s1, 1		#i++

k_increment:
	addi $s3, $s3, 1		#k++
	j while_loop
	
while_loop_2:
    	bge $s1, $s0, end_while_loop_3    	#branch if(i >= half)
    	sll $t1, $s1, 2             		#i * 4 for array offset
    	add $t1, $sp, $t1
    	lw $t2, 0($t1)             		#Load in b[i]
    	sll $t3, $s3, 2             		#k*4 for array offset
    	add $t3, $s5, $t3
    	sw $t2, 0($t3)              		#a[k] = b[j]
    	addi $s1, $s1, 1			#i++
    	addi $s3, $s3, 1            		#k++
    	j while_loop_2

while_loop_3:
	bge $s2, $a1, end_while_loop_3		#Branch if i is equal or greather than size
	sll $t1, $s2, 2				#j * 4 for array offset
	add $t1, $t1, $sp			#adding the offset to the stackpointer
	lw $t2, ($t1)				#loading in the value from b[]
	sll $t3, $s3, 2				#k * 4 for array offset
	add $t3, $t3, $s5			#adding k to base array a[]
	sw $t2, ($t3)				#saving the value from b[j] to a[k]
	addi $s2, $s2, 1			#j++
	addi $s3, $s3, 1			#k++
	j while_loop_3
	
end_while_loop_3:
	#Move up stack pointer for b[]
	sll $t0, $a1, 2			#size * 4 for array offset
	addu $sp, $sp, $t0		#Move back the stack pointer
	
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
