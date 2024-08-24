include emu8086.inc
org 100h

.data
    arr3 db 20 dup(?) 
    var1 db ?
    prompt1 db "Enter array input: $"
    prompt2 db "Enter what you want to find: $"
    notFoundMsg db "Not Found :|$"
    invalidMsg db "Invalid input!$"
    foundMsg db "Found :)$"
    newline db 0Dh, 0Ah, '$'

.code
    mov ax, @data
    mov ds, ax

    
    mov dx, offset prompt1
    mov ah, 09h
    int 21h

    
    lea si, arr3
    mov cx, 0                  


    for1:
        mov ah, 01h
        int 21h
        cmp al, 13
        je next                
        sub al, '0'            
        mov [si], al           
        inc si
        inc cx                 
        jmp for1

    next:
        mov si, offset arr3    

        mov dx, offset newline
        mov ah, 09h
        int 21h

        mov dx, offset prompt2
        mov ah, 09h
        int 21h

        mov ah, 01h
        int 21h
        cmp al, 13
        je invalid             
        sub al, '0'            
        mov var1, al

        mov dx, offset newline
        mov ah, 09h
        int 21h

  
        mov si, offset arr3
        mov bx, cx             

     
        for2:
            mov dl, [si]      
            cmp dl, var1     
            je found          
            inc si            
            loop for2         

        mov dx, offset notFoundMsg
        mov ah, 09h
        int 21h
        jmp stp

    invalid:
        mov dx, offset invalidMsg
        mov ah, 09h
        int 21h
        jmp stp

    found:
        mov dx, offset foundMsg
        mov ah, 09h
        int 21h

    stp:

        mov ah, 4Ch
        int 21h
