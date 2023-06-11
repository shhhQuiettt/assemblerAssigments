bits    64
default rel

global main

extern  printf
extern  scanf

section .data
    format  db '%lf', 0
    format2 db 'sqrt(%f) = %f ', 0xA, 0
    one_eighth  dq 0x3FC0000000000000

section .bss
    end resq 1

section .text

main:
	sub     rsp, 8

    lea     rsi, [end]
    lea     rdi, [format]
    mov     al, 0
    call    scanf wrt ..plt
    movlpd  xmm2, [end]

    pxor     xmm0, xmm0

    ; xmm0 stores incremented value
    ; xmm1 stores computed square
    ; xmm2 stores boundry
    loop:
    ; while xmm1 less than or equal xmm2
    comisd  xmm0, xmm2
    ja      end_loop
    je      end_loop
    
    sqrtsd  xmm1, xmm0

    ;calling main
    movq  rax, xmm0
    push    rax

    movq  rax, xmm1
    push    rax

    movq  rax, xmm2
    push    rax

	sub     rsp, 8

    lea     rdi, [format2]
    mov     al, 2
    call    printf wrt ..plt

    add     rsp, 8

    pop     rax
    movq     xmm2, rax

    pop     rax
    movq    xmm1, rax

    pop     rax
    movq    xmm0, rax
    ;;;;

    addsd   xmm0, [one_eighth]
    ;
    jmp     loop
    end_loop:

    add rsp, 8

	ret
