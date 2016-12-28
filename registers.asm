.data
	newLine: .asciiz "\n"

.text
	#$t registers are callee saved; functions can change values in 
	#registers! $s registers convention says to save old value of 
	#the caller to the stack because functions cannot change $s0 
	#registers (?)
	
	#the output will be:
	#40
	#10
main: 
	
	addi $s0, $zero, 10
	
	#always use jal to call a function:
	jal increaseMyRegister
	
	#print new line before printing $s0 again:
	li $v0, 4
	la $a0, newLine
	syscall
	
	jal printTheValue
	
	#This line is going to signal end of program:
	li $v0, 10
	syscall
	
	increaseMyRegister: 
		addi $sp, $sp, -8
		#this says to save the value into $s0 to the first location
		#in the stack pointer:
		sw $s0, 0($sp)
		sw $ra, 4($sp)
		
		#now we can do whatever we want to $s0:
		addi $s0, $s0, 30
		
		#nested procedure:
		jal printTheValue
		
		#restore values and stack pointer
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		
		jr $ra
		
	printTheValue:
		#print new value in function!
		li $v0, 1
		move $a0, $s0
		
		jr $ra
				
	
		
		
		
		
		
