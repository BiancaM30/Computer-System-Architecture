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
    S1 db 1, 2, 3, 4
    L1 equ $-S1
    S2 db 5, 6, 7
    L2 equ $-S2
    D times L1+L2 db 0;1, 2, 3, 4, 7, 6, 5
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, L1
        mov esi, 0
        mov edi, 0
        
        repeta1:
            mov al, byte[S1+esi]
            mov byte[D+edi], al
            inc esi
            inc edi
        loop repeta1    
        
        
        mov esi, L2-1
        mov ecx, L2
      
        repeta2:
             mov al, byte[S2+esi]
             mov byte[D+edi], al
             dec esi
             inc edi
        loop repeta2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
