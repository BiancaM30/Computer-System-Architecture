bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
     a dd 0 ;il declaram dword, dar va stoca un word
     b dd 0 ;il declaram dword, dar va stoca un word
     rez dd 0
     format1 db "a=", 0
     format2 db "b=", 0
     readformat db "%d", 0
     printformat db "c=%x", 0 ;vom afisa rezultatul in baza 16
     
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Sa se citeasca de la tastatura doua numere a si b de tip word. Sa se afiseze in baza 16 numarul c de 
        ;tip dword pentru care partea low este suma celor doua numere, iar partea high este diferenta celor doua numere. 
        ;Exemplu:
            ;a = 574, b = 136
            ;c = 01B602C6h
        
        ;apel printf("a=")
        push dword format1 
        call [printf]
        add esp, 4*1 ;eliberare resurse folosite la apel printf
        
        ;apel scanf ("%d", a)
        push dword a
        push dword readformat
        call [scanf]    
        add esp, 4*2 ;eliberare resurse folosite la apel scanf
        
        ;apel printf("b=")
        push dword format2 
        call [printf]
        add esp, 4*1 ;eliberare resurse folosite la apel printf
        
        ;apel scanf ("%d", b)
        push dword b
        push dword readformat
        call [scanf]    
        add esp, 4*2 ;eliberare resurse folosite la apel scanf
        
        ;efectuam adunarea a+b in registrul eax
        mov eax, [a]
        add eax, [b]  
        
        mov [rez+0], eax ;mutam suma in partea low a dwordului rez
        
        ;efectuam scaderea a-b in registrul ebx
        mov ebx, [a]
        sub ebx, [b]
        
        mov [rez+2], ebx ;mutam diferenta in partea high a dwordului rez
        
        ;apel printf(printformat, rez)
        push dword [rez]
        push dword printformat
        call [printf]
        add esp, 4*2
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
