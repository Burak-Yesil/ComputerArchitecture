.text 
.global _start
.extern printf 

//I pledge my honor that I have abided by the Stevens Honor System.

_start:
	
	ADR X0, msg
	ADR X2, A
	ADR X1, B
	
	LDUR X1, [X1]
	LDUR X2, [X2]
	


	ADD X3, X2, X1
	SUBS X3, X3, 14
	CBNZ X3, L1
	MOV X1, 3
	B L2
    L1: MOV X1, -2
    L2: BL printf
    	MOV X0, #0
    	MOV W8, #93
    	SVC #0

.data

A: .quad 9
B: .quad 5
msg: .ascii "%d\n"



.end
