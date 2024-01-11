.data

pattern: 	.space 17	# array of 16 (1 byte) characters (i.e. string) plus one additional character to store the null terminator when N=16

N_prompt:	.asciiz "Enter the number of bits (N): "
newline: 	.asciiz "\n"
null_term:	.ascii "\0"
one:		.ascii "1"
zero:		.ascii "0"

.text

main:				
	la $s0, pattern			# store address of array pattern		
	add $s1, $0, $0			# Intialize variable "N", set to 0
	add $s2, $0, $0			# Intialize variable "n", set to 0
	
	addi $v0, $0, 4			# System call (4) to print string 
	la $a0, N_prompt		# Put string memory address in register
	syscall				# Print String.
	
	addi $v0, $0, 5			# System call (5)) to get integer from user, stor into same register for earlier print statement 
	syscall				# Get user input for number of bits.
	add $s1, $0, $v0		# Copy into a 'n' register, to reuse $v0
	add $s2, $0, $s1
	
	lb $a0, null_term		# load the address of the null terminator to register $a0
	sb $a0, 0($s2)			# parameter[n] = "\0"
	add $t9, $0, $0
	
	jal bingen
	j exit
#----------------------------------------------
#
# Fully Functional C Code for reference
#
# include<stdio.h>
# char pattern[17] = {0};
# void bingen( unsigned int N, unsigned int n );
#
# int main( int argc, char** argv ) {
#
#	 unsigned int N = 0;
#	 // You can assume the user enters a
#	 // value of N >= 1 and N <= 16.
#	 // i.e. no error checking is necessary
#	 printf( "Enter the number of bits (N): ");
#	 scanf("%u", &N );
# 
#	 unsigned int n = N;
#	 pattern[N] = '\0'; // Null terminate the string
#			    // N in $s1 and n in $s2, pattern array in $s0		 
#	 bingen( N, n );
#	 return 0;
# }
#
# void bingen( unsigned int N, unsigned int n ) {
#    if ( n > 0 ) {
#        pattern[N-n] = '0';
#        bingen( N, n - 1 );
#        pattern[N-n] = '1';
#        bingen( N, n - 1 );
#    } else printf( "%s\n", pattern );
# }
#
#----------------------------------------------

# TODO: Main Program

# TODO: Recursive Function
bingen:
	addi $sp, $sp, -12		# intialize space on stack
	sw $ra, 8($sp)			# store current n value to the stack
	sw $fp, 4($sp)
	sw $s2, 0($sp)
	addi $fp, $sp, 8
	

	sgt $t0, $s2, $0		# if (n > 0) $t0 = 1 (true), $t0 = 0 (false)
	beq $t0, $0, else
	
	sub $t1, $s1, $s2		# Copy 'N-n' into a register
	
	lb $t3, zero
	sb $t3, 0($t1)			# parameter[N-n] = "0"
	
	
	subi $s2, $s2, 1		# Set n to n-1
	jal bingen

	lw $s2, 0($sp)
		
	sub $t1, $s1, $s2		# Copy 'N-n' into a register
	lb $t3, one			# save the 1 value
	sub $t5, $s1, $s2		# 
	sb $t3, 0($t5)			# parameter[N-n] = "1"
	subi $s2, $s2, 1		# Set n to n-1
	jal bingen
	lw $s2, 0($sp)
	j final
else:
	addi $t9, $t9, 1
	
	addi $v0, $0, 4			# System call (4) to print string 
	la $a0, pattern			# Put string memory address in register
	syscall				# Print String.
	
	addi $v0, $0, 4			# System call (4) to print string 
	la $a0, newline			# Put string memory address in register
	syscall	
				# Print String.
final:

	addi $sp, $fp, 4
	lw $ra, 0($fp)
	lw $fp, -4($fp)
	jr $ra

exit:    
                 
	addi $v0, $0, 10      	# system call code 10 for exit
  	syscall               	# exit the program
