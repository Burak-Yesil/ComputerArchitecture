.text 
.global _start
.extern printf 

//I pledge my honor that I have abided by the Stevens Honor System.

_start:
	
	ADR X0, msg 
	ADR X1, Result
	ADR X2, CWID
	
	LDUR X1, [X1]
	MOV X3, 0

	L1: 
	CMP X3, 8
	B.gt exit
	LSL X4, X3, 3      //Store offset in X4
	ADD X5, X2, X4     //Get index of new element
	LDR X10, [X5]      //arr[i]
	ADD X1, X10, X1
	ADD X3, X3, 1
	B L1

	exit:
	BL printf
	MOV X0, #0
	MOV W8, #93
	SVC #0



.data
msg: .ascii "%d\n"
CWID: .quad 1, 0, 4, 6, 8, 9, 1, 3
Result: .quad 0

.end
