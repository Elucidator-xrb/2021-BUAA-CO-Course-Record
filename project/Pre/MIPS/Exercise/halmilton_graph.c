#include<stdio.h>
#include<stdlib.h>
#define SMAX 300 // 0b1111111 + 1
#define VMAX 8

int Ge[10][10];
int n,m; //n-vertex, m-edge
int dp[SMAX][VMAX];

void buildGraph();
void dpStatus();
void printdp();

int main(){
    buildGraph();
    dpStatus(); printdp();
    return 0;
}

void buildGraph(){
    int v1,v2;
    scanf("%d%d",&n,&m);
    for(int i=0;i<m;++i){
        scanf("%d%d",&v1,&v2);
        Ge[v1][v2]=Ge[v2][v1]=1;
    }
}

void dpStatus(){
    dp[1][1]=1; //从1号点开始
    for(int S=1;S < (1<<n);++S){
        for(int v=1;v<=n;++v){
            if( S & (1<<(v-1)) ){
                int Spre = S ^ (1<<(v-1));
                for(int u=1;u<=n;++u){
                    if( S & (1<<(u-1)))
                        dp[S][v] |= (dp[Spre][u] & Ge[u][v]);
                }
            }
        }
    }
    for(int i=1;i<=n;++i){
        if(dp[(1<<n)-1][i] & Ge[i][1]){
            printf("1\n");
            return;
        }
    }
    printf("0\n");
    return;
}

void printdp(){
    for(int S=1;S<(1<<n);++S){
        for(int v=1;v<=n;++v){ 
            char tmp[10];
            itoa(S,tmp,2);
            printf("dp[%s][%d]=%d\n",tmp,v,dp[S][v]);
        }
        puts("");
    }
}