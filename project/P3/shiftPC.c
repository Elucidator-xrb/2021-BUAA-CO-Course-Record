#include<stdio.h>
#include<string.h>

int main(){
    FILE *fp;
    char ch;
    fp = fopen("test_stg.txt","r");

    freopen("test_stg_final.txt","w",stdout);

    printf("v2.0 raw\n");
    for(int i=0;i<0x00003000/4;++i)
        printf("00000000\n");
    while( (ch=fgetc(fp))!=EOF )
        putchar(ch);

    return 0;
}