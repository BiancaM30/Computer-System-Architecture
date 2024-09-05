bits 32
global _elementemici;functie cunoscuta la nivel global
global _elementemari;functie cunoscuta la nivel global
extern _printf;fac cunoscuta functia din c in programul asm
extern _rez1;fac cunoscuta variabila din c in programul asm
extern _rez2;fac cunoscuta variabila din c in programul asm
segment data public data use32

segment code public code use32

;fac o functie care pune in _rez1 literele mici din sir
_elementemici:
    push ebp
    mov ebp,esp
    
    mov esi,[ebp+12];la [ebp+12] se afla adresa sirului de caractere citit de la tastatura
    mov edi,_rez1
    mov ecx,0
    mov cl,byte[ebp+8];la [ebp+8] se afla numarul de elemente ale sirului de caractere
    
    repeta:
        lodsb;se extrage un caracter din sir 
        cmp al,61h;compar caracterul cu a
        jge verifica;daca este mai mare sau egal decat a, se verifica in "verifica" daca caracterul este mai mic sau egal decat z
        jl final;daca e mai mic decat a se sare la eticheta final
        
        verifica:
            cmp al,7Ah;se compara caracterul cu z
            jle adauga;daca este mai mic sau egal, inseamna ca este vorba despre o litera mica si se sare la eticheta adauga
            jg final;daca nu, se sare la eticheta final 
        adauga:
            stosb;se adauga in _rez1 caracterul mic 
        final:
    loop repeta
    
    ;refacem cadrul de stiva pentru programul apelant
    mov esp, ebp
    pop ebp
    ret

;fac o functie care pune in _rez2 literele mari din sir
_elementemari:
    push ebp
    mov ebp,esp
    mov esi,[ebp+12];la [ebp+12] se afla adresa sirului de caractere citit de la tastatura
    mov edi,_rez2
    mov ecx,0
    mov cl,byte[ebp+8];la [ebp+8] se afla numarul de elemente ale sirului de caractere
    repeta1:
        lodsb;se extrage un caracter din sir 
        cmp al,41h;compar caracterul cu A
        jge verifica1;daca este mai mare sau egal decat A, se verifica in "verifica1" daca caracterul este mai mic sau egal decat Z
        jl final1;daca e mai mic decat a se sare la eticheta final1
        verifica1:
            cmp al,5Ah;se compara caracterul cu Z
            jle adauga1;daca este mai mic sau egal, inseamna ca este vorba despre o litera mare si se sare la eticheta adauga1
            jg final1;daca nu, se sare la eticheta final 
        adauga1:
            stosb;se adauga in _rez2 caracterul mare 
        final1:
    loop repeta1 
    
    ;refacem cadrul de stiva pentru programul apelant
    mov esp, ebp
    pop ebp
    ret