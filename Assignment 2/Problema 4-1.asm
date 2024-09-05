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
     a db -7 ; F9h
     b dd -15 ; FFFFFFF1h
     c dq 110 ; 000000000000006Eh
     aux dd 0
     
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;c+(a*a-b+7)/(2+a), in interpretarea cu semn  Problema 1
        
    ;pas 1: a*a
        mov al, [a] 
        imul byte[a] ;ax=a*a=(-7)*(-7)=49
        
    ;pas 2: a*a-b
        cwde ; eax=a*a=49
        mov ebx, [b] ;ebx=b=-15 
        sub eax, ebx ;eax=a*a-b=49-(-15)=64
        
    ;pas 3: a*a-b+7       
        mov ebx, 7
        add eax, ebx ;eax= a*a-b+7=64+7=71
        mov dword[aux], eax ;aux=a*a-b+7=71
        
    ;pas 4: 2+a  
        mov al, 2    
        mov bl, [a]
        add al, bl ;al=2+a=2+(-7)=-5
        
    ;pas 5: (a*a-b+7)/(2+a)    
        cbw ;ax=2+a=-5
        mov bx, ax ; bx=2+a=-5
        
        ;aducem rezultatul din aux in combinatia de registrii dx:ax
        mov ax, word[aux+0]
        mov dx, word[aux+2] ;dx:ax=(a*a-b+7)=71
        
        idiv bx ;dx:ax=(a*a-b+7)/(2+a)=71/-5=-14 rest 1   ,ax catul si in dx restul
        
    ;pas 6: c+(a*a-b+7)/(2+a)    
        cwde 
        cdq ;edx:eax=(a*a-b+7)/(2+a)=-14
        
        ;il punem pe c in combinatia de registrii ecx:ebx
        mov ebx, dword[c+0]
        mov ecx, dword[c+4] ;ecx:ebx=c=110
        
        ;adunam edx:eax+
        ;       ecx:ebx
        
        clc
        add eax, ebx
        adc edx, ecx ;edx:eax=c+(a*a-b+7)/(2+a)=110+(-14)=96
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
