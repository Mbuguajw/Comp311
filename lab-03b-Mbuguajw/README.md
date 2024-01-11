# COMP 311: Spring 2022 - Lab 3b

As mentioned in the previous lab, this lab is a supplement to Lab 3. We are now going to put together everything we have learned about ALU design and RAM.

Let's begin:

We're going to be designing a simpler-than-SAP 'computer' that can do some of the operations we implemented in Lab 3, as well as reading instructions from RAM. We've learned in class about instruction sets, and how instructions carry both op-codes AND data. In order to make this lab simpler, our instruction sets will consist of 11 bits. The first 7 bits will be the op-code, and the last 4 bits will be the data. Although we have 7 op-code bits, our 'computer' only supports 5 instructions:

- AND
- OR
- ADD
- SUB
- HLT

Our goal for this lab is to be able to:

- First program our RAM manually with a string of instructions we want to execute (in the last lab we could only do one instruction at a time, now we want to do multiple in a row)
- Have the output of that program written to our output register

By doing this we will be able to string together computations instead of doing them one-by-one. For example, now we can write a program that could 

- Step 1: OR 5 (loads 5 into the register that is initally 0)
- Step 2: ADD 5 (Adds 5 to 5)
- Step 3: ADD 1 (Adds 1 to step 2 result)
- Step 4: SUB 3 (Subtracts 3 from step 3 result)
- Step 5: HLT (Match the output with the register value and stop the program)

Our op-code bits will be used to control the 'control' bits 'math' and 'sub' from part 1 of Lab 3, and also to control the different input bits that we needed for our RAM module in part 2 of Lab 3. Open up the excel file labeled 'microcode.xlsx' and take a look.

You'll see at the top the different op-codes for each of our five instructions. With the exception of the HLT instruction, all the "Data" fields are labeled 'x' because the user can change that data to whatever value they want. 

Under those instructions are 2 examples programs our 'computer' will be able to execute after finishing this lab. You can see how the op-code for each instruction matches the op-code above, combined with whatever data the instruction needs to carry with it. The decimal and hex representations of the binary are provided for you in order to make inputing the instruction into RAM easier later in this lab. 

Notice how we can be clever with what we do with each instruction, as AND could be used for clearing a register, OR can be used for loading immediate if the register is already 0, and HLT can have the output match the register and stop running the program. (Ask yourself how this works). 


## Digital Time

To start, open up the 'Lab03b.dig' file provided in the respository. 

You'll see that we've done quite a bit of the heavy lifting for you already. Off the left you'll see the circuitry for our program counter! This has been made for you but feel free to analyze and figure out how it works. This component is what will allow your program to step through the different instructions to get the final result! 

In the middle of the circuit you'll see all the control bits we will need to use for both RAM and our ALU. There are a few other input bits that we will discuss later in the lab. 

Now let's discuss what you need to do!

## To-Do:

Lets first insert our efficient ALU from Lab 3. We need to make a few changes to get this working:

- The first change is that we will not have a B or C register in this design. Register A will function as both our input & 'output' register. Instead of having register "B" we will be using the data-bits from the instruction that are sent over from RAM. Notice how there is a splitter provided for you where register B would normally go. For this splitter we only care about bits 0-3, our "data" bits in the instruction set. Bits 4-10 are not an input to the ALU because they are not data bits. 
- Where do you think this splitter will get it's data from? That's for you to figure out :grin:
- Remove register C as well from your ALU, but leave the output components C0-C3. Additionally you will need to loop the outputs from the ALU back into the input for register A AS WELL as the output components C0-C3.
- We provided a clock component as well, use this clock component everywhere in the circuit that you need it. Note: Please invert the clock signal on the inputs into Register A. (Recall the 'efficient' part of last the last lab!)
- Make sure you wire up the enable bit as well, the enable input you'll need is provided for you off to the left (it's your job to figure out which of those inputs should be used as the enable bit to register A0)
- We provided you the sub and math bits that you will need for your ALU on the left as well!

Now lets wire up the RAM component!

- For this lab you will only need two components from the last lab: the RAM module and the Memory Address Register (MAR). The MAR should be set to 4 bits, and the RAM module should be set to accept 11 data bits and 4 address bits. 
- Now you need to wire up the MAR and the RAM module based on what you learned in the previous lab! 
- Where will you send the output of the RAM module? (Hint: You'll need to send it to two places!)

Once you think you have everything wired up, it's time to test out our 'computer'!

## Testing:

In order for our 'computer' to work, we need to manually load in all the instructions to the RAM module that we wish to be executed. To do this follow these steps:

1. Start the simulation
2. Enter programming mode by pressing the 'Prog' button. Enable the 'ADRRegEnable,' 'Write,' and 'Lookup' control signals.
3. Right-click the 'ADR' input to input the memory address you'd like to write to. Have the ADR input bit be one higher than the address you want to write to, so if you want to put an instruction in slot 0, have ADR set to 1. This is because the data will be written to RAM at the same time as the MAR updates, setting it up for the next line of code. Hit 'Apply' to make sure the value is set.
4. Right-click on the 'Data' input to input the instruction + data (microcode). Use one of the example programs given in the spreadsheet. You can type in the decimal values of the microcode to make programming easier as well (see the spreadsheet, which calculates them for you). For example for the first instruction you should put the value "0x765' in address "0000". Hit 'Apply' to make sure the value is set.
5. Click the clock button twice. Don't click it more than twice, that will mess your manual inputting up!
6. Repeat starting at step 3 for your next instruction, and continue inputting instructions in RAM that were given in the spreadsheet.

Once you have done this, click on your RAM component and ensure that all your instructions have been loaded into RAM sequentially, starting at address 0.

Now to test whether our 'computer' works, do the following (do not stop the previous simulation!):

1. Disable the 'Write' signal
2. Set ADR to 0
3. Toggle the clock (two clicks)
4. Deactivate programming mode (disable 'Prog') and double check that the  MAR is 0 and the one other register is 0.
5. Toggle the clock to run through your program.

You should see the output of your program in the output components C0-C3!

Congratulations! You have succesfully constructed a mini-computer capable of loading instructions and executing them sequentially! Commit your changes and submit when you're finished.

If you have any questions, ask your cohort leaders!

## Submit your assignment
Assignment submissions will be made through [GradeScope](https://www.gradescope.com).

You should already be enrolled in the COMP 311 Spring 2022 course on GradeScope. If you are not, please self enroll with entry code **X3PR75**. If you're unable to self enroll, please contact your cohort leader and we'll manually add you.

To submit your assignment, please follow the basic steps provided below. If you're unable to perform any of the steps, please reach out to your **cohort** and **cohort leader** as soon as possible. That is, give yourself time to resolve any technical issues using Github, Github Desktop, and Gradescope well before the assignment due date.

1. Submit modifications using the **commit** Github Desktop instructions.
2. Update remote (origin) repository using the **push** Github Desktop instructions.
3. Go to the COMP 311 course in GradeScope and click on the assignment called **Lab 03b**.
4. Click on the option to **Submit Assignment** and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to GradeScope. When this occurs, **make sure to grant access to the Comp311-SP22 organization**.
5. You should see a list of your public repositories. Select the one named **lab-03b-yourname** and submit it.
6. Your assignment should be autograded within a few seconds and you will receive feedback.
7. If you receive all the points, then you have completed this lab assignment! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.







