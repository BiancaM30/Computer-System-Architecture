#include <stdio.h>
#include <string.h>
// functiile declarate in fisierul 23_a.asm 
char sute(int n,char sir[]);//Declararea procedurii definite in limbaj de asamblare
char rez[]="";//Definirea global a sirului care va fii accesat in 23_a.asm

int main()
{
    // declaram variabilele
    char s[100];
    int n;
    // citim de la tastatura sirul
    printf("s=");
    gets(s);
    n=strlen(s);//numarul de elemente
    // apelam functiile scrise in limbaj de asamblare si afisam sirurile cerute
    n=sute(n,s);
    printf("Sirul format din cifrele sutelor: %s",rez);
    printf("\n");
    return 0;
}