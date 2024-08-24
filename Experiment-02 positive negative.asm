include 'emu8086.inc'
org 100h

.data
    prompt db 'Enter a number (negative or positive): $'
    pos_msg db 'The number is positive.$'
    neg_msg db 'The number is negative.$'
    invalid_msg db 'Invalid input.$'
    newline db 0Dh, 0Ah, '$'
    buffer db 5 dup('$')  ; Buffer to store user input

.code
start:
    ; Print prompt message
    mov ah, 09h
    lea dx, [prompt]
    int 21h

    ; Read user input
    lea dx, [buffer]
    mov ah, 0Ah          ; DOS function to read string input
    int 21h              ; Read input into buffer

    ; Convert ASCII to integer
    lea si, [buffer + 2] ; Skip the input length byte
    movzx ax, byte ptr [si] ; Load the input character to AX
    sub ax, '0'          ; Convert ASCII to integer

    ; Check if the number is positive or negative
    cmp ax, 0
    jge positive         ; If greater than or equal to 0, jump to positive
    jl negative         ; If less than 0, jump to negative

positive:
    ; Print positive message
    mov ah, 09h
    lea dx, [pos_msg]
    int 21h
    jmp end_program

negative:
    ; Print negative message
    mov ah, 09h
    lea dx, [neg_msg]
    int 21h
    jmp end_program

end_program:
    ; Print a newline
    mov ah, 09h
    lea dx, [newline]
    int 21h

    ; Exit to DOS
    mov ax, 4C00h
    int 21h

end start
