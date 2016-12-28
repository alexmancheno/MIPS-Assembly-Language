#Name: Alex Mancheno
#Last modified date: 12/1/16
#Program name: MIPS HW #1, Program2
#
#Description: prompt the user for a value 'size', enter a for-loop and iterate size - 1 times.
#Each iteration will print "for j equal " + j (current iteration number) + ", total equal " + 
#total = j + size.
#
#Pseudocode (Java):
#	for (int j = 1; j < size; j++) {
#		total = j + size;
#		println("for j equal " + j + ", total equal " + total);	
#	}
#
#Registers:
# $t0 : gets user input value, 'size'
# $t1 : j
# $t2 : slt result of comparing j to size
# $t3 : result from previous iteration:
# $s0 : total
.data

prompt: .asciiz "Enter in a number: "
first_half: .asciiz "for j equal "
second_half:.asciiz  ", total equal "
new_line: .asciiz "\n"

.text
main:

#print prompt, asking user to enter in an integer:
li $v0, 4
la $a0, prompt
syscall
#save entered number:
li $v0, 5
syscall
#move saved number to temporary register:
move $t0, $v0
li $t1, 1

for_loop:
	#store j + size into $t3:
	add $t3, $t1, $t0
	#total = total + (j + size (which is in $t3)):
	add $s0, $s0, $t3
	#print 1st half of message:
	li $v0, 4
	la $a0, first_half
	syscall
	#print j:
	li $v0, 1
	move $a0, $t1
	syscall
	#print 2nd half of message:
	li $v0, 4
	la $a0, second_half
	syscall
	#print total:
	li $v0, 1
	move $a0, $s0
	syscall
	#print new line:
	li $v0, 4
	la $a0, new_line
	syscall
	#add 1 to j:
	addi $t1, $t1, 1
	#$t2 is 1 if j is less than size; 0 otherwise:
	slt $t2, $t1, $t0
	#jump to for-loop label if $t2 is > 0 (meaning j is < size):  
	bgtz $t2, for_loop	
	#end program if $t2 is not > 0:
	li $v0, 10
	syscall