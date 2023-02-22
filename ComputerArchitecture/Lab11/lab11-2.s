//Lab 11
//"I pledge my honor that I have abided by the Stevens Honor System."
//Burak Yesil

.text
.global _start
.extern printf

_start:
    //setting up the max variables 
    mov     x8,  -1  /* outer index i*/
    mov    x9,  #0     /* inner index j*/
    adr    x0, max
    ldur    d10, [x0]
    fmov    d9, d10      /*load max to d9*/
    adr     x0, x
    adr    x2, y
    mov    x3, #0
    mov    x4, #1


    //setting up the min variables 

    adr x17, min
    ldr d20, [x17]


    b  outer




inner:
    mov    x11, #8
    mul    x10, x8, x11
    ldr    d10, [x0, x10] /* load xi*/
    ldr    d11, [x2, x10] /* load yi*/
    mul    x10, x9,x11
    ldr    d12, [x0, x10] /* load xj*/
    ldr    d13, [x2, x10] /* load yi*/
    cmp    x9, x7
    bge    outer
    bl     distance

outer:
    adr x7, N
    ldr x7, [x7]
    cmp x8, x7 
    b.GE exit
    add x8, x8, 1
    mov x9, 0
    bl inner

innerindex:
    add    x9, x9, #1
    bl     inner

distance:
    fsub    d10, d10, d12
    fmul    d10, d10, d10
    fsub    d11, d11, d13
    fmul    d11, d11, d11
    fadd     d11, d10, d11
    fcmp    d11, d9
    bge    updatemax
    fcmp d11, d20
    blt updatemin
    bl    innerindex

updatemax: //updates the value of the max indices
    fmov     d9, d11
    mov    x3, x8
    mov    x4, x9
    bl    innerindex

updatemin: //updates the value of the min indices
    cmp x8, x9
    b.eq innerindex
    fmov     d20, d11
    mov    x22, x8
    mov    x23, x9
    bl    innerindex

exit:
    //prints the max
    ldr x0, =printarrMax
    mov    x1, x3
    mov    x2, x4
    bl printf

    //prints the min
    ldr x0, = printarrMin
    mov x1, x22
    mov X2, x23
    bl printf  

    mov x0, 0
    mov x8, 93
    svc 0
    


.data

N:
.dword 7 //index limit even though there are 8 numbers the max index is 7

max: 
    .double 0.0

min:
    .double 10000.0

x:
    .double 0.0, 0.4140, 1.4949, 5.0014, 6.5163, 3.9303, 8.4813, 2.6505

y:
    .double 0.0, 3.9862, 6.1488, 1.047, 4.6102, 1.4057, 5.0371, 4.1196

printarrMax:
    .ascii "The max indices are %d and %d \n\0"

printarrMin:
    .ascii "The min indices are %d and %d \n\0"

.end


