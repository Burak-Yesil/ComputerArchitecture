.text 
.global _start
.extern printf 

//Burak Yesil
//I pledge my honor that I have abided by the Stevens Honor System.



_start:
    //Like the main method in high level programming languages
    LDR X2, =Arr           //Loading the base address of the array
    LDR X3, =Arr_size        //Loading the address of the size of the array
    LDR X3, [X3]        //Loading the actual size of the array into X3
    BL selection_sort   //Branching and linking to selection sort procedure
    BL resultPrinter     //Branching and linking to print result function

    //done and exiting
    MOV X0, #0          
    MOV W8, #93
    SVC #0



resultPrinter:
    //Prints the result of the selection sort procedure (the new sorted array)

    SUB SP, SP, 8  //Increasing the size of the Stack
    STUR LR, [SP, 0] //Storing the LR register in sp
    MOV X20, XZR  //X19 is the counter
    LDR X21, =Arr //array
    MOV X22, X3 //Moving X3 (the array size) into X23 to now when to stop the loop down below

    printLoop: //This loop prints the result elements one by one
              CMP X20, X22 //Compares the current index to the list size
              B.GE exitPrinter //Exits loop when current index is equal to size
              LDR X1, [X21, X20, lsl 3] //Using short cut LDR lsl method to get the element to print (X0's parameter for %d)
	          ADR X0, message   //storing the message variable from the data section in X0
              BL printf //printing message
              ADD X20, X20, 1 //Incrementing index by 1
              B printLoop //branching back to the begining of the print loop

    exitPrinter: 
            LDUR LR, [SP, 0] //Loading X30's original value back into X30 (brings us back to _start's next instruction)
            ADD SP, SP, 8 //Decreasing the size of the Stack
            BR LR   //Returning back to next instruction in _start procedure




selection_sort:
    //Applies selection sort to given list.
    //This procedure is a non-leaf procedure that calls the find min and swap procedures.

    SUB SP, SP, 8 //Increasing SP index by 8 to make room to store the X30 or LR register 
    STUR LR, [SP]
    MOV X4, 0 //loop counter
    sortingLoop:  
            CMP X4, X3
            B.GE exitSortingLoop
    		MOV X0, X4
    		BL findMinimum //finds minimum value
    		MOV X1, X4 //preparing to swap X0 (from findMinimum) and X1
    		BL swap_proc //swaps the minimum value
    		ADD X4, X4, 1
    		B sortingLoop
    exitSortingLoop: 
            LDUR LR, [SP]
            ADD SP, SP, 8
            BR X30



findMinimum: 
      //Finds the minimum value in the array

      ADD X8, X0, 1 //X0 is the start or first element to look at. 
                    
      minFinder: 
          CMP X8, X3 //Compares the current index to the size of the array
          B.GE found_min //Exits the loop once the current index is equal to the actual size of the length
          LDR X9, [X2, X0, lsl 3]  
          LDR X10, [X2, X8, lsl 3] 
          CMP X9, X10 //compares the values of X9 and X10
          B.LE continue  
          MOV X0, X8 //Updates XO to the current value of x8

          continue: 
            ADD X8, X8, 1 //Increments the X8 registers value
            B minFinder //Branches into Loop1
            
       found_min: BR LR


swap_proc:
    //Swaps the addresses of two elements.
    LDR X8, [X2, X0, lsl 3]
    LDR X9, [X2, X1, lsl 3]
    STR X9, [X2, X0, lsl 3]
    STR X8, [X2, X1, lsl 3]
    BR LR


.data

message: .ascii "%d\n\0"
Arr: .quad  24061, -923, 24301, 1682, 5811, 7525, -43406, 9955, 18797, 19957, 47072, 42018, -29577, 48629, 9037, 10764, 37638, 3235, -30288, 19396, 19484, 14011, 37260, 1616
Arr_size: .quad 24


.end






