bits    64
default rel

global main

extern  printf
extern  scanf

section .data
    x_k_input_format db '%d %lf', 0
    one dq 1.0
    zero dq 0.0

    printf_format db "e^x = %f", 0xA, 0

section .bss
    k resd 1
    x resq 1

section .text

main:
	sub     rsp, 8

    lea     rsi, [k]
    lea     rdx, [x]
    lea     rdi, [x_k_input_format]
    mov     al, 0

    call    scanf wrt ..plt

    movlps xmm0, [one]
    movlps xmm1, [one]
    movlps xmm2, [zero]

    mov rcx ,1

    mov rbx, [k]
    mov rcx, 1
    loop:
    ;
    cmp rcx, rbx
    jg loop_end
    ;

    mulsd xmm1, [x]
    
    addsd xmm2, [one]
    ;
    divsd xmm1, xmm2
    addsd xmm0, xmm1

    inc rcx
    jmp loop
    loop_end:

    ;add lower part of xmm1
    addsd xmm4, xmm0

    ;if even add upper
    test dword [k], 1
    jnz not_even
        movhlps xmm5, xmm0
        addsd xmm4, xmm5
    not_even:

    ;printing
    movups xmm0, xmm4
    lea rdi, [printf_format]
    mov al, 1
    call printf wrt ..plt

    add rsp, 8

	ret
