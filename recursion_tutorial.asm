.data
	promptMessage: 	.asciiz "Enter a number to find its factorial: "
	resultMessage: 	.ascii "\nThe factorial of the number is "
	theNumber: 		.word 0
	theAnswer:		.word 0
	
.text
#	.global main
	main:
		#first prompt and read value from user:
		li $v0, 4
		la $a0, promptMessage
		syscall
				
		li $v0, 5
		syscall
		
		#put read in value into global variable:
		sw $v0, theNumber
		#next step is to call factorial function:
		lw $a0, theNumber
		jal findFactorial
		#after calling function, store result in global variable since
		#by convention, $v registers are used for return values:
		sw $v0, theAnswer
		#display the results:
		li $v0, 4
		la $a0, resultMessage
		syscall
		#display the message before displaying result:
		li $v0, 1
		lw $a0, theAnswer
		syscall
		#end program:
		li $v0, 10
		syscall
#---------------------------------------------------------------------------		
#findFactorial function:
#.global findFactorial
findFactorial:		  
		#allocate enough space on stack for two words:
		 subu $sp, $sp, 8 
		 sw $ra, 0($sp)
		 sw $s0, 4($sp)
		 
		 #base case:
		 li $v0, 1
		 beq $a0, 0, factorialDone
		 
		 #findFactorial(theNumber - 1) 
		 move $s0, $a0
		 sub $a0, $a0, 1
		 jal findFactorial
		 
		 #the magic happens here
		 mul $v0, $s0, $v0
		 
		 factorialDone:
		 	#restore return address from stack:
		 	lw $ra, 0($sp)
		 	#loading the value of the local variable back to the register from the stack:
		 	lw $s0, 4($sp)
		 	#we have to restore the stack:
		 	addu $sp, $sp, 8
		 	jr $ra
		 	
		             
		    
		        
		            
