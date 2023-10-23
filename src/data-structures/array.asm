section .text

%define ARR_HEADER_SIZE 8

%macro CALLER_PUSH_REGISTERS 0
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
%endmacro

%macro CALLER_POP_REGISTERS 0
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
%endmacro

global _arr_new
global _arr_append
global _arr_pop

extern _malloc
extern _free
extern _memcpy

; void *_arr_new()
_arr_new:
    ; create an array header

    ; 64         32        0
    ; ----------------------
    ; | INDEX |  CAPACITY  |     
    ; ----------------------

    mov rdi, ARR_HEADER_SIZE + 8 ; add one element
    call _malloc ; it doesn't matter that it overwrites other registers
    mov qword [rax], 1 ; reset array header to set capacity to 1 and idx to 0

    ret

; void *_arr_append(void *ptr, unsigned long long value)
_arr_append:
    mov r8, [rdi] ; read value of rdi into r8
    and r8, 0xFFFFFFFF ; clean the rest of the bits

    mov r9, [rdi] ; copy the value again into r9
    shr r9, 32 ; shift r9 right to set lower bits of r9 to index

    ; at this point r8 contains the capacity and r9 contains the index 
    cmp r9, r8
    je .append ; skip expanding if the element can fit

    imul r8, 2 ; double the capacity

    CALLER_PUSH_REGISTERS
    add r8, ARR_HEADER_SIZE
    mov rdi, r8 ; length
    call _malloc
    CALLER_POP_REGISTERS
    ; now rax contains new array
    ; void _memcpy(void *dest, void *src, unsigned long long length)
    CALLER_PUSH_REGISTERS
    lea rsi, [rdi + ARR_HEADER_SIZE]
    lea rdi, [rax + ARR_HEADER_SIZE]
    mov rdx, r8
    call _memcpy
    CALLER_POP_REGISTERS

    push rax
    call _free
    pop rax
    mov rdi, rax

    mov dword [rdi], r8d ; write back new capacity

    .append:
        mov [rdi + ARR_HEADER_SIZE + 8 * r9], rsi ; element
        inc r9 ; update index
        shl r9, 32
        and qword [rdi], 0xFFFFFFFF
        or qword [rdi], r9

    ret

; unsigned long long _arr_pop(void *ptr)
_arr_pop:
    mov r8, [rdi]
    shr r8, 32
    dec r8

    mov rax, [rdi + ARR_HEADER_SIZE + r8 * 8 - 8]
    mov rax, r8

    shl r8, 32
    and qword [rdi], 0xFFFFFFFF
    or [rdi], r8

    ret