.data
	message: .asciiz "After while loop ends"
	space  : .asciiz ", "
.text
	main:
	#pseudo: 
	#	int i = 0
	#	while i < 10:
	#		i++
		
	
		addi $t0, $zero, 0 #making sure $t0 has the value 0, if they do get 0 by default
		
			while:
				bgt $t0, 10, exit #exit loop if $t0 is greater than 10
				jal printNumber
				
				addi $t0, $t0, 1 #equivalent to i++		
			
				j while	#jump to top of current label
			exit:
			
			#print message after loop:
			li $v0, 4
			la $a0, message
			syscall
			
			#end program:
			li $v0, 10
			syscall
			
		printNumber:
			#prints number:
			li $v0, 1
			add $a0, $t0, $zero
			syscall 
			
			#prints space:
			li $v0, 4
			la $a0, space
			syscall
			
			jr $ra #return to caller
		
				
