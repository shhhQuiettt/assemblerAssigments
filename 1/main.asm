bits    64
default rel

global main

extern  printf
extern  scanf

section .data
	; input   db 'Hello World!', 0
    format  db '%s', 0

section .bss
    input   resb 1024
	output  resd 1024

section .text

main:
	sub     rsp, 8


    lea     rdi, [format]
    lea     rsi, [input]
    xor     eax, eax
    call    scanf wrt ..plt


	;   length of the input string
	mov rcx, 0

	lea rsi, [input]
    mov r8, rsi
    loop:
        cmp byte [r8], 0x0;
        je loop_end

        inc rcx
        inc r8
        jmp loop
    loop_end:
    ;
        
	mov rdi, output

	rep movsb


    ;message - second argument
    mov rdi, output
    push rdi
    ;format string  - first argument
    mov rax, format
    push rax

    call printf wrt ..plt

    ;cleaning printf arguments
    add rsp, 16

    add rsp, 8

	ret
