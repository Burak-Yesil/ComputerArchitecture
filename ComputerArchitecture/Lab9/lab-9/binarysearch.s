//Burak Yesil
//I pledge my honor that I have abided by the Stevens Honor System.
.text
.global _start
.extern printf

//I didn't use my selection sort cause I kept on running into issues 
//when trying to add it into this lab. I just implemented Binary Search.

_start:
    LDR x0, =PromptMessage //Lets user know to input value
    BL printf
    LDR x0, =inputmessage//takes in and stores users input
    LDR x1, =inputnum
    BL scanf
    ADR X11, arr
    LDR X8, =length
    LDR X8, [X8]
    SUB X10, X8, 1 //Last Index
    BL BS //calling Binary Search


    BS:
        LDR x4, inputnum
        MOV X16, 0 
        MOV X15, X10 
        b L1

        L1: //This acts like a while loop
            CMP X16, X15 
            b.gt ElementNotInList 
            ADD X9, X16, X15 
            LSR X9, X9, 1 
            LDR x12, [X11, X9, lsl 3] 
            CMP x12, x4 
            b.eq foundTarget
            b.lt lowerPartition
            b.gt higherPartition
            
            foundTarget: //Checks if the element is target element
                        LDR x0, =Target
                        MOV x1, X9 
                        b Exit
            higherPartition: //Checks if target would be in the higher half
                        SUB X9, X9, 1 
                        MOV X15, X9 
                        b L1
            lowerPartition: //checks if the target would be in the lower half
                        ADD X9, X9, 1 
                        MOV X16, X9
                        b L1
            ElementNotInList: //Returns when element isn't in the list
                        LDR x0, =NotFound
                        b Exit
            
            Exit:
                BL printf
                MOV X0, 0
                MOV w8, 93
                SVC #0




.data

arr: .quad 1, 6, 7, 88, 200, 250, 1000
length: .quad 7
inputnum: .quad 0
PromptMessage: .ascii "Input Target Value:\n\0"
inputmessage: .ascii "%ld"
Target: .ascii "Element Found, Index: %d\n\0"
NotFound: .ascii "ELEMENT NOT FOUND\n\0"
