// Thomas Martin
// cda3101 - sp2023 - Resch
// Programming assignment 2
// Solution is based off the factv2.s file found in canvas files

.data
// to hold input number
// readformat:     .asciz "%d"

.text
// input message
enter: .asciz "Please enter a number: "

// error message
error: .asciz "Please input a positive number \n"

// output number on each iteration
i: .asciz " %d \n"

// number format specifier to read correct data type
readformat:     .asciz "%d"

.balign 4
.global main

// main
main:
    // save frame pointer and return address on stack
    stp x29, x30, [sp, -16]!
    
    // set frame pointer to current stack pointer
    mov x29, sp

    // print prompt
    ldr x0, =enter
    bl printf

afterprint:
    // get value
    // have scanf place its result on the stack
    // second argument to scanf will be an address on the stack (not a static address)
    sub sp, sp, #16

    // load specifier so we read proper int data type
    ldr x0, =readformat
    // store on stack so we don't use global
    mov x1, sp
    bl scanf

//save the value from the stack
afterscan:

    ldr x9, [sp]

    // check if the input value is negative
    ldr w1, [sp]
    cmp w1, #0
    b.lt input_error

    //restore the stack
    add sp, sp, #16

    //put the read value into an argument
    mov x0, x9
    bl factorial
    b done

// handle input error (negative numbers)
input_error:
    ldr x0, =error
    bl printf
    b exit

// factorial function
factorial:

    // allocate space for 2 items on the stack
    sub sp, sp, #16
    mov x9, x30

    // save the return address
    stur x9, [sp, #8]

    // save the argument
    stur x0, [sp, #0]

    // if for n < 2
    subs x9, x0, #1

    // if n >= 1, go to L1
    b.ge recurse

    // allocate space for two items on stack
    sub sp, sp, #16
    mov x9, x30

    // save the return address
    stur x9, [sp, #8]

    // save the argument
    stur x0, [sp, #0]

    // move to x1 for printing
    mov x1, x0
    ldr x0, =i
    bl printf

    // restore argument after returning from bl
    ldur x0, [sp, #0]

    // restore the return address
    ldur x9, [sp, #8]

    // move x9 to return address
    mov x30, x9

    // deallocate stack space
    add sp, sp, #16

    mov x1, #1

    // dellocate two items from stack
    add sp, sp, #16

    // return to caller
    br x30

// recursive case
recurse:

    // adjust stack for 2 items
    sub sp, sp, #16
    mov x9, x30

    // save the return address
    stur x9, [sp, #8]

    // save the argument
    stur x0, [sp, #0]

    // move to x1 to print
    mov x1, x0
    ldr x0, =i
    bl printf

    // return from BL: restore argument n
    ldur x0, [sp, #0]

    // restore the return address
    ldur x9, [sp, #8]
    mov x30, x9

    // deallocate stack space
    add sp, sp, #16

    // n >= 1: argument gets (n − 1)
    sub x0, x0, #1

    // call factorial with (n − 1)
    bl factorial

    //restore stack after return from base case
    // return from BL: restore argument n
    ldur x0, [sp, #0]

    // restore the return address
    ldur x9, [sp, #8]
    mov x30, x9

    // dellocate 2 items from stack
    add sp, sp, #16

    // x0 has n, x1 has result of recursive call
    // return n * fact (n − 1)
    mul x1, x0, x1

    // allocate space on the stack for 2 items
    sub sp, sp, #16
    mov x9, x30

    // save the return address on stack
    stur x9, [sp, #8]

    // save the answer on stack
    stur x1, [sp, #0]

    // move to x1 for printing
    mov x1, x0
    ldr x0, =i
    bl printf

    // restore answer
    ldur x1, [sp, #0]

    // restore the return address
    ldur x9, [sp, #8]
    mov x30, x9

    // deallocate stack space for two items
    add sp, sp, #16

    // end this recursive call
    br x30

// end functions
done:
    mov x0, 0
end:
    ldp x29, x30, [sp], 16
ret
