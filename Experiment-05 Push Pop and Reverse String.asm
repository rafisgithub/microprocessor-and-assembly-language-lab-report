include emu8086.inc
org 100h

.data
    prompt db "Enter any string: $"
    reversedMsg db "Reversed string is: $"
    newline db 0Dh, 0Ah, '$'

.code
    mov ax, @data
    mov ds, ax

    mov dx, offset prompt
    mov ah, 09h
    int 21h

    mov cx, 0                  

read_loop:
    mov ah, 01h
    int 21h
    cmp al, 13                 
    je reverse_string
    mov bl, al
    push bx                    
    inc cx                     
    jmp read_loop

reverse_string:
   
    mov dx, offset newline
    mov ah, 09h
    int 21h

    
    mov dx, offset reversedMsg
    mov ah, 09h
    int 21h

print_loop:
    pop dx                    
    mov ah, 02h
    mov dl, dl                 
    int 21h
    loop print_loop            

    mov ah, 4Ch
    int 21h
