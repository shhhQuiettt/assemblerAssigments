bits    64
default rel

global main

extern  printf
extern  scanf

section .data
    x_k_input_format db '%d %lf', 0
    one dq 1.0
    two dq 2.0

   
    align 16
    one_two_vector dq 1.0, 2.0
    align 16
    ones_vector dq 1.0, 1.0

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


    ;[x^2, x]
    movhps xmm0, [x]
    movlps xmm0, [x]
    mulsd   xmm0, xmm0
    shufpd xmm0, xmm0, 1

    ;[x^2;x^2]
    movhlps xmm1, xmm0
    movlhps xmm1, xmm1

    ;factorial multipliers
    movups xmm2, [one_two_vector]

    divpd xmm0, xmm2

    ;result
    movlps xmm4, [one]


    mov rbx, [k]
    mov rcx, 2
    loop:
    ;
    cmp rcx, rbx
    jge loop_end
    ;

    ;add lower part of xmm1
    addsd xmm4, xmm0
    ;add uper part of xmm1
    movhlps xmm5, xmm0
    addsd xmm4, xmm5

    ;maths
    mulpd xmm0, xmm1

    addpd xmm2, [ones_vector]
    divpd xmm0, xmm2

    addpd xmm2, [ones_vector]
    divpd xmm0, xmm2

    add rcx, 2
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
