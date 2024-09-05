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
    L equ $-S1
    S2 db 5, 6, 7, 8
    D times L db 0 ;6, -4, 10, -4
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;????????????
         mov ecx, L
         mov esi, 0 
         mov edi, 0
         
         repeta:
            mov al, byte[S1+esi] 
            jp diferenta
            jmp suma
            suma:
                add al, byte[S2+esi]
                mov byte[D+edi], al
                inc esi
                inc edi
            jmp sfarsit_repeta
            diferenta:
                sub al, byte[S2+esi]
                mov byte[D+edi], al
                inc esi
                inc edi
           sfarsit_repeta:
         loop repeta
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
