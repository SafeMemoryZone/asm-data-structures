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
extern _malloc
extern _free
extern _memcpy

; void *_arr_new()
_arr_new:
    push rbp
    mov rbp, rsp

    ; create an array header

    ; 64         32        0
    ; ----------------------
    ; | INDEX |  CAPACITY  |     
    ; ----------------------

    mov rdi, ARR_HEADER_SIZE
    call _malloc ; it doesn't matter that it overwrites other registers
    mov [rax], 0 ; reset array header to set capacity and idx to 0

    pop rbp

    ret

; void *_arr_append(void *ptr, unsigned long long value)
_arr_append:
    push rbp
    mov rbp, rsp

    ; rdi contains ptr and rsi contains the value to append
    mov r8, [rdi] ; read value of rdi into r8
    and r8, 0xFFFFFFFF ; clean the rest of the bits

    mov r9, [rdi] ; copy the value again into r9
    shr r9, 32 ; shift r9 right to set lower bits of r9 to index

    ; at this point r8 contains the capacity and r9 contains the index 
    cmp r9, r8
    jl .append ; skip expanding if the element can fit

    ; here, we expand the array

    ; malloc new array
    CALLER_PUSH_REGISTERS
    mul r8, 2 ; double the capacity
    mov rdi, r8 ; doubled capacity is the length
    call _malloc
    CALLER_POP_REGISTERS
    ; new array is in rax
    CALLER_PUSH_REGISTERS
    mov rsi, rdi
    add rax, 8 ; skip header
    mov rdi, rax
    mov rdx, r8
    call _memcpy
    CALLER_POP_REGISTERS
    ; free the old array
    push rsi
    mov rsi, r8 ; second argument is capacity. First argument (ptr) is already in rdi
    call _free
    pop rsi
    
    mov rdi, rax ; update array ptr
    ; at this point, the index in header is not updated yet

    mul r8, 2
    mov [rdi], 0
    or [rdi], r8  ; update capacity

    .append:
        mov [rdi + 8 + r9], rsi ; append value
        inc r9
        mov r10, [rdi] ; move header into r10
        rol r10, 32 ; so we get index on the left side
        or r10, r9

        mov [rdi], r10 ; write updated header back

    pop rbp

    ret