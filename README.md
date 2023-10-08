# Data Structures in Assembly Language

This repository contains the implementation of common data structures, written in Assembly Language, as part of a personal challenge. The goal is to understand the inner workings and design of fundamental data structures at a low level.

### 🧪 Testing
All functions are tested using C. That's why my code adheres to the x86_64 cdecl calling convention, which are as follows:

* Registers rdi, rsi, rdx, rcx, r8, r9, r10, r11 are caller saved (rdi through r9 are parameters)

* All other parameters are pushed onto the stack (right to left)

* After the subroutine returns, (i.e. immediately following the call instruction) the caller must 
remove any additional parameters (beyond the six stored in registers) from stack

* The caller can expect to find the return value of the subroutine in the register RAX

* The caller restores the contents of caller-saved registers (r10, r11, and any in the parameter passing
registers) by popping them off of the stack. The caller can assume that no other registers were
modified by the subroutine

* The callee-saved registers are RBX, RBP, and R12 through R15

* The function must restore the old values of any callee-saved registers (RBX, RBP, and R12 through R15) that were modified


## 💾 Data Structures Implemented (or yet to implement)
- dynamic array (stack)
- linked list
- string
- tree

## 🐛 Contributing
While I appreciate the interest, I am currently only accepting contributions in the form of bug fixes. This is primarily a learning project, and I would like to implement the data structures myself to gain a deeper understanding of their workings. However, if you find any issues or discrepancies, please feel free to open an issue.

### Opening an Issue
1. **Check Existing Issues:** Before creating a new issue, please check the existing open issues to avoid duplicates.
2. **Provide Detailed Information:** When opening a new issue, provide as much detail as possible about the bug, including steps to reproduce it and any potential fixes you might suggest.