# COMP 311 Spring 2022: Lab 1

Now that we're familiar with Digital software simulator and combinational logic circuit design techniques, e.g., truth tables, sum of product (SOP) expressions, and SOP simplification using Karnaugh maps, and it's time to take things to the next level! In this lab you're going to be wiring up a 7-Segment LED Display!

Seven-segment displays are widely used in digital clocks, electronic meters, basic calculators, and other electronic devices that display numerical information. If you've never seen a 7-segment display before, here's one below:

![image](https://user-images.githubusercontent.com/55986131/150591335-d79d4442-78be-4984-b9a2-df3d0044a3dc.png)

<img align="right" width="150" height=auto src="https://user-images.githubusercontent.com/55986131/150592119-b54a65cd-a2a4-4478-9791-e2ce7881bda9.png">

As you can see, there are 7 seperate LED's that turn on & off depending on the number (or letter) that you want displayed. A 7-segment display has four Boolean inputs (A, B, C, D) and Seven Boolean outputs (Fa, Fb, Fc, Fd, Fe, Ff, Fg) that represent display segments. In general, four Boolean inputs are decoded to seven Boolean outputs that will be used to display 1 of 16 hexadecimal values (0, 1, 2, 3, 4, 5. 6, 7, 8, 9, A, b, c, d, E, F). 

To determine what value will be displayed on the 7-segment display you take the binary combination of the 4 input bits and convert to hexadecimal, and the hex-value is what should be displayed. For instance when the 4 input bits are 0000, this translates to hex-value 0, and 0 is what is displayed. For input bits 1111, this translates to hex-value "F", and this is what is displayed. The image to the right shows the layout of the 7 LED's:

##

<img align="right" width="290" height=auto src="https://user-images.githubusercontent.com/55986131/150592272-b81f968a-cade-4cc8-afac-653061a58d21.png">

Additionally, the following truth table to the right is crucial to constructing the circuit for a 7-segment display: 

For example, when inputs A, B, C, and D are all off (0=off) then output segments Fa through Ff will be turned on (on=1) to display the hex value “0” - We've updated the truth-table for you above. 

Similarly, the output segment Fa will be turned on for the following input combinations - I’ve also updated the truth-table for you.

- A,B,C,D=0
- A,B,D=0 and C=1 
- A,B=0 and C,D=1 
- A,C=0 and B,D=1 
- A,D=0 and B,C=1 
- A=0 and B,C,D=1 
- A=1 and B,C,D=0 
- A,D=1 and B,C=0 
- A,C=1 and B,D=0 
- A,B,C=1 and D=0 
- A,B,C,D=1

## Task 1

Using the given "truth-table.csv" file in the repo, fill in the rest of the truth table. Determine for each number or letter, which of the 7 LED's will be on (1) or off (1). You will see that the the given row and column is also given in the excel document. When you finish the truth table, we reccomend commiting your changes and submitting to Gradescope to see if it is correct. If you have an incorrect truth table, your circuits in the next part will not be correct!

## Task 2

Now that we've constructed the truth table, it's time to get ready to build the circuit! Before we start diagramming on Digital, we need to figure out how we're going to wire the 7-segment display up.

### Step 1

- Using the completed truth-table, find the sum of products (SOP) Boolean expression (not simplified) for output segments Fa - Fg
- Simplify the SOP Boolean expression for each of the output segements Fa - Fg using the Boolean identities. 
- Alternatively, you can contruct Karnaugh maps based on the completed truth-table for each output segment Fa - Fg, and use the Karnaugh map to find the simplified SOP boolean expression
- At this stage you should have 7 boolean expression in SOP form that are as simplified as possible. *if you don't simplify the boolean expressions or put them in SOP form, you're going to have a very tough time while constructing the circuit in Digital*

### Step 2

- Draw the combinational logic circuits for each of the SOP expressions you obtained in Step 1. This will be the basis for what we are going to input into Digital

### Step 3

<img align="right" width="350" height=auto src="https://user-images.githubusercontent.com/55986131/150599007-0b6b0880-95ee-4959-bc80-aff53b4c5ac7.png">

- Now comes the hard part, actually putting & combining these circuits in Digital. *Note: This is going to be a complicated circuit*
- We've provided a template file for the assignment, labeled "Lab01.dig" in the repository. Make sure to build & commit your changes in this file.
- We've provided you 4 inputs labeled A-D, these are the only inputs you will need for this assignment!
- *Note: Each of your 7 circuits you drew in step 2 will use the same 4 inputs A-D*
- Construct your circuits! You can select logic components from the "Components -> Logic" menu. You should only need AND, OR, and NOT components for this assignment. 
- You can find the 7-segment LED display under "Components -> IO -> Displays -> Seven-Segment Display" *Note: DO NOT use the Seven-Segment Hex Display*
- Remember that each of your 7 circuits will connect to one of the LED's on the Seven-Segment Display. I've provided the image on the right to display which circuits connect to which inputs on the display. The bottom right input on the display must connect to ground. You can find the ground element in "Components -> Wires -> Ground"

### IMPORTANT

- When you finish wiring up your circuits, you should have 7 OR gates in your design (7 SOP expressions -> 7 OR gates). Each of these OR gates should lead to one input on the 7-segment display as shown in step 3. Below is an example:

![image](https://user-images.githubusercontent.com/55986131/150715370-9ca370d8-1d0b-4008-976b-f832df65a754.png)

- In order for the autograder to work, you MUST add output (Components -> IO -> Output) components on the end of each OR gate and label the component (using right-click for windows and control-click for mac) with the input that it is going to, (Fa, Fb, Fc, Fd, Fe, Ff, Fg). Don't touch your wires, just place the output component on the output of each OR gate, and then label it accordingly. You MUST label the output components as (Fa, Fb, Fc, Fd, Fe, Ff, Fg) exactly as written. Below is an example:

![image](https://user-images.githubusercontent.com/55986131/150715583-65f23181-f6bc-4857-897e-16debab9c0b6.png)

- If you don't do this the autograder will not work, and your test cases will fail even if your circuit is correct!

### Some Notes

- Make sure that when crossing wires they don't accidentally connect. You can tell if wires have connected if a blue dot appears in Digital. (Sometimes you may want to connect wires though, just make sure when it happens you're doing it on purpose).
- Each of the inputs A-D will be used in a LOT of components, make sure to give yourself plenty of space to be able to wire all the needed components.
- When using an AND or OR gate, each input needs to be seperate (ie. on it's own blue dot). In order to choose the number of bits right-click (on mac control-click) the component and select the number of input bits. For instance for the boolean expression ABC + CD, you will need two AND gates (one with 3 inputs and one with 2), and one OR gate (with 2 inputs).

## Task 3: Submit your assignment
Assignment submissions will be made through [GradeScope](https://www.gradescope.com).

You should already be enrolled in the COMP 311 Spring 2022 course on GradeScope. If you are not, please self enroll with entry code **X3PR75**. If you're unable to self enroll, please contact your cohort leader and we'll manually add you.

To submit your assignment, please follow the basic steps provided below. If you're unable to perform any of the steps, please reach out to your **cohort** and **cohort leader** as soon as possible. That is, give yourself time to resolve any technical issues using Github, Github Desktop, and Gradescope well before the assignment due date.

1. Submit modifications using the **commit** Github Desktop instructions.
2. Update remote (origin) repository using the **push** Github Desktop instructions.
3. Go to the COMP 311 course in GradeScope and click on the assignment called **Lab 01**.
4. Click on the option to **Submit Assignment** and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to GradeScope. When this occurs, **make sure to grant access to the Comp311-SP22 organization**.
5. You should see a list of your public repositories. Select the one named **lab-01-yourname** and submit it.
6. Your assignment should be autograded within a few seconds and you will receive feedback.
7. If you receive all the points, then you have completed this lab assignment! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.

