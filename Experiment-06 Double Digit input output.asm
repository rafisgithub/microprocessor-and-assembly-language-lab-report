include emu8086.inc
org 100h

.data
    res db ?
    rem db ?
    prompt db "Enter a double digit number: $"
    resultMsg db "The double digit number is: $"
    newline db 0Dh, 0Ah, '$'

.code
    mov ax, @data
    mov ds, ax

    mov dx, offset prompt
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov bl, al

    mov al, bl
    mov ah, 00
    mul byte ptr 10
    mov cl, al

    mov ah, 01h
    int 21h
    sub al, '0'
    add al, cl
    mov cx, ax

    mov bl, 10
    div bl
    mov res, al
    mov rem, ah

    mov dx, offset newline
    mov ah, 09h
    int 21h

    mov dx, offset resultMsg
    mov ah, 09h
    int 21h

    mov al, res
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    mov al, rem
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    mov ah, 4Ch
    int 21h
