#include <stdio.h>
#include <string.h>
// functiile declarate in fisierul 28_a.asm si cele doua siruri de caractere declarate la nivel global
char elementemici(int n,char s[]);
char elementemari(int n,char s[]);
char rez1[]="0";
char rez2[]="0";

int main()
{
    // declaram variabilele
    char s[100];
    int n,m;
    // citim de la tastatura sirul
    printf("s=");
    gets(s);
    n=strlen(s);
    
    // apelam functiile scrise in limbaj de asamblare si afisam sirurile cerute
    m=elementemici(n,s);
    printf("Sirul format din litere mici: %s",rez1);
    printf("\n");
    strcpy(rez2,"");
    strcpy(rez1,"");
    
    m=elementemari(n,s);
    printf("Sirul format din litere mari: %s",rez2);
    printf("\n");
    
    return 0;
}
