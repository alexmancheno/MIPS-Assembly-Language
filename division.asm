.data

.text
	addi $t0, $zero, 30
	addi $t1, $zero, 8

	div $t0, $t1
	
	mflo $s0 #quotient!
	mfhi $s1 #remainder!
	
	#print it!
	li $v0, 1
	move $a0, $s0
	syscall	