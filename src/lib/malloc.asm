%define SYS_MMAP 9
%define SYS_EXIT 60
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
    push 8 ;; malloc 8 bytes
    call _malloc
    add rsp, 8 ;; cleanup stack

    ;; return value in rax (address of malloced space)
    push 8 ;; argument 2 - len
    push rax ;; argument 1 - address
    call _free
    add rsp, 16 ;; cleanup stack

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall

;; PARAMS:
;;   [bytes to allocate]
;; RETURNS:
;;   [address of malloced space]
_malloc:
    cdecl_before_func

    mov rax, SYS_MMAP
    mov rdi, ADDRESS_ANY
    mov rsi, [rbp] ;; Length 
    mov rdx, 0 ;; Reset rdx
    or rdx, PROT_READ
    or rdx, PROT_WRITE
    mov r10, 0 ;; reset r10
    or r10, MAP_ANONYMOUS
    or r10, MAP_PRIVATE
    mov r8, NO_FD
    mov r9, 0

    syscall
    
    cdecl_after_func

    ret

;; PARAMS:
;;   [address of space] [byte len]
;; RETURNS:
;;   none
_free:
    cdecl_before_func

    mov rax, SYS_MUNMAP
    mov rdi, [rbp] ;; First argument (addr)
    mov rsi, [rbp + 8] ;; Second argument (len)

    syscall

    cdecl_after_func

    ret