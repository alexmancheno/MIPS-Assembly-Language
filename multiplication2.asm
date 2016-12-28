.data 
	

.text
	addi $t0, $zero, 2000
	addi $t1, $zero, 100
	
	#we're going to use mult; takes two registers
	#look at registers 'lo' and 'hi'
	mult $t0, $t1
	
	#move from lo
	mflo $s0
	
	#displays the product to the screen
	li $v0, 1
	#can also use: add $a0, $zero, $s0
	move $a0, $s0 
	syscall
	
	