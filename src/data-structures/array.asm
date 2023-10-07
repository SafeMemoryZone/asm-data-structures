section .text

.global _new_arr
.extern _malloc
.extern _free

;; PARAMS:
;;   [element size in bytes]
;; RETURNS:
;;   [array pointer] (should only be used by array.asm)
_new_arr:
    push rbp
    mov rbp, rsp

    add [rsp], 8 ;; header bytes

    call _malloc

    movq [rax], 0 ;; reset memory

    ;; make header
    ;; [0 - 32] idx, [0 - 32 capacity]
    mov rdi, 0
    sub [rsp], 8
    or rdi, [rsp]
    shl rdi

    pop rbp

    ret
