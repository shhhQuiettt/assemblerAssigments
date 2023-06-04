bits    64
default rel

global main

extern  printf
extern  scanf

section .data
	; input   db 'Hello World!', 0
    format  db '%d', 0
    print_format db 'co %c ', 0

section .bss
    array   resb 100

section .text


main:
    sub     rsp, 8
    ; push      0x6999


    mov     rbx, 0
    mov     r8,  0

    ;read the array
    loop:

    lea     rdi, [format]
    lea     rsi, [array]
    add     rsi, r8
    xor     rax, rax

    call    scanf wrt ..plt
    inc     rbx
    add     r8,  4
    cmp     rax, 1
    je      loop

    ;sorting
    sub     rbx, 1
    mov     r8,  0
    loop_outer:
        cmp     r8,  rbx
        jge      end_loop_outer

        mov     r9,  rbx
        sub     r9,  1
        loop_inner:
            cmp r9, r8
            jle end_loop_inner
            ; loop body

            if:
                lea rsi,  [array]
                add rsi,  r9
                movzx r11,  byte [rsi - 1]
                movzx r12,  byte [rsi]

                cmp r11, r12
                jle end_if
                
                ;if body
                mov byte [rsi], r11b
                mov byte [rsi-1], r12b
                ;


            end_if:



            ;
            dec r9 
            jmp loop_inner
        end_loop_inner:
    inc r8
    jmp loop_outer
    end_loop_outer:



    mov     r12, 0
    printf_loop:
    cmp     r12, rbx
    jge     end_printf_loop

    ; lea     rsi, [array]
    mov     rsi, array
    add     rsi, r12
    push    rsi

    ; lea     rdi, [format]
    mov     rdi , print_format
    push    rdi

     xor     rax, rax

    call    printf wrt ..plt
    add     rsp, 16

    inc     r12
    jmp     printf_loop
    end_printf_loop:

    add     rsp, 8
    xor     rax, rax
	ret

