# COMP 311 Spring 2022: Lab 2

Now that we are familiar and comfortable with wiring combinational logic circuits in Digital, it's time to build some sequential logic circuits. Sequential logic circuits are the backbone of constructing finite-state machines, a topic you will cover in Comp 455. Here's a blurb from Wikipedia that explains the usefullness of sequential logic circuits: 

> Sequential logic is a type of logic circuit whose output depends not only on the present value of its input signals but on the sequence of past inputs, the input history as well. This is in contrast to combinational logic, whose output is a function of only the present input. That is, sequential logic has state (memory) while combinational logic does not.

A great example of sequential logic is below: 

> A familiar example of a device with sequential logic is a television set with "channel up" and "channel down" buttons. Pressing the "up" button gives the television an input telling it to switch to the next channel above the one it is currently receiving. If the television is on channel 5, pressing "up" switches it to receive channel 6. However, if the television is on channel 8, pressing "up" switches it to channel "9". In order for the channel selection to operate correctly, the television must be aware of which channel it is currently receiving, which was determined by past channel selections. The television stores the current channel as part of its state. When a "channel up" or "channel down" input is given to it, the sequential logic of the channel selection circuitry calculates the new channel from the input and the current channel.

## Objective

Our goal for this lab is to create a 3-bit counter. Essentially, we want to design a circuit that "counts" upwards, from 0 to 7. Electronic counters come in two types: Asynchronous and Synchronous. In this lab we will build a Synchronous counter. Synchronous counters use a common clock and logic between their components to encode the count sequence. In these types of counters, the flip-flops are clocked at the same time by a common clock pulse. Thus, all the flip-flops change state simultaneously (in parallel). The counter advances upward in sequence (0, 1, 2, 3, 4, 5, 6, 7). The counter advances to the next output state on the positive edge of the input clock.

## State Diagram

<img align="right" width="350" height=auto src="https://user-images.githubusercontent.com/55986131/152058876-a2b1557f-3fd8-4186-a56d-1e167032782b.png">

The next step in designing our 3-bit circuit is to design a State Diagram. This is a diagram that is made from circles and arrows and describes visually the operation of our circuit. In mathematic terms, this diagram that describes the operation of our sequential circuit is a Finite State Machine. 

The state diagram of our circuit is shown to the right. Every circle represents a “state”, a well-defined condition that our machine can be found at. In the the circle we describe that condition. Every arrow represents a “transition” from one state to another. A transition happens once every clock cycle. Depending on the current input, we may go to a different state each time. 

So, what does our “Machine” do exactly? It starts from the “000” state and waits until a 1 is read at the input. Then it goes to the “001” state. As our clock continues, the circuit goes to the third state, "010”, and so on. Note that if the input to a state is 0, the machine stays in it's current state. This gives us the functionality of advancing to the next output state on the positive edge of the input clock or "pausing" the clock and remaining in the current state.

We will come back to analyzing this state diagram soon.

## T Flip-Flops

<img align="right" width="200" height=auto src="https://user-images.githubusercontent.com/55986131/152062532-b26f8108-c13f-492c-a139-fd416d4ab737.png">

There are indeed many ways to make a 3-bit counter. You can use D or JK flip-flops, but in this lab we will use a T flip-flop. You should have learned about D flip-flops in class, and hopefully this lab will expose you to a different type of flip-flop, the T flip-flop. 

There are many different types of flip-flops; however, they are all sensitive to clock edges, but they perform different actions in response to the input states. The “T” in “T flip-flop” stands for “toggle.” When you toggle a light switch, you are changing from one state (on or off) to the other state (off or on). This is equivalent to what happens when you provide a logic-high input to a T flip-flop: if the output is currently logic high, it changes to logic low; if it’s currently logic low, it changes to logic high. A logic-low input causes the T flip-flop to maintain its current output state.

### To-Do:

Now that you know how a T flip-flop functions, fill in the truth-table for a T flip-flop found in the file "t-flip-flop.csv". The input is "T", the current state is "Q", and the next state is "Q*". (Please note that Q* is not the same as Q-bar in the image above. Q-bar above is simply the inversion of Q.) This is also known as an "Excitation Table" for a T flip-flop. This will help you understand how T flip-flops work, and how we will be able to use them in our circuit for our 3-bit counter.

## Truth-Table Based on State Diagram

For our 3-bit counter we're going to need 3 T flip-flops! Each output of a T flip-flop will be one binary digit of our number (0-7). What we need is to create a truth table that displays the current state, output states, and values of T based on our state diagram. Using the state diagram previosuly displayed in the lab, fill in these values. Q represents the current state, Q* represents the next state, and Ti represents the input to the flip-flop. Fill out the file "state-diagram-truth-table.csv" with the completed table. 

Let's give a little more information to make sure the concept is completely clear. 

C, B, A -> Represent the binary digits of the numbers we are counting. Ex. 001 -> 1, 010 -> 2, 100 -> 4, and so on. 
For 001, C -> 0, B -> 0, 1 -> A

QC, QB, QA -> Represent the current state of our machine. Ex. 101 means that QC -> 1, QB -> 0, QC -> 1. If 101 is the current state of the machine, then what are the possible next states? 101 can either transition to 101 (stay the same) or to 110 (increase to 6). That means in our truth table we will have 2 rows where QC, QB, QA are 101 respectively. The QC* QB* QA* for one row will be 101 (stay the same; input = 0 ) and another row will be 110 (change states; input = 1). 

We also need to fill in TC, TB, TA for each row in our table. Remember that the value for T(i) will only be 1 if that digit is changing. For example if we have

QC QB QA -> 001
and 
QC* QB* QA* -> 010
then 
TC TB TA -> 0 1 1 (digit c did not change, digit b changed, and digit a changed as well). 

### To-Do:

For the truth table, we will give you all the QC QB QA for the states, you need to go in and fill out QC* QB* QA* as well as TC TB TA for each row. 
**Important: the row for when the state stays the same should come BEFORE the row that represents moving to the next state (notice input 0 and input 1)**

ie. 

|QC | QB | QA | Input(Y) | QC* | QB* | QA* | TC | TB | TA |
|---|----|----|-------|-----|-----|-----|----|----|----|
|0  |0   |0   |0      |0    |0    |0    |0   |0   |0   |
|0  |0   |0   |1      |0    |0    |1    |0   |0   |1   |

These will be the first two rows of your truth table. Notice how the first row represents the output state when the machine does not change states, and the second row is moving to the next state.

## K-Maps

It's K-map time now! We need to figure out what the circuit should look like for each of TC, TB, TA. This means we need 3 different K-map, each producing one expression that tells us how we should wire up the inputs to each flip-flop. 

### To-Do:

You need to draw k-maps for each of TC, TB, and TA (3 total). You should construct the maps using QC QB QA and Input (Y). QC and QB should be the vertical column on your k-map, and QA and Y should be the horizontal row. What goes inside the boxes of your k-map is the value of the T(i) for the map you're constructing. Ex:

|       | QA Input(Y) |
|-------|----|
|**QC QB**| value of Ti   |

Using the Word document "k-map.docx" please upload pictures of your three k-maps, showing the 3 expressions you obtain for each of TC TB TA.

## Implementation:

Now that we have our three expressions representing what the input "T" should be for each of our T flip-flops, it's time to wire it up in Digital. **I'd recommend drawing the circuit on paper first**

Create a file called "Lab02.dig" to build your circuit. You can find the flip-flop you need under components -> Flip-Flops -> T-Flip-Flop. You'll also need a clock for this assignment. Find the clock under components -> IO -> clock input. When you place your clock make sure to right-click (control-click on mac) and check the box labeled "start real time clock". 

**Hint: Sometimes outputs of one flip-flop may be used in inputs to other flip-flops**
**Hint: Remeber that the "Y" input will be an actual input component, from components -> IO -> Input, and you'll need to use your k-map expressions to figure out what the inputs to TC TB and TA are. They may be some combination of the "Y" input and possibly outputs from other flip-flops. You may also need to use some combinational logic components in this lab!**
**Hint: Make sure this clock input is connect to the "C" input on all three of your T-Flip-Flops. **

### To-Do:

Compelete the circuit needed to wire up the 3-bit counter. The "T" input is what you solved for in the k-map. "Q" is the output of that digit. Ignore Q-bar, its just the inverse of Q. Each output Q of the three T-Flip-Flops should be connected to an output component. Label each of your output components as QC, QB, and QA respectively. You should also label your input component "Y". You must also label your clock component "CLK".

At this point, when you start the simulation you should see the output components start to turn on and off in a fashion that counts upwards (only when the input Y is set to 1, when input Y is set to 0, the clock should hold steady in it's current state). 

Now the fun part: Create a file called "Lab02fun.dig". Copy your circuit from "Lab02.dig" and paste it into this file. Also, copy your entire circuit from the previous Lab 1 (the seven segment display) and paste it into this document. Now instead of sending the Q outputs to an output component we're going to send them to the inputs of the 7-segment display to watch our machine count!

Step 1: Delete inputs B, C, and D in the Lab01 circuit
Step 2: Remove the output components for QC QB and QA from the Lab02 circuit
Step 3: Connect output QC to where your old input B was to the Lab01 circuit
Step 4: Connect output QB to where your old input C was to the Lab01 circuit
Step 5: Connect output QA to where your old input D was to the Lab01 circuit

Now when you start the simulation you should be able to watch the 7-segment display also count up (Only when input y is set to 1. If y is set to 0 you should see the 7-segment display hold steady in it's current state)! This is also a great way to ensure your circuits are correct.

When you finish save and commit all your changes!

## Submit your assignment
Assignment submissions will be made through [GradeScope](https://www.gradescope.com).

You should already be enrolled in the COMP 311 Spring 2022 course on GradeScope. If you are not, please self enroll with entry code **X3PR75**. If you're unable to self enroll, please contact your cohort leader and we'll manually add you.

To submit your assignment, please follow the basic steps provided below. If you're unable to perform any of the steps, please reach out to your **cohort** and **cohort leader** as soon as possible. That is, give yourself time to resolve any technical issues using Github, Github Desktop, and Gradescope well before the assignment due date.

1. Submit modifications using the **commit** Github Desktop instructions.
2. Update remote (origin) repository using the **push** Github Desktop instructions.
3. Go to the COMP 311 course in GradeScope and click on the assignment called **Lab 01**.
4. Click on the option to **Submit Assignment** and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to GradeScope. When this occurs, **make sure to grant access to the Comp311-SP22 organization**.
5. You should see a list of your public repositories. Select the one named **lab-02-yourname** and submit it.
6. Your assignment should be autograded within a few seconds and you will receive feedback.
7. If you receive all the points, then you have completed this lab assignment! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.
