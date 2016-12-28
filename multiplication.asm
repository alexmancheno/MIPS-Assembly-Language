.data

.text
	addi $s0, $zero, 10
	addi $s1, $zero, 4
	
	#greatest range is to multiply two integers that are 16 bits long
	#to multiply bigger numbers, you need another instruction
	mul $t0, $s0, $s1
	
	#Display the product
	li $v0, 1
	move $a0, $t0
	syscall