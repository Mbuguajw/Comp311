# COMP 311: SP 2022 - Lab 6

## Lab 6: Procedure calls and sorting strings

### Background Information

Now that you have gotten used to looping and arrays in MIPS, we will test your mastery further by asking you to work with strings! As you surely learned through your experience in C, strings are more complicated to sort than numbers. To aid you in this task, you will write your first procedures in MIPS, which will help you compare and swap your strings. 

### Coding Problem

In this assignment, you will write a MIPS program that loads strings into an array, sorts them in alphabetical order (in terms of ASCII character code), and output your sorted array of strings, line by line. In particular, the step-by-step procedure is:

1. Prompt the user to enter a number between 1 and 20 (inclusive), which will be the size of the array in question.
2. Read in the string that should be stored at every index of the array.
- You may assume that the string entered will be 100 characters or fewer, including the newline and null terminator.
3. Prompt the user to enter the value of the string that they would like to search for within the array.
4. Implement a bubble sort that will order the strings in the array in alphabetical order.
- You will need to write two procedures to accommodate this functionality. The specifics of these two procedures are outlined in the **Required Procedures** section below.
5. Output your sorted array of strings in alphabetical order.
6. Terminate the program.


### Required Procedures

#### lab_swap_strings

- Arguments: $a0 = starting address of strA, $a1 = starting address of strB.
- This procedure will be used in `Step 4` during your sort.
- This procedures switches the contents of two elements of your array. For example, if the string starting at $a0 = "hello" and the string starting at $a1 = "goodbye", then `lab_swap_strings($a0, $a1)` will result in the string starting at address $a0 = "goodbye" and the string starting at address $a1 = "hello".
- To accomplish this, you should swap each character between both strings. Note: ensure the swapped strings are null terminated correctly after the swap.

#### lab_compare_strings
- Arguments: $a0 = starting address of strA, $a1 = starting address of strB.
- Return value: $v0 should contain either -1, 0, or 1 depending on the result of the string comparison.
- This function will be used for sorting in `Step 4`.
- The return value stored in $v0 should be -1, 0, or 1 depending on whether strA < strB, strA == strB, or strA > strB.
- Return -1 if strA < strB. 
- Return 0 if strA == strB.
- Return 1 if strA > strB.
- In order to determine which string is "greater" than another alphabetically, utilize their [ASCII](http://www.asciitable.com/) character to integer encoding values. Compare character-by-character starting with the beginning of each string, and continue until you find a differing character or reach the end of one of the strings See the following examples:

- apple < apply. The first four characters are the same, and then e < y since the ASCII integer value for character e is 101 and the ASCII integer value for character y is 121. Return -1.
- apple > applY. The first four characters are the same, and then e > Y since the ASCII integer value for character e is 101 and the ASCII integer value for character Y is 89. Return 1.
- apple == apple. Each character is the same. Return 0.
- app < apple. The first three characters are the same, and then there are no more characters left to compare. This technically means that the fourth character of “app” is the null terminator, which has an ASCII integer value of 0 while the ASCII integer value for character l is 108. 0 < 108, so we return -1.

### Assignment Instructions

- Please download the provided lab6.asm le from the repo.
- For ease of use, all portions of the code relating to I/O have already been provided for you and you should not modify them. Additionally, numerous comments are provided which will guide you through the assignment.
- We **strongly** encourage that you implement a minimal stack frame in your procedure calls. Take a look at 3/31, 4/5 PDF Part 2 lecture notes, where we show how to create "Template 1: leaf procedure with minimal stack frame". Using this template, or even other templates in that lecture will be very useful for correctly invoking procedures. If you learn it now, it will make the next lab easier. 
- Please complete the MIPS code in the three TODO sections:

- PART 1 in which you will complete the body of the main procedure.
- PART 2 in which you will complete the body of the string swap procedure.
- PART 3 in which you will complete the body of the string compare procedure.

### Example I/O

The following consist of two different input and output case examples that demonstrate the expected output for the above program. 

Example 1
```
Enter array size [between 1 and 20]: 5 
A[0] = Super Mario Galaxy
A[1] = Wii Sports
A[2] = Animal Crossing City Folk
A[3] = Legend of Zelda Skyward Sword 
A[4] = Donkey Kong Country Returns 
The sorted array of strings is...
A[0] = Animal Crossing City Folk
A[1] = Donkey Kong Country Returns
A[2] = Legend of Zelda Skyward Sword 
A[3] = Super Mario Galaxy
A[4] = Wii Sports
```

Example 2
```
Enter array size [between 1 and 20]: 10 
A[0] = iPhone
A[1] = Nintendo Switch
A[2] = Apple Pencil
A[3] = Fitbit
A[4] = MacBook
A[5] = iPad
A[6] = Samsung Galaxy
A[7] = Thinkpad
A[8] = amazon Alexa
A[9] = Surface Pro
The sorted array of strings is...
A[0] = Apple Pencil
A[1] = Fitbit
A[2] = Macbook
A[3] = Nintendo Switch
A[4] = Samsung Galaxy
A[5] = Surface Pro
A[6] = Thinkpad
A[7] = amazon Alexa
A[8] = iPad
A[9] = iPhone
```

Note that lowercase characters have greater ASCII values than uppercase characters.

### Program Specications
- Exception / Error handling is not required. That is, assume only valid values are entered by the user. Valid values consist of strings of 100 characters or less.
- Strings may contain ASCII values in the ranges [32] (space), [48-57] (numbers), and [65-122] (letters). Additionally, the newline and null terminator are valid characters.

#### Important:

- The input and output must be the same as the examples provided above, in terms of: spelling, spacing, cases, etc.
- We will use an auto-grader that compares your input-output solution with the correct one. You will lose points if they are formatted differently.


### Assignment Submission and Grading Rubric

Assignment submissions will be made through [GradeScope](https://www.gradescope.com).

You should already be enrolled in the COMP 311 Spring 2022 course on GradeScope. If you are not, please self enroll with entry code **X3PR75**. If you're unable to self enroll, please contact your cohort leader and we'll manually add you.

To submit your assignment, please follow the basic steps provided below. If you're unable to perform any of the steps, please reach out to your **cohort** and **cohort leader** as soon as possible. That is, give yourself time to resolve any technical issues using Github, Github Desktop, and Gradescope well before the assignment due date.

1. Submit modifications using the **commit** Github Desktop instructions.
2. Update remote (origin) repository using the **push** Github Desktop instructions.
3. Go to the COMP 311 course in GradeScope and click on the assignment called **Lab 06**.
4. Click on the option to **Submit Assignment** and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to GradeScope. When this occurs, **make sure to grant access to the Comp311-SP22 organization**.
5. You should see a list of your public repositories. Select the one named **lab-06-yourname** and submit it.
6. Your assignment should be autograded within a few seconds and you will receive feedback.
7. If you receive all the points, then you have completed this lab assignment! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.

