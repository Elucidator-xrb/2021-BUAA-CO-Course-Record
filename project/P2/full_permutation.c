#include<stdio.h>
#define MAXN 10
#define PRINT(A) for(int i=0;i<N;++i)printf("%d ",A[i]);puts("")

int N;
int IsUsed[MAXN],Arr[MAXN]; //IsUsed[i]==1 means i+1 is used

void fullPermutation(int index){
    if(index >= N){
        PRINT(Arr); 
        return;
    } 
    for(int i=0;i<N;++i){
        if(IsUsed[i] == 0){
            Arr[index] = i+1;
            IsUsed[i] = 1;
            fullPermutation(index+1);
            IsUsed[i] = 0;
        }
    }
}

int main(){
    scanf("%d",&N);
    fullPermutation(0);
    return 0;
}