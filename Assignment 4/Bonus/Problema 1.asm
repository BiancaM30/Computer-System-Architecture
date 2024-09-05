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
    S db 1, 2, 3, 4
    L equ $-S
    D times L-1 db 0 ;2, 6, 12
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
         mov ecx, L-1
         mov esi, 0
         mov edi, 0
         
         repeta:
            mov al, byte[S+esi]
            inc esi
            mov bl, byte[S+esi]
            imul bl
            mov byte[D+edi], al
            inc edi
         loop repeta
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
