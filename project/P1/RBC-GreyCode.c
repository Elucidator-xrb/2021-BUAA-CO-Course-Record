#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define PRINT(x,y) for(int i=y-1;i>=0;--i){printf("%d",x[i]);} puts("")

void printGrey(int n);

int main(){
    printGrey(5);
    return 0;
}

void printGrey(int N){
    char *pt = (char *)calloc(1,sizeof(char));
    char *op = (char *)calloc(1<<N,sizeof(char));
    int cur = 0, mark;
    PRINT(pt,N);
    for(int bit=0;bit<N;++bit){
        mark = cur;
        pt[bit] ^= 1; PRINT(pt,N);
        op[cur++] = bit;
        for(int j=0;j<mark;++j){
            pt[ op[j] ] ^= 1; PRINT(pt,N);
            op[cur++] = op[j];
        }
    }
}