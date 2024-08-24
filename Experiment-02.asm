include 'emu8086.inc'
org 100h

.data
    prompt db 'Enter password: $'
    correct_password db 'admin$', 0
    buffer db 20 dup('$')   ; Buffer to store user input
    correct_msg db 'Password is correct.$'
    incorrect_msg db 'Password is incorrect.$'
    newline db 0Dh, 0Ah, '$'

.code
start:
    ; Print prompt
    mov ah, 09h
    lea dx, [prompt]
    int 21h

    ; Read user input
    lea dx, [buffer]
    mov ah, 0Ah          ; DOS function to read string input
    int 21h              ; Read input into buffer

    ; Null terminate the input
    mov bl, [buffer + 1] ; Length of input
    

    ; Compare user input with predefined password
    lea si, [buffer + 2] ; Skip the input length byte
    lea di, [correct_password]
    call compare_strings

    ; Print result
    cmp al, 0            ; Check if strings are equal
    je password_correct  ; If equal, jump to correct message
    jne password_incorrect ; If not equal, jump to incorrect message

password_correct:
    mov ah, 09h
    lea dx, [correct_msg]
    int 21h
    jmp end_program

password_incorrect:
    mov ah, 09h
    lea dx, [incorrect_msg]
    int 21h

end_program:
    ; Print a newline
    mov ah, 09h
    lea dx, [newline]
    int 21h

    ; Exit to DOS
    mov ax, 4C00h
    int 21h

compare_strings:
    ; Compare strings pointed to by SI and DI
compare_loop:
    mov al, [si]         ; Load byte from user input
    mov bl, [di]         ; Load byte from correct_password
    cmp al, bl           ; Compare characters
    jne not_equal        ; If not equal, jump to not_equal
    test al, al          ; Check if end of string (null terminator)
    jz equal             ; If zero, strings are equal
    inc si               ; Move to the next character
    inc di
    jmp compare_loop     ; Continue comparing
not_equal:
    mov al, 1            ; Set AL to 1 (indicating not equal)
    ret
equal:
    mov al, 0            ; Set AL to 0 (indicating equal)
    ret
