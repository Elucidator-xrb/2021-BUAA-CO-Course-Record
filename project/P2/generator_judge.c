#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define N 20

char s[30];

int main(){
    srand((unsigned)time(NULL));
    freopen("data.in","w",stdout);

    for(int i=0;i<N;++i){
        s[i] = rand()%26 + 97;
        printf("%c",s[i]);
    }

    freopen("data_exp.out","w",stdout);
    
    int i,j;
    for(i=0,j=N-1;i<j && s[i]==s[j];++i,--j);
    if(j<i) putchar('1');
    else putchar('0');
    

    return 0;
}