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

section .text

.global _malloc
.global _free

;; PARAMS:
;;   [bytes to allocate]
;; RETURNS:
;;   [address of malloced space]
_malloc:
    push rbp
    mov rbp, rsp

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
    
    pop rbp

    ret

;; PARAMS:
;;   [address of space] [byte len]
;; RETURNS:
;;   none
_free:
    push rbp
    mov rbp, rsp

    mov rax, SYS_MUNMAP
    mov rdi, [rbp] ;; First argument (addr)
    mov rsi, [rbp + 8] ;; Second argument (len)

    syscall

    pop rbp

    ret