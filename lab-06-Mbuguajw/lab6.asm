#==================================================================================#
# DATA - DO NOT MODIFY
.data 
	A:			.space 2000  	# create string array with 20 elements * 100 char per element ( A[20][100] )
	num_strings_prompt: 	.asciiz		"Enter array size [between 1 and 20]: "
	print_prompt:		.asciiz		"The sorted array of strings is...\n"
	array_start:		.asciiz		"A["
	array_end:		.asciiz		"] = "
#==================================================================================#	
	
.text
#==================================================================================#
# SCANNING IN INPUTS - DO NOT MODIFY
main: 
  	
	add $s1, $0, $0			# Initialize variable "size" ($s1) and set to 0.
	add $t0, $0, $0			# Initialize variable "i" ($t0) and set to 0.
	add $t1, $0, $0			# Initialize variable "j" ($t1) and set to 0.	
	add $t2, $0, $0			# Initialize variable "offset " (t2) and set to 0.

	addi $v0, $0, 4  			# System call (4) to print string.
	la $a0, num_strings_prompt 		# Put string memory address in register $a0.
	syscall           			# Print string.
	
	addi $v0, $0, 5			# System call (5) to get integer from user and store in register $v0.
	syscall				# Get user input for variable "size".
	add $s1, $0, $v0			# Copy to register $s1, b/c we'll reuse $v0.


scan_loop:
	
	beq $t0, $s1, bubble_sort		# End loop if i == size ($t0 == $s1).
	
	addi $v0, $0, 4			# System call (4) to print string.
	la $a0, array_start			# Put string memory address in register $a0.
	syscall				# Print string.
	
	addi $v0, $0, 1			# System call (1) to print integer.
	add $a0, $0, $t0			# Put integer value in register $a0.
	syscall				# Print integer.
	
	addi $v0, $0, 4			# System call (4) to print string.
	la $a0, array_end			# Put string memory address in register $a0.
	syscall				# Print string.
	
	li $v0, 8				# System call (8) to scan in string from user and store in register $v0.
	la $a0, 0($t2)			# Read A[i] (stored at address $s0 and store in $a0.
	li $a1, 100 			# Max character allowance per string.
	syscall
	
	addi $t2, $t2, 100			# Increment address of $t2 to store next string.
	addi $t0, $t0, 1			# i = i+1
	
	j scan_loop
#==================================================================================#

# TO-DO
bubble_sort: 

	add $t3, $0, $0			# Initialize variable "t" ($t3) and set to 0.
	addi $s1, $s1, -1		# making size = size - 1
	
forloop1:
	
	slt $t4, $t0, $s1		# if( i < size - 1) $t1 = 1 (true), else $t1 = 0 (false)
	beq $t4, $0, print
	j forloop2			# jump to beginning og next nested loop, forloop2
	
forloop2:
	
	sub $t5, $s1, $t0		# subtract i from size  1
	slt $t6, $t1, $t5		# if( j < size - 1 - i) $t6 = 1 (true), else $t6 = 0 false
	beq $t6, $0, iteration1
	
	mul $t6, $t1, 100		# increment by one letter
	add $a0, $0, $t6		# A[j] into $a0
	addi $t2, $t2, 100		# j + 1
	add $a1, $0, $t6		# A[j+1] into $a1
	
	j lab_swap_strings
	
	#sll $t7, $t1, 2		# multiply j * 4 (4-byte word offset)
	#add $t8, $s0, $t7		# A[j] = address of A + ( j * 4 )
	#addi $t9, $t8, 4		# A[j+1] = address of A + ( (j+1) * 4 )
	#lw $s4, 0($t8)			# A[j] = $t8 (register-indirect addressing mode)
	#lw $s5, 0($t9)			# A[j+1] = $t9 (register-indirect addressing mode)

iteration2:	
	addi $t4, $t4, 1		# i = i + 1
	j forloop2			# jump to beginning of loop	
iteration1:
	addi $t0, $t0, 1		# j = j + 1
	j forloop1			# jump to beginning of loop
#==================================================================================#
# Perform bubble sort such that strings are ordered alphabetically by ASCII value.

# YOUR CODE HERE
 
# The above code has already created array A and A[0] to A[size-1] have been 
# entered by the user. After the bubble sort has been completed, the values in
# A are sorted in increasing order, i.e. A[0] holds the smallest value and 
# A[size -1] holds the largest value.
#
#	int t = 0;
#	
#	for ( int i=0; i<size-1; i++ ) {
#		for ( int j=0; j<size-1-i; j++ ) {
#			if ( A[j] > A[j+1] ) {
#				t = A[j+1];
#				A[j+1] = A[j];
#				A[j] = t;
#			}
#		}
#	}
#==================================================================================#

#==================================================================================#
# TO-DO:
lab_compare_strings:

	add $t3, $0, $0 	# create i variable
	addi $t4, $0, 99	
	
forloop:
	slt $t5, $t3, $t4	
	beq $t5, $0, exiting	
	add $t5, $t3, $a0	
	add $t6, $t3, $a1	
	
	lb $s3, 0($t5)		#load value of ath character of a0
	lb $s4, 0($t6)		#load value of ath character of a1
	
	beq $s3, $s4, iterator	#if(A[j] < A[j+1]), then iterate through loop
	
	slt $s5, $s3, $s4	# if(A[j] < A[j+1]), then -1
	bne $s5, $0, AJ 	
	
	slt $s5, $s4, $s3	#a1<a0
	bne $s5, $0, AJ1
	
iterator:
	addi $t3, $t3, 1	# Increase i by one 
	j for_loop
AJ:
	addi $v0, $0, -1	#if(A[j] < A[j+1]), then -1
	jr $ra
AJ1:
	addi $v0, $0, 1		#if(A[j] > A[j+1]), then 1
	jr $ra	
exiting:
	add $v0, $0, $0		#a0==a1 then return 0
	jr $ra

	# $a0 = Starting address of A[j]
	# $a1 = Starting address of A[j+1]
	# $v0 = Return value of procedure (-1, 0, or 1).
	
#==================================================================================#
# This procedures switches the contents of two elements of your array. For example,
# if the string starting at $a0 = "hello" and the string starting at $a1 = "goodbye",
# then lab swap strings($a0, $a1) will result in the string starting at address $a0 =
# "goodbye" and the string starting at address $a1 = "hello".

# YOUR CODE HERE

#==================================================================================#


#==================================================================================#
# TO-DO:
lab_swap_strings:
	
	add $sp, $sp, -8
	sw $t8, 4($sp)
	sw $t9, 0($sp)
	addi $t9, $sp, 4
	
	addi $s6, Ss6, 0		# declaring space for A[j]
	addi $s7, $s7, 0		# declaring space for A[j+1]
	lb $s6, 0($a0)			# A[j] memory address
	lb $s7, 0($a1)			# A[j+1] memorry address
	
	jal lab_compare_strings
	
	slt $a3, $v0, $0			# if(A[j] < A[j+1]), then -1 so NO swap
	beq $a3, $0, return		# not the same? Then jump to not equal
	
	slt $a3, $0, $v0			# if(A[j] > A[j+1]), then 1 so swap
	beq $a3, $0, swapstring		# not the same? Then jump to not equal
	add $s3, $0, $0			# an 'index' for individual letters
	j return
	
swapstring:
	addi $s5, $0, 99		# First indexing letter
	slt $s4, $s3, $s5		# When 'index' is less than the letter being compared to
	beq $s4, $0, return
	
	
	add $s2, $s3, $a0		# storing the address of the indexed letter of the A[j] word
	add $t6, $s3, $a1		# storing the address of the indexed letter of the A[j+1] word	
	lb $s6, 0($s2)			# loading the indexed letter of the A[j] word
	lb $s7, 0($t6)			# loading the indexed letter of the A[j+1] word
	move $, 
	sb $a2, 0($t6)
	sb $a3, 0($s2)
	
	addi $s3, $s3, 1		# increment index by 1
	j swapstring			# on to the next letter!!
return:
	addi $sp, $t9, 4
	lw $ra, 0($fp)
	lw $fp, -4($sp)
	jr $ra
	# $a0 = Starting address of A[j]
	# $a1 = Starting address of A[j+1]
# This procedures switches the contents of two elements of your array. For example,
# if the string starting at $a0 = "hello" and the string starting at $a1 = "goodbye",
# then lab swap strings($a0, $a1) will result in the string starting at address $a0 =
# "goodbye" and the string starting at address $a1 = "hello".

# YOUR CODE HERE

#==================================================================================#


#==================================================================================#
# OUTPUTTING RESULTS - DO NOT MODIFY
print:
		addi $t1, $0, 0		# Initialize variable "i" ($t1) and set to 0
		addi $t2, $0, 100		# Store 100 in $t2 for multiplicative factor.
		
		addi $v0, $0, 4		# System call (4) to print string.
		la $a0, print_prompt	# Put string memory address in register $a0.
		syscall			# Print string.
print_loop:
		beq $t1, $s1, exit		# We are done printing once we have printed the same number of strings as the size.
		
		addi $v0, $0, 4		# System call (4) to print string.
		la $a0, array_start		# Put string memory address in register $a0.
		syscall			# Print string.
	
		addi $v0, $0, 1		# System call (1) to print integer.
		add $a0, $0, $t1		# Put integer value in register $10.
		syscall			# Print integer.
	
		addi $v0, $0, 4		# System call (4) to print string.
		la $a0, array_end		# Put string memory address in register $a0.
		syscall			# Print string.
		
		
		mult $t1, $t2		# Multiply i by 100 to get appropriate address of A[i].
		mflo $a0			# Put memory address of A[i] in register $a0.
		li $v0, 4			# Print string.

		syscall 	

		addi $t1, $t1, 1 		# Increment i by 1.

	j print_loop

exit:
  	addi	$v0, $0, 10		# sys call 10 is for exit
  	syscall
#==================================================================================#
