# Assembly starter file for Exercise 1

.data 0x0
  width:	.word 0
  height:	.word 0
  area:		.word 0
  perimeter:	.word 0
  
  widthPrompt:	.asciiz "Enter width (integer):\n"
  heightPrompt:	.asciiz "Enter height (integer):\n"
  areaIs:	.asciiz "Rectangle's area is "
  perimeterIs:	.asciiz "Its perimeter is "
  newline:	.asciiz "\n"
  


.text 0x3000

thefogwhile:

					# Print the prompt for width
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, widthPrompt 		# address of widthPrompt is in $a0
  syscall           			# print the string

				# Read the width
  addi	$v0, $0, 5			# system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  add	$8, $0, $v0			# copy the width into $8
  
  beq $v0, $0, exit           # break condition of while loop

				# Print the prompt for height
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, heightPrompt 		# address of heightPrompt is in $a0
  syscall           			# print the string
  
				# Read the height
  addi	$v0, $0, 5			# system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  add	$9, $0, $v0			# copy the height into $9
  
				# Calculate area
  mult	$8, $9				# multiply width * height
  mflo	$10				# bring the product into $10 (assume hi not needed)

                               # Calculate the perimeter
  addi $11, $0, 2                     # store two into a register
  mult $8, $11                        # multiplying the width twice
  mflo $12                            # bring the product into $12 (assume hi not needed)
  mult $9, $11                        # multiply the height twice
  mflo $13                            # bring the product into $13 (assume hi not needed)
  add  $13, $12, $13                  # add them together


				# Print "Rectangle's area is "
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, areaIs 			# address of areaIs string is in $a0
  syscall           			# print the string
  
				# Print the calculated area (in $10)
  addi 	$v0, $0, 1  			# system call 1 is for printing an integer
  add 	$a0, $0, $10 			# bring the area value from $10 into $a0
  syscall           			# print the integer
  
  				# Print a newline
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, newline 			# address of areaIs string is in $a0
  syscall           			# print the string
  
  				# Print "Its perimeter is"
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, perimeterIs		# address of perimeterIs string is in $a0
  syscall           			# print the string

  				# Print the calculated area (in $10)
  addi 	$v0, $0, 1  			# system call 1 is for printing an integer
  add 	$a0, $0, $13 			# bring the area value from $10 into $a0
  syscall           			# print the integer
  
   				# Print a newline
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, newline 			# address of areaIs string is in $a0
  syscall           			# print the string
  
  j thefogwhile               # Jump to the top of the main while loop

				# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
