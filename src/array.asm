section .text
global _start
_start:
    mov rax, 60    ; syscall number for exit in 64-bit
    mov rdi, 0   ; exit code 0
    syscall
