include emu8086.inc
org 100h

.data
    prompt db "Enter string: $"
    lengthMsg db "String length: $"

.code
    mov ax, @data
    mov ds, ax

    mov dx, offset prompt
    mov ah, 09h
    int 21h

    mov bx, 0 
input: 
    mov ah, 01h 
    int 21h
    cmp al, 0Dh 
    je output
   
    inc bx 
    cmp bx, 9
    je output
    jmp input

output:
   
    mov ah, 02h
    mov dl, 0Ah 
    int 21h
    mov dl, 0Dh 
    int 21h

 
    mov dx, offset lengthMsg
    mov ah, 09h
    int 21h

    
    add bx, '0' 
    mov dl, bl
    mov ah, 02h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
