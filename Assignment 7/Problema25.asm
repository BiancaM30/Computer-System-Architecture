bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf  ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
     text db "Un fisier3   reprezinta$   o #secventa de** octet%i!", 0
     L equ $-text 
     rez times L db 0 ;sirul va contine textul modificat
     
     nume_fisier db "Fisier.txt", 0
     mod_acces db "w", 0
     descriptor dd 0
     format db "%s"
     
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;25.Se dau un nume de fisier si un text (definite in segmentul de date). 
        ;Textul contine litere mici, litere mari, cifre si caractere speciale. 
        ;Sa se inlocuiasca toate spatiile din textul dat cu caracterul 'S'. 
        ;Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut prin inlocuire in fisier.
        
        mov esi, text
        mov edi, rez
        mov ecx, L
        jecxz final
        
        cld
        repeta:
            lodsb ;al = text[esi]
            cmp al, ' '
            jne sfarsit
            mov al, 'S' 
            sfarsit:
                stosb ;rez[edi] = al 
        loop repeta
        
        ;deschidem/cream un fisier pentru scriere 
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je final
        mov [descriptor], eax
        
        ;scriem in fisier textul modificat
        push dword rez
        push dword format
        push dword [descriptor]
        call [fprintf]
        add esp, 4*3
        
        ;inchidem fisierul
        push dword [descriptor]
        call [fclose]
        add esp, 4*1
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
