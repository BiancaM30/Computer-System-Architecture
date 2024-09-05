bits 32 ; assembling for the 32 bits architecture
global _sute;functie cunoscuta la nivel global
extern _rez;fac cunoscuta variabila din c in programul asm
segment data public data use32

segment code public code use32

    _sute:
        ; creare cadru de stiva pentru programul apelat
        push ebp 
        mov ebp,esp
        
        mov edi,_rez
        mov ecx,0
        mov cl,byte[ebp+8];la [ebp+8] se afla numarul de elemente ale sirului de caractere
        mov esi,[ebp+12];la [ebp+12] se afla adresa sirului de caractere citit de la tastatura
        
        repeta1:
            mov edx,0 ;numar cifrele pana la " "
            mov eax,0; incarca fiecare cifra
            repeta2:
                lodsb;incarcam numerele in eax
                dec ecx
                cmp al,' '
                je final1
                jne numara
                numara:
                    shl ebx,8;rotesc bitii din EBX si adaug in bl pe al
                    mov bl,al
                    ;.. .. .. al1
                    ;.. .. al1 al2
                    ;.. al1 al2 al3
                    ;al1 al2 al3 al4
                    inc edx ;numar cifrele
                    jmp repeta2; continui pana ajung la " "
            final1:
                cmp edx,3
                jl incarca_0 ; in cazul in care are 2 sau 1 cifra ,cifra sutelor este 0
                jge incarca_sute;in cazul contrar pun in sir cifra sutelor
                incarca_0:
                    mov al,'0'
                    stosb
                    mov al,' '
                    stosb
                jmp final2
                incarca_sute:
                ;'1' '2' '3' '4'
                    mov eax,ebx ;mut in eax continutul lui ebx (Numarul)
                    rol eax,16 ;rotesc pentru a obtine cifra sutelor
                    stosb
                    mov al,' '
                    stosb
              final2:
              inc ecx
        loop repeta1
        ;Refacem cadrul de stivă al programului apelant
        mov esp, ebp
        pop ebp
        ret
