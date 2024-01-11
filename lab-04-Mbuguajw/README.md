# COMP 311: Spring 2022 - Lab 04

## Our First Few Simple MIPS Assembly Programs!

For help, you may look online only for reference (i.e., MIPS reference sheets, Stack Overflow, YouTube tutorials, etc.). However, all code should be generated by you, not by someone else or by a compiler. You may not look at the code written by another student in this course or a previous offering of this course. Trivially changing someone else’s solution (changing register names, labels, etc.) is considered cheating and is also unacceptable.

You must also comment your code. This is generally a good practice anyway, but it is especially important during your first exposure to assembly. These comments should be meaningful and guide a reader through the execution of your program. If you come into office hours for help without any comments, then we will ask you to first comment your code.

**First: Download and run MARS**
For this exercise, you will download the MARS assembler, and run a few simple MIPS assembly programs from the course website.
First, download MARS [here](https://courses.missouristate.edu/KenVollmar/MARS/MARS_4_5_Aug2014/Mars4_5.jar). Launch it by double-clicking the .jar file. You may be prompted to install the Java runtime environment if your computer does not already have it installed. Familiarize yourself with the menu. **If you are on a Mac**, you may have to manually allow this program to run in your security settings. For Mac users go to the security main page, click the lock in the bottom left-hand corner, put in your password, and then allow the program to run.

**Next: Configure MARS**

* Enable pseudo-instructions: go to **Settings** then select **Permit extended (pseudo) instructions and formats**
* Enable compact memory address layout: go to **Settings->Memory Configuration** and select **Compact, Data at Address 0.** then press the **Apply and Close** button. 

**Finally: Run the example assembly programs**

In this repo you will see the following two example assembly files: `Sum.asm` and `SumArray.asm`

After opening the MARS simulator, use the `File->Open` menu to open one of these programs. Assemble (i.e., compile) the program by hitting `Run->Assemble`, or by hitting the screwdriver/wrench icon, or by pressing F3. Run the program by hitting `Run->Go`, or by hitting the icon with the play button. You may single-step through the program by hitting `Run->Step` or hitting the icon with the '1' to the right of the play button. You can also set one or more breakpoints by checking the box to the left of the instructions where you want execution to break, and then hit Run.

The bottom pane has two tabs: 

- MARS Messages shows errors or warnings during assembly 
- Run I/O is the input/output.

Run each of the two programs. Make sure you understand every single line of code. Here is what to expect for each:

- `Sum.asm`: Single-step through the program, and observe that the result (i.e., sum of numbers 0..4) will be in register $8 at the end of execution.
- `SumArray.asm`: Single-step through it, and observe that the result (sum of 7, 8, 9, 10, and 8) will be in the sum variable (at data address 0x0 in the memory).

## More Info

There are several library routines provided by MARS that an assembly program can use. These are called system calls, or syscall. These services include support for printing integers and strings (similar to the printf() function in C), reading integers and strings from the keyboard (similar to scanf() in C), memory allocation (similar to malloc() in C), exiting from a program (similar to return from main() in C), etc.

An assembly program accesses those services using the syscall command. There is only one syscall command for all these services, but which service is requested is determined by the values provided in certain registers. The value in register $v0 determines which service is requested, and often parameters are passed to the service using registers $a0, $a1, $a2 and $a3. If a value needs to be returned to the program (e.g., reading an integer from the keyboard), it is typically returned in register $v0.

For a ***full listing*** of system calls available in MARS, please refer to http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html. We will mostly be using system calls numbered 1 to 17.

For example, to exit a program, you would use syscall with 10 in $v0:

`addi $v0, $0, 10			# system call 10 for exit`

`syscall					# exit the program`

## Part 1: Basic I/O and Arithmetic

You are given a program in MIPS assembly language that computes the area of a rectangle given the width and the height (ex1.asm). The width and height are read from the standard input after prompting the user, and then the program computes the area and prints it on the standard output. Here's an example scenario:

`Enter width (integer):`

`2`

`Enter height (integer):`

`4`

`Rectangle's area is 8`

Modify the program so that it also calculates and prints the perimeter (i.e., sum of all sides) of the rectangle. Thus, after modification, the example scenario would become:

`Enter width (integer):`

`2`

`Enter height (integer):`

`4`

`Rectangle's area is 8`

`Its perimeter is 12`

Test your program in MARS on a few different inputs to verify that it is working correctly. You can simply enter the inputs within the MARS "Run I/O" window. Once you are satisfied that the program is working fine within MARS, commit your changes and submit to Gradescope to run the autograder. If you see errors, you can edit it and resubmit any number of times until the due date. 


## Part 2: Loops

Create a new assembly file called "ex2.asm".

Copy your final ex1.asm file to ex2.asm. Modify the program in ex2.asm to make it work on multiple inputs. In particular, it should repeatedly ask for width and height values, and print the corresponding area and perimeter, until the user enters the value 0 for width. At that point, the program should terminate. Here's an execution scenario:

`Enter width (integer):`

`2`

`Enter height (integer):`

`4`

`Rectangle's area is 8`

`Its perimeter is 12`

`Enter width (integer):`

`5`

`Enter height (integer):`

`6`

`Rectangle's area is 30`

`Its perimeter is 22`

`Enter width (integer):`

`0`

Essentially, this exercise involves introducing a loop around the main code of Exercise 1. As long as width is not equal to 0, the program repeats by looping back to the top of the loop. If width is 0, the program breaks out of the loop. The key instructions for forming such loops are: beq, bne and j. You may need one or more of these, depending on how you construct your loop.

Test your program in MARS, and once you are satisfied that it is working properly, commit your changes and submit to Gradescope to run the autograder.

## Submit your assignment
Assignment submissions will be made through [GradeScope](https://www.gradescope.com).

You should already be enrolled in the COMP 311 Spring 2022 course on GradeScope. If you are not, please self enroll with entry code **X3PR75**. If you're unable to self enroll, please contact your cohort leader and we'll manually add you.

To submit your assignment, please follow the basic steps provided below. If you're unable to perform any of the steps, please reach out to your **cohort** and **cohort leader** as soon as possible. That is, give yourself time to resolve any technical issues using Github, Github Desktop, and Gradescope well before the assignment due date.

1. Submit modifications using the **commit** Github Desktop instructions.
2. Update remote (origin) repository using the **push** Github Desktop instructions.
3. Go to the COMP 311 course in GradeScope and click on the assignment called **Lab 04**.
4. Click on the option to **Submit Assignment** and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to GradeScope. When this occurs, **make sure to grant access to the Comp311-SP22 organization**.
5. You should see a list of your public repositories. Select the one named **lab-04-yourname** and submit it.
6. Your assignment should be autograded within a few seconds and you will receive feedback.
7. If you receive all the points, then you have completed this lab assignment! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.
