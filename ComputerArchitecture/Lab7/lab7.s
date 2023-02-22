.text 
.global _start
.extern printf 

//Burak Yesil
//I pledge my honor that I have abided by the Stevens Honor System.

_start:
	
    ADR X3, A //base address of the array
    LDR X5, Length
    SUB X5, X5, 1
    LSL X9, X5, 3
    ADD X9, X9, X3
    LDUR X4, [X9]  //last value in the array
    BL find_max
    MOV X1, X0
    ADR X0, msg

	BL printf
	MOV X0, #0
	MOV W8, #93
	SVC #0


find_max:
    //checking base case
    SUB SP, SP, 16
    STUR LR, [SP, 8]
    STUR X4, [SP]
    CMP X5, XZR
    B.EQ L1
    SUB X5, X5, 1
    LSL X9, X5, 3
    ADD X9, X9, X3
    LDUR X4, [X9]
    BL find_max

    LDUR X6, [SP]
    CMP X0, X6
    B.GE update
    MOV X0, X6


update:
    LDUR LR, [SP, 8]
    ADD SP, SP, 16
    BR LR


L1:
    MOV X0, X4
    B update


.data

msg: .ascii "%d\n\0"
A: .quad 1,3,8,3,15,7
Length: .quad 6


.end
