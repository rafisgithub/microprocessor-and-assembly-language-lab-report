include 'emu8086.inc'
org 100h

.data
    star db '*'       
    newline db 0Dh, 0Ah 
    input db 0              
    
    prompt db 'Enter a single digit number (1-9): $'

.code
start:

    mov ah, 09h        
    lea dx, [prompt]   
    int 21h           

    ; Read input
    mov ah, 01h        
    int 21h            
    sub al, '0'        
    mov input, al      

    ; Print a newline after input
    mov ah, 02h        
    mov dl, newline[0]
    int 21h            
    mov dl, newline[1] 
    int 21h            

    
    mov cl, input      

outer_loop:
    ; Set inner loop counter (number of columns)
    mov ch, input      

inner_loop:
    ; Print a star
    mov ah, 02h        
    mov dl, star       
    int 21h            

    ; Decrement inner loop counter
    dec ch
    jnz inner_loop    

    ; Print a newline after each row
    mov ah, 02h        
    mov dl, newline[0] ; Print carriage return
    int 21h                                      
    mov dl, newline[1] ; Print line feed
    int 21h            

    ; Decrement outer loop counter
    dec cl
    jnz outer_loop    

    
    mov ax, 4C00h      
    int 21h            

end start
