;; This file is not meant to be ran
;; registers EBX ESI EDI EBP are callee saved
;; the callee can freely use EAX ECX EDX while eax is the return value

%define SYS_MMAP 9
%define SYS_MUNMAP 11

%define ADDRESS_ANY 0x0
%define NO_FD 0x0

%define PROT_READ        0x1
%define PROT_WRITE        0x2
%define PROT_EXEC        0x4
%define PROT_NONE        0x0

%define MAP_ANONYMOUS        0x20
%define MAP_SHARED        0x01
%define MAP_PRIVATE        0x02
%define MAP_FIXED        0x10

%macro cdecl_before_func 0
    push rbp
    push rdi
    push rsi
    push rbx
    mov rbp, rsp
%endmacro

%macro cdecl_after_func 0
    pop rbx
    pop rsi
    pop rdi
    pop rbp
%endmacro

section .text

global _start
_start:
    push 8
    call _malloc
    add rsp, 8 ;; cleanup stack
    ;; return value in rax
    push 8
    push rax
    call _free
    add rsp, 16 ;; cleanup stack

    mov rax, 60    ; syscall number for exit in 64-bit
    mov rdi, 0   ; exit code 0
    syscall

_malloc:
    cdecl_before_func

    mov rax, SYS_MMAP
    mov rdi, ADDRESS_ANY
    mov rsi, [rbp]
    mov rdx, 0 ;; Reset rdx
    or rdx, PROT_READ
    or rdx, PROT_WRITE
    mov r10, 0 ;; reset r10
    or r10, MAP_ANONYMOUS
    or r10, MAP_PRIVATE
    mov r8, NO_FD
    mov r9, 0
    
    cdecl_after_func

    ret

;; addr, len
;; len - rbp
;; addr - rbp + 8

_free:
    cdecl_before_func

    mov rax, SYS_MUNMAP
    mov rdi, [rbp] ;; First argument (addr)
    mov rsi, [rbp + 8] ;; Second argument (len)

    cdecl_after_func

    ret