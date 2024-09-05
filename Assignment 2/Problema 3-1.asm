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
    a db 6 ;06h
    b dd 25 ;00000019h
    c dq 100 ;0000000000000064h
    aux dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;c+(a*a-b+7)/(2+a) in interpretarea fara semn Problema 1
        
    ;pas 1: a*a
        mov al, [a]
        mul byte[a] ;ax=a*a=36
        
    ;pas 2: a*a-b
        mov bx, ax
        mov eax, 0
        mov ax, bx  ;eax=a*a=36
        
        sub eax, dword[b] ;eax=a*a-b=36-25=11
        
    ;pas 3: a*a-b+7
        mov ebx, 7
        add eax, ebx ;eax=a*a-b+7=11+7=18
        
        mov dword[aux], eax ;punem rezultatul intr-o variabila auxiliara: aux=18
        
    ;pas 4: 2+a
        mov bl, 2
        add bl, byte[a] ;bl=2+a=2+6=8
        
    ;pas 5: (a*a-b+7)/(2+a)
        ;mutam valoarea din aux in combinatia de registrii dx:ax pentru a putea efectua impartirea
        mov ax, word[aux+0]
        mov dx, word[aux+2] ;dx:ax=18
        
        mov bh, 0 ;bx=8
        div bx ;dx:ax=18/8=2 rest 2   ,ax catul si in dx restul
        
    ;pas 6: c+(a*a-b+7)/(2+a)
        ; ax -> quad , punem rezultatul in combinatia de registrii edx:eax
        mov bx, ax
        mov eax, 0
        mov ax, bx
        mov edx, 0 ; edx:eax=2
        
        mov ebx, [c+0]
        mov ecx, [c+4] ;ecx:ebx=c=100
        
        ; edx:eax+
        ; ecx:ebx
        
        clc
        add eax, ebx
        adc edx, ecx ;edx:eax=100+2=102
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
