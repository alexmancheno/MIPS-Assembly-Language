#Name: Alex Mancheno
#Last modified date: 12/1/16
#Program name: MIPS HW #1, Program1
#
#Description: This program will prompt a value for int1 in the range (0, 20],
#another value for int2 in the range [-10, 15], display a message with the
#two numbers in increasing order, compute: int1 - int2 * 16, and finally a 
#message depending on whether the number is positive/negative along with
#the resulting value. If the user does not enter in values in their respective
#intervals, reprompt the user for another value:
#Pseudo-code (Java):	
#        int int1 = 0;
#        int int2 = 0;
#        Scanner in = new Scanner(System.in);
#        while (int1 != 999 || int2 != 999) {
#            System.out.print("Enter in first integer in range (0, 20]: ");
#            int1 = in.nextInt();
#            if (int1 <= 0 || int1 > 20) {
#                if (int1 == 999) return;
#                while (int1 <= 0 || int1 > 20) {
#                    System.out.print("Number has to be in range (0, 20]: ");
#                    int1 = in.nextInt();
#                    if (int1 == 999) return;
#                   
#                }
#            }
#            System.out.print("Enter in second integer in range [-10, 15]: ");
#            int2 = in.nextInt();
#            if (int2 < -10 || int2 > 15) {
#                if (int2 == 999) return;                
#                while (int2 < -10 || int2 > 15) {
#                    System.out.print("Number has to be in range [-10, 15]: ");
#                    int2 = in.nextInt();
#                    if (int2 == 999) return;
#                }
#            }
#            System.out.print("Your numbers in increasing order are: ");
#            if (int1 > int2) {
#                System.out.println(int1 + " " + int2);
#            } else {
#                System.out.println(int2 + " " + int1);
#            }
#
#            int result_value = int1 - int2 * 16;
#            if (result_value > 0) {
#                System.out.println("The result is a positive number equal to " + result_value);
#            } else if (result_value < 0) {
#                System.out.println("The result is a negative number equal to " + result_value);
#            }
#        }
#   }
#}

.data
#prompts asking user for input:
prompt1: .asciiz "Enter in first integer in range (0, 20]: "
prompt2: .asciiz "Enter in second integer in range [-10, 15]: "

#prompts for when values are out of range:
error_message1: .asciiz "Number has to be in range (0, 20]: "
error_message2: .asciiz "Number has to be in range [-10, 15]: "

#message for printing order of numbers in increasing order:
increasing_order_message: .asciiz"\nYour numbers in increasing order: " 

#messages for calculating 'result_value' (int1 - int2 * 16):
result_value_is_positive_message: .asciiz "The result is a positive number equal to "
result_value_is_negative_message: .asciiz "The result is a negative number equal to "

#for a space and a new-line:
space: .asciiz " "
new_line: .ascii "\n"

#registers:
# $t0 : int1
# $t1 : will have slt result from comparing int1 to other values 
# $t2 : int2
# $t3 : will have slt result from comparing int2 to other values
# $t4 : will have slt result from comparing int1 to int2
# $t5 : result_value (will have result of t1 - t2 * 16)
# $s0 : 999 (sentinel)
# $s1 : 20 (upper-limit of int1)
# $s2 : 15 (upper-limit of int2) 
.text
main: 
	li $s0, 999
	li $s1, 20
	li $s2, 15
int1:
	#print prompt1; ask user for int1 value:
	li $v0, 4
	la $a0, prompt1
	syscall
	j get_correct_int1_value
int2:
	#prompt user for int1 value and jump down to get_correct_int1_value label:		
 	li $v0, 4
 	la $a0, prompt2
 	syscall
 	j get_correct_int2_value
increasing_order:
	#print increasing_order_message before entering if/else block:
	li $v0, 4
	la $a0, increasing_order_message	
 	syscall
 	#$t4 gets 1 if int1 is < int2; 0 otherwise:
 	slt $t4, $t0, $t2
 	#if $t4 is > 0 (meaning int1 is < int2), then jump to following label:
 	bgtz $t4, int1_is_less_than_int2 
	#if we don't jump, we print int2 first:
	li $v0, 1
	move $a0, $t2
	syscall
	#print space between the numbers:
	li $v0, 4
	la $a0, space
	syscall	
	#print int2 second:
	li $v0, 1
	move $a0, $t0
	syscall
	#print new line:
	li $v0, 4
	la $a0, new_line
	syscall	
	#jump over the following label, over to the 'compute' label:
	j compute
int1_is_less_than_int2:
	#print int1 first:
	li $v0, 1
	move $a0, $t0
	syscall
	#print space between the numbers:
	li $v0, 4
	la $a0, space
	syscall		
	#print int2 second:
	li $v0, 1
	move $a0, $t2
	syscall
	#print new line:
	li $v0, 4
	la $a0, new_line
	syscall
compute:
	#multiply int2 by 16:
 	sll $t2, $t2, 4
 	#subtract int1 - int2 * 16 and store into $t5:
 	sub $t5, $t0, $t2
 	#jump to result_is_negative label if the result_value is negative:
 	bltz $t5, result_is_negative
 	#print result_value_is_positive_message before result_value:
 	li $v0, 4
 	la $a0, result_value_is_positive_message
 	syscall
 	#print result_value:
 	li $v0, 1
 	move $a0, $t5
 	syscall
	#print new line:
	li $v0, 4
	la $a0, new_line
	syscall
	#repeat entire process until user enters in 999: 	 	 	 	
 	j int1 
result_is_negative:
	#print result_value_is_negative_message before result_value:
	li $v0, 4
	la $a0, result_value_is_negative_message
	syscall 	 	
 	#print result_value:
 	li $v0, 1
 	move $a0, $t5
 	syscall
	#print new line:
	li $v0, 4
	la $a0, new_line
	syscall
	#repeat entire process until user enters in 999: 	 	 	 	
 	j int1 	 	
error1:
	#print error_message1 before reprompting user for new int1 value:
	li $v0, 4 
	la $a0, error_message1
	syscall
	#prompt user to put in correct value: 
get_correct_int1_value:	
	#save new int1 value:
	li $v0, 5
	syscall
	#move new int1 value into $t0:
	move $t0, $v0
	#if int1 is equal to 999, jump to end_program label:
	beq $s0, $t0, end_program
	#if int1 is less than or equal to 0, go error1 label to get new int1 value:	 
	blez $t0, error1
	#$t1 gets 1 if 20 is less than int1 (out of range):
	slt $t1, $s1, $t0
	#if $t1 is > 0 (meaning int1 is > 20), jump to error1 label and get new int1 value: :
	bgtz $t1, error1
	#return back to main:
	j int2
error2:
	#print error_message2 before reprompting user for new int2 value:
	li $v0, 4
	la $a0, error_message2
	syscall		
get_correct_int2_value:
	#save new int2 value:
	li $v0, 5
	syscall
	#move new int2 value into $t2:
	move $t2, $v0
	#if int2 is equal to 999, jump to end_program label:
	beq $s0, $t2, end_program
	#if int2 is less than -10, $t3 gets 1; 0 otherwise:
	slti $t3, $t2, -10
	#if $t3 is > 0 (meaning int2 is < -10), jump to error2 label and get new int2 value:
	bgtz $t3, error2
	#$t3 gets 1 if int2 is greater than 15; 0 otherwise:  
	slt $t3, $s2, $t2
	#if $t3 is > 0 (meaning int2 is > 15), jump to error 2 label and get new int2 value:
	bgtz $t3, error2
	j increasing_order					
end_program:
	#to end this program:
	li $v0, 10
	syscall