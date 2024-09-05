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
     S db 1, 3, -2, -5, 3, -8, 5, 0
     L equ $ - S ;L=8
     D1 times L db 0 ;1, 3, 3, 5, 0
     D2 times L db 0 ;-2, -5, -8

; our code starts here
segment code use32 class=code
        start:
        ; ...
        mov ecx, L ;ecx primeste lungimea sirului, de care avem nevoie pentru instructiunea loop
        
        ;initializam registrii index
        mov esi, 0 ; esi pentru sirul S
        mov edi, 0 ; edi pentru sirul de numere pozitive D1
        mov ebp, 0 ; ebp pentru sirul de numere negative D2
        
        Repeta:
            mov al, byte[S+esi] ;mutam elementul curent in registrul al
            inc esi ;crestem indexul lui S
            cmp al, 0 ;comparam valoarea din al cu 0 si mergem la eticheta corespunzatoare
            jge Pozitive
            jl Negative
            
            Pozitive: ;ramura pozitiva
                mov byte[D1+edi], al ;mutam valoarea din al in sirul numerelor pozitive D1
                inc edi ;crestem indexul
            jmp sfarsit_repeta ;sare la eticheta sfarsit_repeta
                
            Negative: ;ramura negativa
                mov byte[D2+ebp], al ;mutam valoarea din al in sirul numerelor negative D2
                inc ebp ;crestem indexul   
            sfarsit_repeta:
        loop Repeta        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
