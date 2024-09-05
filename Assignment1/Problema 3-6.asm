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
     b db 6
     c db 3
     d dw 9
; our code starts here
segment code use32 class=code
    start:
        ; ...
         mov eax, 0
         mov ebx, 0
         mov ecx, 0
         mov edx, 0
         
        ;[2*(a+b)-5*c]*(d-3) = 42
        
        ;pas 1: (a+b)
        mov al, [a] ;al primeste valoarea lui a
        add al, [b] ; al=al+b=(a+b)=5+6=11
        
        ;pas 2: 2*(a+b)
        mov bl, 2
        mul bl ; ax=al*bl=2*(a+b)=2*11=22
        
        ;pas 3: 5*c
        mov bx, ax ; mutam ax in bx, bx=22
        mov ax, 0
        mov al, 5
        mul byte[c] ; ax=ax*c=5*3=15
        
        ;pas 4: [2*(a+b)-5*c]
        sub bx, ax ; bx=bx-ax=[2*(a+b)-5*c]=22-15=7
        
        ;pas 5: (d-3)
        mov ax, [d] ; ax primeste valoarea lui d
        sub ax, 3 ; ax=ax-3=(d-3)=9-3=6
        
        ;pas 6: [2*(a+b)-5*c]*(d-3)
         mul bx ; dx:ax=ax*bx=6*7=42 
         


        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
