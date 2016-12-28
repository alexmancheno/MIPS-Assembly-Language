.data
	message: .asciiz "The number is less than the other."
.text
	addi $t0, $zero, 1
	addi $t1, $zero, 200
	
	#1 for true; 0 for false
	slt $s0, $t0, $t1
	#check result:
	bne $s0, $zero, printMessage
	
	#end program:
	li $v0, 10
	syscall
	
	printMessage: 
		li $v0, 4
		la $a0, message
		syscall
		#jr $ra