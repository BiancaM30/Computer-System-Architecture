bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
        s dd 12345678h, 1A2C3C4Dh, 98FCDD76h, 12783A2Bh
        lung equ ($-s)/4
        d dd -1
        
; our code starts here
segment code use32 class=code
    start:
        ; ...
         mov esi, 0
         mov edi, 0
         mov ecx, lung
         jecxz Final
         
         repeta:
            mov ebx, dword[s+esi] ;punem in ebx dublucuvantul curent
            add esi, 4 
            mov bl, bh ;separam octetul superior al cuvantului inferior
            
            mov al, bl 
            cbw ;convertim in word pentru a putea efectua impartirea
            mov dl, 2
            idiv dl ;impartim la 2 pentru a afla paritatea al-cat, ah-rest
            ;daca ah este diferit de 0 inseamna ca numarul este impar
            ;altfel numarul este par
            
            cmp ah, 0 
            jnz Terminare ;daca numarul este impar
            mov byte[d+edi], bl ;incarcam octetul par in rezultat
            inc edi
           Terminare:    
        loop repeta
         
        Final: 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
