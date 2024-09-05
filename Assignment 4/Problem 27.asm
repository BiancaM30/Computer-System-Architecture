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
    S1 db 1, 3, 6, 2, 3, 2
    L equ $ - S1 ;L=6
    S2 db 6, 3, 8, 1, 2, 5
    D times L db 0 ;-5, 0, -2, 1, 1, -3

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, L ;ecx primeste lungimea sirului, de care avem nevoie pentru instructiunea loop 
        ;initializam registrii index
        
        mov esi, 0 ; esi pentru S1,S2
        mov edi, 0 ; edi pentru D
        
        Repeta:
            mov al, byte[S1+esi] ; mutam in al valoarea de pe pozitia curenta din sirul S1
            sub al, byte[S2+esi] ; scadem din al valoarea de pe pozitia curenta din sirul S2 
            mov byte[D+edi], al ; mutam rezultatul in sirul D
            inc esi ; crestem indexul pentru S1, S2 
            inc edi ; crestem indexul pentru D
        loop Repeta  
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
