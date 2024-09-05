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
    a db 5
    b db 3
    c db 12
    d db 1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;initializam registrii cu 0
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        
        ;(a+b)-(a+d)+(c-a)
        
        ;pas 1: (a+b)
        mov al, [a] ; al detine valoarea lui a
        add al, [b] ; al=al+b=(a+b)=5+3=8
        
        ;pas 2: (a+d)
        mov bl, [a] ; bl detine valoarea lui a
        add bl, [d] ; bl=bl+d=(a+d)=5+1=6

        ;pas 3: (a+b)-(a+d)
        sub al,bl   ;al=al-bl=8-6=2
        
        ;pas 4: (c-a)
        mov bl,0
        mov bl, [c] ; bl detine valoarea lui c
        sub bl, [a] ; bl=bl-a=(c-a)=12-5=7
        
        ;pas 5: (a+b)-(a+d)+(c-a)
        add al,bl ; al=al+bl=(a+b)-(a+d)+(c-a)=2+7=9
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
