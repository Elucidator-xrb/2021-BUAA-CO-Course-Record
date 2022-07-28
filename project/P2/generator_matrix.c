#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define SIZE 8

int ma[SIZE][SIZE];
int mb[SIZE][SIZE];
int mc[SIZE][SIZE];

int main(){
    srand((unsigned)time(NULL));
    freopen("data.in","w",stdout);

    for(int i=0;i<SIZE;++i){
        for(int j=0;j<SIZE;++j){
            ma[i][j] = rand() % 10;
            mb[i][j] = rand() % 10;
        }
    }

    for(int i=0;i<SIZE;++i)
        for(int j=0;j<SIZE;++j)
            for(int k=0;k<SIZE;++k)
                mc[i][j] += ma[i][k]*mb[k][j];

    printf("%d\n",SIZE);
    for(int i=0;i<SIZE;++i)for(int j=0;j<SIZE;++j)
        printf("%d\n",ma[i][j]);
    for(int i=0;i<SIZE;++i)for(int j=0;j<SIZE;++j)
        printf("%d\n",mb[i][j]);
    

    freopen("data_expect.out","w",stdout);
    for(int i=0;i<SIZE;++i){
        for(int j=0;j<SIZE;++j)
            printf("%d ",mc[i][j]);
        puts("");
    }   

    return 0;
}