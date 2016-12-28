#Name: Alex Mancheno
#Last modified date: 12/14/16
#Program name: MIPS HW #2
#Description: 
#	
#	Func(n): if (n=0 or n=1)
#				then Func(n) = 4;
#			else Func(n) = (n+1)*Func(n-2);
#
#	Have n (n>= 0) be prompted from the user.
#	Check for correct input.
#		If n is not a natural number display an error message.
#		Else, display a result_message together with the numeric value of the
#		function.
#	Repeat
#
#
#registers used:
#	$v0 : will be used for all syscalls
#	$v1 : will be used for return value of func(n)
#	$t0 : will be used as the 'n' value that is passed into function
#	$a0 : will be used for printing either strings or integers with syscalls
#	$a1 : will contain $t1's value for the recursive function call

.data
	prompt_message: .asciiz "Enter a non-negative natural number: "
	error_message: .asciiz "The number entered was not a non-negative natural number! Try again: "
	result_message: .asciiz "Result of calculations: "
	new_line: .asciiz "\n"

.text

main:	

loop_until_sentinel:		
	#prompt user and get non-negative value from user:
	li $v0, 4
	la $a0, prompt_message
	syscall						#tell system to print prompt_message
	
	li $v0, 5 
	syscall						#tell system to read in value
	
	move $t0, $v0				#store read-in value into temporary register
	
	#branch to end_program if sentinel number (99) is entered:
	beq $t0, 99 , end_program
	
	#branch to get_correct_value if number entered is not a non-negative natural number:
	bltz $t0, get_correct_value
				
resume: 						#label to resume once correct value is entered pass what is in $t1 to $a1 before calling the function 	
	
	move $a1, $t0
	jal func					#func(n)
	
	#print result_message followed by the result of calling func(n):
	li $v0, 4
	la $a0, result_message
	syscall						#tell system to print result message
	
	li $v0, 1
	move $a0, $v1  
	syscall						#tell system to print the result of the return value of calling func(n) 
	
	li $v0, 4
	la $a0, new_line		
	syscall						#tell system to print a new line
	
	j loop_until_sentinel		#jump back to top of loop and reprompt user
	
	
get_correct_value:
	#print error_message, reprompt user, and get another value from the user:
	li $v0, 4
	la $a0, error_message
	syscall						#tell system to print error_message
	
	li $v0, 5
	syscall						#tell system to read in a value
	
	move $t0, $v0				#move into the temporary register the read-in value
	
	#branch to end_program if sentinel number (99) is entered:
	beq $t0, 99, end_program	
	
	#if incorrect number is entered again, loop to the top of this label:
	bltz $t0, get_correct_value

	j resume					#we only jump back to 'resume' if value entered in by user is >= 0			
				
func:
	#allocate space on stack and save current call's return address and argument value:
	addi $sp, $sp, -8 			#move pointer downwards enough for two values
	sw $ra, 0($sp)				#store current return address onto stack (1st of 2 values saved on every recursive call)
	sw $s2, 4($sp)				#store current value of $s2 onto stack (2nd of 2 values saved on every recursive call)
	
	li $v1, 4 					#load return value register with the value of the base case
	#base case (if n = 0, return 4):
	beq $a1, 0, finish_func
	#base case (if n = 1, return 4):
	beq $a1, 1, finish_func

	#func(n) = (n + 1) * func(n - 2):
	addi $s2, $a1, 1
	addi $a1, $a1, -2
	jal func					#jump back to top of this label and update what's in $ra
	
	#the current stacks calculations:	
	mul $v1, $v1, $s2			#give the return-value register the result of itself * previous stacks calculation
	
	finish_func:
		lw $ra, 0($sp)			#load back address of the stack we are jumping back to
		lw $s2, 4($sp)			#load value of current stack's value, which has now been calculated
		addi $sp, $sp, 8		#move stack pointer back up
		jr $ra					#jump back to address of previous stack
	
end_program:
	#code for ending program:
	li $v0, 10
	syscall	  					#tell system to end program  
