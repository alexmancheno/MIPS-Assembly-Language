.data
	message: .asciiz "The numbers are equal. "
	message2: .asciiz "Nothing happened."

.text
main:

	addi $t0, $zero, 5
	addi $t1, $zero, 20
	
	beq $t0, $t1, label

	#To end the program:
	li $v0, 10
	syscall