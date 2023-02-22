//Burak Yesil
//I pledge my honor that I have abided by the Stevens Honor System.



//Also, I went to Weihan Wang's lab period for help because I had a family emergency and couldn't make it to section A, and he said my code was correct.

.text
.global _start 
.extern printf

_start:

    ADR X0, a     //X0 = a Address
    LDUR D20, [X0]


    //Loading Delta from .Data
    ADR X0, Delta   //X0 = Delta Address
    LDUR D10, [x0] 
    FMOV D11, D10   //D11 = Value of Delta = .001


    //Loading Right from .Data
    ADR X0, b   //X0 = b Address
    LDUR D10, [x0]  
    FMOV D12, D10   //D12 == b Value = 5.0


    //Loading Sum from .Data
    ADR X0, Sum     //X0 = Sum Address
    LDUR D10, [X0]
    FMOV D1, D10    //D1 = Sum 


    //Breaking and Linking to procedures
    BL Funct 
    BL L1


L1: //Computes the integral using box method; In other words, this is sigma from -.05 to 5 of f(x) * (.001/delta x)
    FADD D20, D20, D11
    FCMP D20, D12
    B.GE End 
    BL Funct 
    B L1

Funct: //Calculates the height at a given input x 
    //LOADING IN COEFFICIENTS 
    FMOV D18, 2.5  //D18 = 2.5
    FMOV D19, 15.5 //D19 = 15.5 
    FMOV D17, 20.0 //D17 = 20.0
    FMOV D16, 15.0 //D16 = 15.0
    

    //Calculating 2.5(X^3)
    FMUL D21, D20, D20
    FMUL D21, D21, D20
    FMUL D21, D21, D18


    //Calculating 15.5(X^2)
    FMUL D22, D20, D20
    FMUL D22, D22, D19

    //Calculating 20(X)
    FMUL D23, D20, D17


    //Combining components of the function
    FSUB D21, D21, D22
    FADD D21, D21, D23
    FADD D21, D21, D16


    //Adding the function result to the Final integral result
    FADD D1, D1, D21





End:


    //prints the approximated result 
    ADR x0, print_num
    FMUL d1, d11, d1
    FMOV D0, D1
    FMOV D19, D0 //D19 = Approximated result
    BL printf 



   //Prints the actual value
    ADR X0, ActualValue   //X0 = Actual Address
    LDUR D10, [x0] 
    FMOV D11, D10 
    ADR x0, print_actual
    FMOV D0, D11
    FMOV D20, D0 //D20 = Actual Result
    BL printf


    //Printing out differnce
    ADR x0, print_difference 

    ADR x5, Delta
    LDUR D0, [x5]
    BL printf

    BL Exit


Exit: 

    MOV X0, 0
    MOV w8, 93
    SVC 0


.data

print_num: .ascii "Sum is: %lf\n\0"

print_actual: .ascii "Actual Value is: %lf\n\0"

print_difference: .ascii "Difference is ((abs(-.5) + abs(5))/5500: %lf\n\0"

a: .double -.5  //Left Limit

b: .double 5.0 //Right Limit

Delta: .double .001 // Delta = (abs(-.5) + abs(5))/5500 = .001 as explained in Weihan Wang's lab

Sum: .double 0.0

ActualValue: .double 74.1069775

n: .double 5500 // Weihan Wang explained that this is the minimum number of boxes and said I should calculate this by hand.
                // Based on Weihan's calculation explanation during the lab, n can be greater than or equal to 5500


.end


