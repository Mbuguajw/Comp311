# COMP 311: Spring 2022 - Lab 05

## Bubble Sort and Binary Search

### Computing Environment and MARS

Ensure your environment is set up, i.e. the MARS executable works on your laptop and the memory settings are set to “Compact, Data at Address 0”. If you are having difficulties with the setup, please post to Piazza - there is probably somebody else with a similar issue. If you cannot resolve the issue, please bring to the LA, TA, or instructor’s attention in Office Hours.

### Lab Objectives

To gain experience with comparison, branch, and jump instructions in MIPS

### Coding Problem

In this assignment, you will write a MIPS program that loads integers into an array, sorts them in numerical order from lowest to highest, and searches the sorted array to see whether a particular integer is contained within the array. In particular, the step-by-step procedure is:

1. Prompt the user to enter a number between 1 and 20 (inclusive), which will be the size of the array in question.
2. Read in the integer that should be stored at every index of the array.
  - You may assume that the number entered will be a decimal number, with a valid value for MIPS 2’s complement representation.
3. Prompt the user to enter the value of a number that they would like to search for within the array.
4. Perform a bubble sort that will order the integers in the array from lowest to highest value.
5. Perform a binary search on your sorted array and indicate whether the search value is present. If it is present, indicate the index of the array at which it was found.
6. Terminate the program.

You will be responsible for coding steps 4 and 5. 

Please download the provided lab5.asm file from the github repo. You will see that numerous comments are provided which will guide you through the assignment. **Most** I/O has been provided for you, however you will be required to print the output of your binary search at the end of the program. Make sure to look at examples from earlier portions of code to demonstrate how to do this.

- Please complete the MIPS code in the two TODO sections indicated in the lab5.asm file:
- PART 1 in which you will sort the array using the bubble sort algorithm.
- PART 2 in which you will search the array for the specified value using the binary search algorithm.

**Important:**

- The input and output **must** be the same as the examples provided below, in terms of: spelling, spacing, cases, etc.
- We will use an auto-grader that compares your input-output solution with the correct one. You will lose points if they are formatted differently.
- If you have any clarifying questions, please ask your cohort leader

### Example I/O

The following consist of three different input and output case examples that demonstrate the expected output for the above program.
Example 1:

```
Enter array size [between 1 and 20]: 5
A[0] = -1
A[1] = 2
A[2] = 5
A[3] = -9
A[4] = 8
Enter search value: 4
4 not in sorted A
```

Example 2:

```
Enter array size [between 1 and 20]: 4
A[0] = 1
A[1] = 2
A[2] = 10
A[3] = -1
Enter search value: 2
Sorted A[2] = 2
```

Example 3:

```
Enter array size [between 1 and 20]: 4
A[0] = 0
A[1] = 0
A[2] = -1
A[3] = -2
Enter search value: 0
Sorted A[2] = 0
```

## Submit your assignment
Assignment submissions will be made through [GradeScope](https://www.gradescope.com).

You should already be enrolled in the COMP 311 Spring 2022 course on GradeScope. If you are not, please self enroll with entry code **X3PR75**. If you're unable to self enroll, please contact your cohort leader and we'll manually add you.

To submit your assignment, please follow the basic steps provided below. If you're unable to perform any of the steps, please reach out to your **cohort** and **cohort leader** as soon as possible. That is, give yourself time to resolve any technical issues using Github, Github Desktop, and Gradescope well before the assignment due date.

1. Submit modifications using the **commit** Github Desktop instructions.
2. Update remote (origin) repository using the **push** Github Desktop instructions.
3. Go to the COMP 311 course in GradeScope and click on the assignment called **Lab 05**.
4. Click on the option to **Submit Assignment** and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to GradeScope. When this occurs, **make sure to grant access to the Comp311-SP22 organization**.
5. You should see a list of your public repositories. Select the one named **lab-05-yourname** and submit it.
6. Your assignment should be autograded within a few seconds and you will receive feedback.
7. If you receive all the points, then you have completed this lab assignment! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.















