bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf  ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
     a dd 0
     b dd 0 ;il declaram dword, dar va stoca un word
     cat dd 0
     format1 db "a=", 0
     format2 db "b=", 0
     readformat db "%d", 0
     printformat db "%d/%d = %d", 0
     
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Se dau doua numere naturale a si b (a: dword, b: word, definite in segmentul de date). 
        ;Sa se calculeze a/b si sa se afiseze catul impartirii in urmatorul format: "<a>/<b> = <cat>"
  
        
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
        
        ;efectuam impartirea
        ;a -> dx:ax
        mov ax, [a+0]
        mov dx, [a+2]
        idiv word[b] ;dx:ax=a/b    ax - cat, dx - rest
        cwde ;avem nevoie de cat ca dword pentru a-l pune pe stiva
        mov dword[cat], eax
        
        
        ;apel printf (printformat, a, b, cat)
        push dword [cat]
        push dword [b]
        push dword [a]
        push dword printformat
        call [printf]
        add esp, 4*4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
