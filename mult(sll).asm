.data

.text
	#sll lets you do multiplication in an efficient way
	addi $s0, $zero, 4
	
	#task: mult 4 * 4
	#3rd argument of sll is powers of 2
	sll $t0, $s0, 2 
	
	#print it:
	li $v0, 1
	move $a0, $t0
	syscall
	
	#output: 16