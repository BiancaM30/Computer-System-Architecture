bits 32 ; assembling for the 32 bits architecture


; our code starts here
segment code use32 class=code public

global concatenare

concatenare:
    ; stiva
    ; sir1 - [esp+4]
    ; len1 - [esp+8]
    ; sir2 - [esp+12]
    ; len2 - [esp+16]
    ; sir3 - [esp+20]
    ; len3 - [esp+24]
    ; sir4 - [esp+28]
    
    ;adaugam sirul 1 la sirul rezultat
    mov esi, [esp+4] ;punem in esi adresa sirului 1
    mov edi, [esp+28] ;punem in edi adresa sirului rezultat
    mov ecx, [esp+8] ;punem in ecx lungimea sirului 1
    cld
    
    repeta1:
        movsb
    loop repeta1
    
    mov esi, [esp+12] ;punem in esi adresa sirului 2
    mov ecx, [esp+16] ;punem in ecx lungimea sirului 2
    cld
    
    repeta2:
        movsb
    loop repeta2
    
    mov esi, [esp+20] ;punem in esi adresa sirului 3
    mov ecx, [esp+24] ;punem in ecx lungimea sirului 3
    cld
    
    repeta3:
        movsb
    loop repeta3
    
    ret 4*7
    

  