.data 
	message: .asciiz "Hi, everybody.\nMy name is Alex.\n"
.text 
	main: 
		#to jump to function:
	jal displayMessage
	
		#put '5' into $s0:
	addi $s0, $zero 5
		
		#print '5' onto screen:
	li $v0, 1
	add $a0, $zero, $s0 #can also use: move $a0, $s0
	syscall
		
	#to tell the system that the program is done (now mandatory):
	li $v0, 10
	syscall
	
	#to display text on screen:
	displayMessage:
		li $v0, 4
		la $a0, message
		syscall
		#to go back to the caller:
		jr $ra
