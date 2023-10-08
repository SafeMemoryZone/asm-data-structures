section .text

%define ARR_HEADER_SIZE 8
%define ARR_ELEMENT_SIZE 8

.global _arr_new
.global _arr_append
.extern _malloc
.extern _free

; void *_arr_new()
_arr_new:
    ; [TODO]

; void *_arr_append(void *ptr, unsigned long long value)
_arr_append:
    ; [TODO]