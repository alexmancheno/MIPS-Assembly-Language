.data
	myArray: .word 5: 10 # says that the array will contain 10 integers with the value of 5
	new_line: .asciiz "\n"

.text

main:

	#clear $t0 to 0:
	addi $t0, $zero, 0
	
	
	while:
		#exit loop if the index * 4 is greater than size of myArray:
		beq $t0, 40, exit
		
		lw $t6, myArray($t0)
		
		#print current number:
		li $v0, 1
		move $a0, $t6
		syscall
		
		#print new line:
		li $v0, 4
		la $a0, new_line
		syscall
		
		#update offset (increase index by 4): 
		addi $t0, $t0, 4		
		
		j while
	exit:
	
	#end program:
	li $v0, 10
	syscall
	
	
	
	