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
    a dw 3
    b dw 5
    c dw 14
    d dw 2

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;initializam registrii cu 0
        mov eax, 0 
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        
        ;c-(d+a)+(b+c)
        
        ;pas 1: (d+a)
        mov ax, [d] ; ax primeste valoarea lui d
        add ax, [a] ; ax=ax+a=(d+a)=2+3=5
        
        ;pas 2: c-(d+a)
        mov bx, [c] ; cx primeste valoarea lui c
        sub bx,ax ; bx=bx-ax=c-(d+a)=14-5=9
        
        ;pas 3: (b+c)
        mov ax,0
        mov ax, [b] ; ax primeste valoarea lui b
        add ax, [c] ; ax=ax+c=(b+c)=5+14=19

        ;pas 4: c-(d+a)+(b+c)
        add bx,ax ; bx=bx+ax=9+19=28  
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
