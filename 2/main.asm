bits    64
default rel

global main

extern  printf
extern  scanf

section .data
	; input   db 'Hello World!', 0
    format  db '%d', 0
    print_format db '%d ', 0
    ; print_format db 'aaa', 0

section .bss
    array   resd 100

section .text


main:
    sub     rsp, 8
    ; push      0x6999


    mov     rbx, 0

    ;read the array
    loop:

    lea     rdi, [format]
    lea     rsi, [array]
    add     rsi, rbx
    xor     rax, rax

    call    scanf wrt ..plt
    ; inc     rbx
    add     rbx, 4
    cmp     rax, 1
    je      loop
    ;


    ;sorting
    sub     rbx, 4
    mov     r8,  0
    loop_outer:
        cmp     r8,  rbx
        jge      end_loop_outer

        mov     r9,  rbx
        sub     r9,  4
        loop_inner:
            cmp r9, r8
            jle end_loop_inner
            ; loop body

            if:
                lea rsi,  [array]
                add rsi,  r9
                ; movzx r11,  byte [rsi - 1]
                ; movzx r12,  byte [rsi]
                mov r11d, dword [rsi - 4]
                mov r12d, dword [rsi]

                cmp r11d, r12d
                jle end_if
                
                ;if body
                ; mov byte [rsi], r11b
                ; mov byte [rsi-1], r12b
                mov dword [rsi], r11d
                mov dword [rsi-4], r12d
                ;


            end_if:



            ;
            sub r9, 4
            jmp loop_inner

        end_loop_inner:
    ; inc r8
        add r8, 4

    jmp loop_outer
    end_loop_outer:



    ;printing
    mov     r12, 0
    
    printf_loop:
    cmp     r12, rbx
    jge     end_printf_loop

    ; ; lea     rsi, [array]
    ; mov     rdi, array
    ; add     rdi, r12
    ; push    rdi
    ; mov     rdi [rdi]

    ; ; lea     rdi, [format]
    ; mov     rax , print_format
    ; lea     rdi, [ help ]
    ; push    rax
    ; push    rax
    mov     rdi, print_format

    mov     rsi, array
    add     rsi, r12
    mov     esi, dword [rsi]
    mov     al, 0

    call    printf wrt ..plt
    ; add     rsp, 16

    ; inc     r12
    add     r12, 4
    jmp     printf_loop
    end_printf_loop:

    add     rsp, 8
    xor     rax, rax
	ret

