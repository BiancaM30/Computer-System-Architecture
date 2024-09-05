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
     a db -10
     b db -2
     c db 3
; our code starts here
segment code use32 class=code
    start:
        ; ...
         ;((a-b)*4)/c
         mov eax, 0
         mov ebx, 0
         mov ecx, 0
         mov edx, 0
         
         ;pas 1: (a-b)
         mov al, [a]
         mov bl, [b]
         sub al, bl ; al=a-b=-8
         
         ;pas 2: (a-b)*4
         mov bl, 4
         imul bl  ;ax=(a-b)*4=-32
         
         ;pas 3: ((a-b)*4)/c
         idiv byte[c] ; ax=((a-b)*4)/c=-32/3=-10 rest -2; al=-10, ah=-2
         
         
         ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
