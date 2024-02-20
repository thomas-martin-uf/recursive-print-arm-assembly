# Project
Simple ARM program that takes takes an input n and uses recursion to print n down to zero and back to n.

# Constraints
Your inputs n cannot be stored as a global variable at any point. This means you cannot store them at a data section address, even when accepting them from scanf; they must be returned from scanf on the stack.

X19-X27 are global variables. You may not use X19-X27 in your recursive function. If you want, you may use X19-X27 in your main function.  You can use any registers you want to in your main function.

A recursion procedure requires:
- Allocate stack space
- Save the return address and argument on the stack
- Recursively call procedure with BL
- Unwind the stack by restoring the return address and arguments and deallocating stack memory

# Sample Ouput
![image](https://github.com/thomas-martin-uf/recursive-print-arm-assembly/assets/109101463/29e96da8-291b-4dac-ae5e-88ea88592890)
