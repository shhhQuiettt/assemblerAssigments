bits    64
default rel

global main

extern  printf
extern  scanf

section .data
	; input   db 'Hello World!', 0
    format  db '%lf', 0
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
    movlpd  xmm1, [end]

    pxor     xmm2, xmm2
    loop:
    ; cmpltsd xmm1, [zero]
    ; movq rax, xmm0
    ; cmp rax, 0
    ; je end_loop
    
    ; mov rax,  
    ; subss xmm1, 
    


    end_loop:
    ; sqrtsd  xmm0, xmm1
    ; lea     rdi, [format]
    ; mov     al, 1
    ; call    printf wrt ..plt

    ;lea     rdi, [format]
    ;lea     rsi, [input]
    ;xor     eax, eax
    ;call    scanf wrt ..plt


	;;   length of the input string
	;mov rcx, 0

	;lea rsi, [input]
    ;mov r8, rsi
    ;loop:
    ;    cmp byte [r8], 0x0;
    ;    je loop_end

    ;    inc rcx
    ;    inc r8
    ;    jmp loop
    ;loop_end:
    ;;
        
	;mov rdi, output

	;rep movsb


    ;;message - second argument
    ;mov rdi, output
    ;push rdi
    ;;format string  - first argument
    ;mov rax, format
    ;push rax

    ;call printf wrt ..plt

    ;;cleaning printf arguments
    ;add rsp, 16

    add rsp, 8

	ret
