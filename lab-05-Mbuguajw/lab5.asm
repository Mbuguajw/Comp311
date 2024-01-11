.data

A:			.space 80  	# create integer array with 20 elements ( A[20] )
size_prompt:		.asciiz 	"Enter array size [between 1 and 20]: "
array_prompt:		.asciiz 	"A["
sorted_array_prompt:	.asciiz 	"Sorted A["
close_bracket: 		.asciiz 	"] = "
search_prompt:		.asciiz		"Enter search value: "
not_found:		.asciiz		" not in sorted A"
newline: 		.asciiz 	"\n" 	

.text

main:	
	# ----------------------------------------------------------------------------------
	# Do not modify
	#
	# MIPS code that performs the C-code below:
	#
	# 	int A[20];
	#	int size = 0;
	#	int v = 0;
	#
	#	printf("Enter array size [between 1 and 20]: " );
	#	scanf( "%d", &size );
	#
	#	for (int i=0; i<size; i++ ) {
	#
	#		printf( "A[%d] = ", i );
	#		scanf( "%d", &A[i]  );
	#
	#	}
	#
	#	printf( "Enter search value: " );
	#	scanf( "%d", &v  );
	#
	# ----------------------------------------------------------------------------------
	
	la $s0, A			# store address of array A in $s0
  
	add $s1, $0, $0			# create variable "size" ($s1) and set to 0
	add $s2, $0, $0			# create search variable "v" ($s2) and set to 0
	add $t0, $0, $0			# create variable "i" ($t0) and set to 0

	addi $v0, $0, 4  		# system call (4) to print string
	la $a0, size_prompt 		# put string memory address in register $a0
	syscall           		# print string
  
	addi $v0, $0, 5			# system call (5) to get integer from user and store in register $v0
	syscall				# get user input for variable "size"
	add $s1, $0, $v0		# copy to register $s1, b/c we'll reuse $v0
  
prompt_loop:
	# ----------------------------------------------------------------------------------
	slt $t1, $t0, $s1		# if( i < size ) $t1 = 1 (true), else $t1 = 0 (false)
	beq $t1, $0, end_prompt_loop	 
	sll $t2, $t0, 2			# multiply i * 4 (4-byte word offset)
				
  	addi $v0, $0, 4  		# print "A["
  	la $a0, array_prompt 			
  	syscall  
  	         			
  	addi $v0, $0, 1			# print	value of i (in base-10)
  	add $a0, $0, $t0			
  	syscall	
  					
  	addi $v0, $0, 4  		# print "] = "
  	la $a0, close_bracket		
  	syscall					
  	
  	addi $v0, $0, 5			# get input from user and store in $v0
  	syscall 			
	
	add $t3, $s0, $t2		# A[i] = address of A + ( i * 4 )
	sw $v0, 0($t3)			# A[i] = $v0 
	addi $t0, $t0, 1		# i = i + 1
		
	j prompt_loop			# jump to beginning of loop
	# ----------------------------------------------------------------------------------	
end_prompt_loop:

	addi $v0, $0, 4  		# print "Enter search value: "
  	la $a0, search_prompt 			
  	syscall 
  	
  	addi $v0, $0, 5			# system call (5) to get integer from user and store in register $v0
	syscall				# get user input for variable "v"
	add $s2, $0, $v0		# copy to register $s2, b/c we'll reuse $v0

	# ----------------------------------------------------------------------------------
	# TODO:	PART 1
	#	Write the MIPS-code that performs the the C-code (bubble sort) shown below.
	#	The above code has already created array A and A[0] to A[size-1] have been 
	#	entered by the user. After the bubble sort has been completed, the values in
	#	A are sorted in increasing order, i.e. A[0] holds the smallest value and 
	#	A[size -1] holds the largest value.
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
	#			
	# ----------------------------------------------------------------------------------

	add $s3, $0, $0			# create variable "t" ($s3) and set to 0
	add $t0, $0, $0			# create variable "i" ($t0) and set to 0
	addi $s1, $s1, -1		# making size = size - 1
	
for_loop_1:
	
	slt $t1, $t0, $s1		# if( i < size - 1) $t1 = 1 (true), else $t1 = 0 (false)
	beq $t1, $0, next
	add $t4, $0, $0			# create variable "j" ($t4) and set to 0
	j for_loop_2			# jump to beginning of next nested loop, for_loop_2
	
for_loop_2:

	sub $t5, $s1, $t0		# subtract i from size - 1 
	slt $t3, $t4, $t5		# if( j < size - 1 - i) $t3 = 1 (true), else $t3 = 0 (false)
	beq $t3, $0, iteration1
	
	sll $t7, $t4, 2			# multiply j * 4 (4-byte word offset)
	add $t8, $s0, $t7		# A[j] = address of A + ( j * 4 )
	addi $t9, $t8, 4		# A[j+1] = address of A + ( (j+1) * 4 )
	lw $s4, 0($t8)			# A[j] = $t8 (register-indirect addressing mode)
	lw $s5, 0($t9)			# A[j+1] = $t9 (register-indirect addressing mode)

	
	slt $t6, $s5, $s4		# if( A[j] > A[j+1] ) $t6 = 1 (true), else $t6 = 0 (false)
	beq $t6, $0, iteration2	# skip right to the iteration of counter variables
	
	add $s3, $s5, $0		# set variable "t" equal to the value at A[j+1]
	sw $s4, 0($t9)			# A[j+1] = A[j]
	sw $s3, 0($t8)			# A[j] = t

iteration2:	
	addi $t4, $t4, 1		# i = i + 1
	j for_loop_2			# jump to beginning of loop	
iteration1:
	addi $t0, $t0, 1		# j = j + 1
	j for_loop_1			# jump to beginning of loop

	# ----------------------------------------------------------------------------------
	# TODO:	PART 2
	#	Write the MIPS-code that performs the C-code (binary search) shown below.
	#	The array A has already been sorted by your code above in PART 1, where A[0] 
	#	holds the smallest value and A[size -1] holds the largest value, and v holds 
	# 	the search value entered by the user
	#	
	#	int left = 0;
	# 	int right = size - 1;
	#	int middle = 0;
	#	int element_index = -1;
 	#
	#	while ( left <= right ) { 
      	#
      	#		middle = left + (right - left) / 2; 
	#
      	#		if ( A[middle] == v) {
      	#    			element_index = middle;
      	#    			break;
      	#		}
      	#
      	#		if ( A[middle] < v ) {
      	#    			left = middle + 1; 
      	#		} else {
      	#    			right = middle - 1;
    	#		} 
	#	}
	#
	#	if ( element_index < 0 ) {
    	#		printf( "%d not in sorted A\n", v );
    	#	} else {
    	#		printf( "Sorted A[%d] = %d\n", element_index, v );
    	#	}
	# ----------------------------------------------------------------------------------
next:
	add $t7, $0, $0			# create variable "left" ($t7) and set to 0
	add $t8, $0, $s1		# create variable "right" ($t8) and set to size - 1
	add $t0, $0, $0			# create variable "middle" ($t0) and set to 0
	addi $t4, $0, -1		# create variable "element_index" ($t4) and set to -1
	
while:
	
	sle $t3, $t7, $t8		# if( left <= right) $t3 = 1 (true), else $t3 = 0 (false)
	beq $t3, $0, if
	
	sub $t0, $t8, $t7 		# middle = right - left
	sra $t0, $t0, 1			# middle = (right - left) / 2
	add $t0, $t0, $t7		# middle = left + ((right - left) / 2)
	
	sll $t1, $t0, 2			# multiply middle * 4 (4-byte word offset)
	#add $t2, $s0, $t1		# A[middle] = address of A + ( middle * 4 )
	lw $s6, 0($t1)			# A[middle] = $t2 (register-indirect addressing mode)
	
	seq $t1, $s6, $s2		# if( A[middle] == v) $t1 = 1 (true), else $t1 = 0 (false)
	beq $t1, $0, nested_if
	add $t4, $0, $t0		# element_index = middle
	j if
	
nested_if:
	slt $t1, $s6, $s2		# if( A[middle] < v) $t1 = 1 (true), else $t1 = 0 (false)
	beq $t1, $0, nested_else
	addi $t7, $t0, 1		# left = middle + 1
	j while

nested_else:	
	addi $t8, $t0, -1		# right = middle -1
	
	j while				# loop again

if:

	slt $t3, $t4, $0		# if( element_index < 0) $t3 = 1 (true), else $t3 = 0 (false)	
	beq $t3, $0, else
	
	addi $v0, $0, 1			# print	value of v (in base-10)
  	add $a0, $0, $s2			
  	syscall	
  	
  	addi $v0, $0, 4  		# print " not in sorted A"
  	la $a0, not_found		
  	syscall	
  	
  	addi $v0, $0, 4  		# print "\n"
  	la $a0, newline		
  	syscall
  	
  	j exit

else:
	addi $v0, $0, 4  		# print "Sorted A["
  	la $a0, sorted_array_prompt		
  	syscall	
  	
  	addi $v0, $0, 1			# print	value of element_index (in base-10)
  	add $a0, $0, $t4			
  	syscall	
  	
  	addi $v0, $0, 4  		# print "] = "
  	la $a0, close_bracket		
  	syscall	
  	
  	addi $v0, $0, 1			# print	value of v (in base-10)
  	add $a0, $0, $s2			
  	syscall	
  	
  	addi $v0, $0, 4  		# print "\n"
  	la $a0, newline		
  	syscall	
  	
  	j exit
# ----------------------------------------------------------------------------------
# Do not modify the exit
# ----------------------------------------------------------------------------------
exit:                     
  	addi $v0, $0, 10      		# system call (10) exits the program
  	syscall               		# exit the program
  
