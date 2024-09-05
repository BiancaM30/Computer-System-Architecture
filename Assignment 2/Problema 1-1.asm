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
    a db 5 ; 05h
    b dw 3 ; 0003h
    c dd 25 ; 00000019h
    d dq 10 ; 000000000000000Ah
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;Adunari si scaderi in interpretarea fara semn - problema 1
        ;c-(a+d)+(b+d)
        
    ;pas 1: a+d ; 
        mov eax, 0
        mov al, [a] ; eax=5
        mov edx, 0 ; edx:eax=a=5
        
        mov ebx, dword[d+0]
        mov ecx, dword[d+4] ;ecx:ebx=d=10
        
        ; edx:eax+
        ; ecx:ebx       
        clc ; CF=0
        add eax, ebx
        adc edx, ecx ; edx:eax = a+d = 5+10 = 15  

    ;pas 2: c-(a+d)    
        mov ebx, [c]
        mov ecx, 0 ;ecx:ebx=c=25
        
        ; ecx:ebx-
        ; edx:eax
        clc ; CF=0
        sub ebx, eax
        sbb ecx, edx ; ecx:ebx = c-(a+d) = 25-15 = 10
        
    ;pas 3: b+d
        mov eax, 0
        mov ax, [b]
        mov edx, 0 ; edx:eax=b=3
        
        clc
        add eax, dword[d+0]
        adc edx, dword[d+4] ;edx:eax = b+d = 3+10 = 13
        
    ;pas 4: c-(a+d)+(b+d)
        
        ; ecx:ebx+
        ; edx:eax
        clc
        add ebx, eax
        adc ecx, edx  ;ecx:ebx = c-(a+d)+(b+d) = 10+13 = 23
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
