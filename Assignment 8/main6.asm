bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll
extern concatenare 

; our data is declared here (the variables needed by our program)
segment data use32 class=data public
    ; ...
    sir1 times 101 db 0
    sir2 times 101 db 0
    sir3 times 101 db 0
    sir_rez times 301 db 0
    len1 dd 0
    len2 dd 0
    len3 dd 0
    
    mesaj1 db "Introduceti primul sir: ", 0
    mesaj2 db "Introduceti al doilea sir: ", 0
    mesaj3 db "Introduceti al treilea sir: ", 0
    
    format_citire db "%s", 0
    format_afisare db "Rezultatul concatenarii celor 3 siruri este: %s", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Se citesc trei siruri de caractere. Sa se determine si sa se afiseze rezultatul concatenarii lor.
        
        ;afisam mesajul "Introduceti primul sir: " , printf(mesaj1)
        push dword mesaj1
        call [printf]
        add esp, 4*1
        
        ;citim primul sir , scanf(format_citire, sir1)
        push dword sir1
        push dword format_citire
        call [scanf]
        add esp, 4*2
        
        ;calculam numarul de caractere a sirului 
        mov esi, sir1
        mov ecx, 0
        
        repeta1:
            lodsb
            cmp al, 0
            je final1
            add dword[len1], 1
            jmp repeta1
            final1:

        ;afisam mesajul "Introduceti al doilea sir: " , printf(mesaj2)
        push dword mesaj2
        call [printf]
        add esp, 4*1
        
        ;citim al doilea sir , scanf(format_citire, sir2)
        push dword sir2
        push dword format_citire
        call [scanf]
        add esp, 4*2
        
        ;calculam numarul de caractere a sirului 
        mov esi, sir2
        mov ecx, 0
        
        repeta2:
            lodsb
            cmp al, 0
            je final2
            add dword[len2], 1
            jmp repeta2
            final2:
        
        ;afisam mesajul "Introduceti al treilea sir: " , printf(mesaj3)
        push dword mesaj3
        call [printf]
        add esp, 4*1
        
        ;citim al treilea sir , scanf(format_citire, sir3)
        push dword sir3
        push dword format_citire
        call [scanf]
        add esp, 4*2
        
        ;calculam numarul de caractere a sirului 
        mov esi, sir3
        mov ecx, 0
        
        repeta3:
            lodsb
            cmp al, 0
            je final3
            add dword[len3], 1
            jmp repeta3
            final3:
            
        ;concatenare(sir1, len1, sir2, len2, sir3, len3, sir_rez)
        push dword sir_rez
        push dword [len3]
        push dword sir3
        push dword [len2]
        push dword sir2
        push dword [len1]
        push dword sir1
        call concatenare
        
        ;afisam sirul rezultat , printf(format_afisare, sir_rez)
        push dword sir_rez
        push dword format_afisare
        call [printf]
        add esp, 4*4
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
