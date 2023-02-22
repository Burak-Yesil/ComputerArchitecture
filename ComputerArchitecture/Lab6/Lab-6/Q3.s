.text 
.global _start
.extern printf 

//I pledge my honor that I have abided by the Stevens Honor System.

_start:
	
	ADR X0, msg
	ADR X2, Temp
	ADR X1, Result
	
	LDUR X1, [X1]
	LDUR X2, [X2]
	


	L1: 
	ADD X2, X2, 1
	ADD X1, X2, X1

	SUBS X3, X1, 55
	CBNZ X3, L1

	BL printf
	MOV X0, #0
	MOV W8, #93
	SVC #0



.data

msg: .ascii "%d\n"
Temp: .quad 0
Result: .quad 0


.end
