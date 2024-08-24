include 'emu8086.inc'
org 100h

.data
    newline db 0Dh, 0Ah
    prompt_num db 'Enter a number (0-9): $'
    prompt_char db 'Enter a character (A-Z or a-z): $'
    even_msg db 'The number is even.$'
    odd_msg db 'The number is odd.$'
    pos_msg db 'The number is positive.$'
    neg_msg db 'The number is negative.$'
    vowel_msg db 'The character is a vowel.$'
    consonant_msg db 'The character is a consonant.$'
    invalid_num db 'Invalid number entered.$'
    invalid_char db 'Invalid character entered.$'

.code
start:
    ; Prompt for a number
    mov ah, 09h
    lea dx, [prompt_num]
    int 21h

    ; Get the number input
    mov ah, 01h
    int 21h
    sub al, '0'
    
    ; Validate the number (0-9)
    cmp al, 0
    jl invalid_number
    cmp al, 9
    jg invalid_number

    ; Check even/odd
    test al, 1
    jz even_number
    jmp odd_number

even_number:
    ; Print even message
    mov ah, 09h
    lea dx, [even_msg]
    int 21h
    jmp check_positive

odd_number:
    ; Print odd message
    mov ah, 09h
    lea dx, [odd_msg]
    int 21h

check_positive:
    ; Check positive/negative
    cmp al, 0
    jl negative_number
    jmp positive_number

positive_number:
    ; Print positive message
    mov ah, 09h
    lea dx, [pos_msg]
    int 21h
    jmp continue_program

negative_number:
    ; Print negative message
    mov ah, 09h
    lea dx, [neg_msg]
    int 21h
    jmp continue_program

invalid_number:
    ; Print invalid number message
    mov ah, 09h
    lea dx, [invalid_num]
    int 21h
    jmp continue_program

continue_program:
    ; Newline
    mov ah, 02h
    mov dl, newline[0]
    int 21h
    mov dl, newline[1]
    int 21h

    ; Prompt for a character
    mov ah, 09h
    lea dx, [prompt_char]
    int 21h

    ; Get the character input
    mov ah, 01h
    int 21h

    ; Check if the character is valid
    cmp al, 'A'
    jl invalid_character
    cmp al, 'z'
    jg invalid_character
    cmp al, 'Z'
    jg check_lowercase

check_uppercase:
    ; If uppercase, check if it's a vowel
    cmp al, 'A'
    je is_vowel
    cmp al, 'E'
    je is_vowel
    cmp al, 'I'
    je is_vowel
    cmp al, 'O'
    je is_vowel
    cmp al, 'U'
    je is_vowel
    jmp is_consonant

check_lowercase:
    ; If lowercase, check if it's a vowel
    cmp al, 'a'
    je is_vowel
    cmp al, 'e'
    je is_vowel
    cmp al, 'i'
    je is_vowel
    cmp al, 'o'
    je is_vowel
    cmp al, 'u'
    je is_vowel
    jmp is_consonant

is_vowel:
    ; Print vowel message
    mov ah, 09h
    lea dx, [vowel_msg]
    int 21h
    jmp end_program

is_consonant:
    ; Print consonant message
    mov ah, 09h
    lea dx, [consonant_msg]
    int 21h
    jmp end_program

invalid_character:
    ; Print invalid character message
    mov ah, 09h
    lea dx, [invalid_char]
    int 21h
    jmp end_program

end_program:
    ; Terminate program
    mov ax, 4C00h
    int 21h

end start
