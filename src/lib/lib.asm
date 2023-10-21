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

global _malloc
global _free
global _memcpy

; void *_malloc(unsigned long long length)
_malloc:
    mov rsi, rdi ; Length 

    mov rax, SYS_MMAP
    mov rdi, ADDRESS_ANY
    
    mov rdx, 0 ; Reset rdx
    or rdx, PROT_READ
    or rdx, PROT_WRITE
    mov r10, 0 ; reset r10
    or r10, MAP_ANONYMOUS
    or r10, MAP_PRIVATE
    mov r8, NO_FD
    mov r9, 0

    syscall

    ret

; void _free(void *ptr, unsigned long long length)
_free:
    mov rax, SYS_MUNMAP
    ; all other arguments are already in the correct registers
    syscall

    ret

; void _memcpy(void *dest, void *src, unsigned long long length)
_memcpy:
    mov r8, 0 ; counter
    .loop:
        cmp r8, rdx
        je .done

        mov r9, [rsi + r8 * 8] ; source
        mov [rdi + r8 * 8], r9 ; move source into destination

        inc r8
        
    .done:
        ret