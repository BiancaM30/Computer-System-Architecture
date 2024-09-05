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
    a dw 0110111101101010b
    b dw 1000110100110111b
    c dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Problema 7
        ; Se dau doua cuvinte A si B. Sa se obtina dublucuvantul C:
        ; bitii 0-4 ai lui C au valoarea 1
        ; bitii 5-11 ai lui C coincid cu bitii 0-6 ai lui A
        ; bitii 16-31 ai lui C au valoarea 0000 0000 0110 0101b
        ; bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B
        
        ;punem 0 in registrii
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        
    ;pas 1: bitii 0-4 ai lui C au valoarea 1
        mov ebx, 0 ; calculam rezultatul in ebx
        or ebx, 00000000000000000000000000011111b ;ebx = 0000 001Fh = 0000 0000 0000 0000 0000 0001 1111b
        
    ;pas 2: bitii 5-11 ai lui C coincid cu bitii 0-6 ai lui A
        mov ax, [a] ;izolam bitii 0-6 ai lui A
        and ax, 0000000001111111b ; ax = 0000 0000 0110 1010
        
        ;bitii 0-6 ai lui A trebuie shiftati la stanga cu 5 pozitii
        mov cl, 5
        shl ax, cl ; ax = 0000 1101 0100 0000
        
        or ebx, eax ; punem bitii in rezultat  ebx = 0000 0D5Fh = 0000 0000 0000 0000 0000 1101 0101 1111b
        
    ;pas 3: bitii 16-31 ai lui C au valoarea 0000 0000 0110 0101b 
        mov eax, 00000000011001010000000000000000b
        or ebx, eax ; ebx = 00650D5F = 0000 0000 0110 0101 0000 1101 0101 1111b
        
    ;pas 4: bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B
        mov eax, 0
        mov ax, [b] ;izolam bitii 8-11 ai lui B
        and ax, 0000111100000000b ; ax = 0000 1101 0000 0000b 
        
        ;bitii 8-11 ai lui B trebuie shiftati la stanga cu 4 pozitii
        mov cl, 4
        shl ax, cl ; ax = 1101 0000 0000 0000b 
        
        or ebx, eax ; ebx = 0065DD5F = 0000 0000 0110 0101 1101 1101 0101 1111b
        
    ;pas 5: punem valoarea din registru in variabila rezultat
        mov dword[c], ebx ; c = 0065DD5Fh = 0000 0000 0110 0101 1101 1101 0101 1111b
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
