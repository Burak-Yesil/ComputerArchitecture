.text
.global _start
_start:
bl bisection

//Burak Yesil
//I pledge my honor that I have abided by the Stevens Honor system.


bisection: //returns the final resul at d0
    
    //Gets addresses of a and b
	adr x1, a
	adr x2, b
	
    //Storing values into floating point registers
	ldur x0, [x1]
	fmov d1, x0 // d1 = a
	ldur x0, [x2]
	fmov d2, x0 //d2 = b
	
    //storing tol in the d3 register
	adr x6, tol
	ldur d3, [x6] //d3 = tol

    //storing the n variable in x3
	adr x6, n
	ldr x3, [x6] //x3 = n

    //storing the coeff address in x7
	adr x7, coeff



    //L1 replciates the while loop from the wikipedia pseudocode
	L1:
        fadd d0, d1, d2 //c
		fmov d5, 2.0
		fdiv d0, d0, d5
		fmov d12, d0
		bl function //f(c)

		scvtf d6, xzr //changes int into a double/floating point variable
		fcmp d0, d6 //if f(c) == 0
		b.eq found //exit
		fsub d4, d2, d1
		fmov d11, 2.0
		fdiv d4, d4, d11
		fcmp d4, d3
		b.lt found
		fmov d4, d0 //mov c to d4
		fmov d0, d1
		bl function //d0=f(a)
		fmul d0, d0, d4
		fcmp d0, 0.0
		b.ge same_sign
		b.lt opposite_sign

		same_sign:
                fmov d1, d12 //a = c
                b L1

		opposite_sign:
                fmov d2, d12 //b=c
                b L1

		not_found:
                fmov d0, d0
				adr x0, no_value_msg
				bl printf	
				b Exit

        found:
                fmov d0, d12
                adr x0, msg
                bl printf
                b Exit


function:
//calculates f(x) and returns the result into register d0
	
    scvtf d8, xzr
	mov x5, x3 //loop counter
	function_L1:
        cmp x5, 0
		b.lt function_end_loop
		mov x8, x5 //second loop counter
		lsl x13, x5, 3
		ldr d6, [x7, x13]
		fmov d7, d0
		b.eq baseCase

		function_L2:
            cmp x8, 1
            b.le function_end_loop2
            fmul d7, d7, d0
            sub x8, x8, 1
            b function_L2

		baseCase:
            fadd d8, d8, d6
            b function_end_loop

		function_end_loop2:
            fmul d7, d6, d7
            fadd d8, d8, d7
            sub x5, x5, #1
            b function_L1

        function_end_loop:
            fmov d0, d8
            br x30
	
//exits the program
Exit:
	mov x0, #0
	mov w8, #93
	svc 0


.data
coeff: .double 0.2, 3.1, -0.3, 1.9, 0.2
n: .dword 4 //NMAX = 4
a: .double -1.0 //a = -1
b: .double 1.0 //b = 1
tol: .double 0.01 // tol = .01
msg: .ascii "%lf\n\0"
no_value_msg: .ascii "A value wasn't found\n\0."
.end 

