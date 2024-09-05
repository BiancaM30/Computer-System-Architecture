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
     a db -3 ;FDh
     b dw 14 ;000Eh
     c dd 26 ;0000001Ah
     d dq -15 ;FFFFFFFFFFFFFFF1h
     
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;Adunari si scaderi in interpretarea cu semn - problema 1
        ;(c+b+a)-(d+d) 
        
    ;pas 1: c+b
        mov ax, [b]
        cwde ;eax=b
        
        add eax, dword[c] ;eax=c+b=26+14=40
        
    ;pas 2: c+b+a    
        mov ebx, eax ;ebx=c+b=40
        
        mov al, [a] 
        cbw
        cwde ;eax=a=-3
        add eax, ebx ;eax=c+b+a=40-3=37
        
    ;pas 3: d+d
        mov ebx, dword[d+0]
        mov ecx, dword[d+4] ;ecx:ebx=d=-15
        
        clc
        add ebx, dword[d+0]
        adc ecx, dword[d+4] ;ecx:ebx=d+d=(-15)+(-15)=-30
        
    ;pas 4: (c+b+a)-(d+d)
        cdq ; edx:eax=c+b+a=37
        
        ; edx:eax-
        ; ecx:ebx
        
        clc
        sub eax, ebx
        sbb edx, ecx  ;edx:eax=(c+b+a)-(d+d)=37-(-30)=67
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
