.text 
.global _start
.extern printf 

//I pledge my honor that I have abided by the Stevens Honor System.

_start:
	
	ADR X0, msg
	ADR X2, I
	ADR X1, F
	ADR X3, G
	
	LDUR X1, [X1]
	LDUR X2, [X2]
	LDUR X3, [X3]
	
	SUBS X4, X2, 4
	CBNZ X4, L1
	ADD X1, X3, 1
	B L2
	
    L1: SUB X1, X3, 2
    L2: BL printf
    	MOV X0, #0
    	MOV W8, #93
    	SVC #0

.data

I: .quad 4 
F: .quad 5
G: .quad 6
msg: .ascii "%d\n"



.end
