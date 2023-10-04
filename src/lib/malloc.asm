;; This file is not meant to be ran
;; registers EBX ESI EDI EBP are callee saved
;; the callee can freely use EAX ECX EDX while eax is the return value

section .text

global _start
_start:
    push 1
    call _malloc
    mov rax, 60    ; syscall number for exit in 64-bit
    mov rdi, 0   ; exit code 0
    syscall

;; void *malloc(uint32_t size)
;; The bug lies withing the malloc function
_malloc:
    push rbp
    push rdi
    push rsi
    push rbx

    mov rbp, rsp

    mov eax, 12
    mov rdi, [ebp]

    syscall

    pop rbx
    pop rsi
    pop rdi
    pop rbp
    
    ret