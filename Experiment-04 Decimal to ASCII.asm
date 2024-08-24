include emu8086.inc
org 100h

.data
    prompt db "Enter a single digit (0-9): $"
    resultMsg db "The ASCII character is: $"
    newline db 0Dh, 0Ah, '$'

.code
    mov ax, @data
    mov ds, ax

    
    mov dx, offset prompt
    mov ah, 09h
    int 21h

    
    mov ah, 01h
    int 21h
    mov bl, al                

    
    sub al, '0'               

    mov dx, offset newline
    mov ah, 09h
    int 21h

    mov dx, offset resultMsg
    mov ah, 09h
    int 21h

    mov al, bl              
    mov dl, al
    mov ah, 02h
    int 21h

    mov dx, offset newline
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
