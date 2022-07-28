#include<stdio.h>

int N,M;
int map[8][8];
int x1,y1,x2,y2;
int cnt = 0;

int isAble(int x, int y){ return 0<=x && x<N && 0<=y && y<M && map[x][y]==0; }

void dfs(int x,int y){
    if(x == x2 && y == y2){
        cnt++; 
        return;
    } 
    if(isAble(x+1, y)) {
        map[x+1][y] = 1;
        dfs(x+1, y);
        map[x+1][y] = 0;
    }
    if(isAble(x-1, y)){
        map[x-1][y] = 1;
        dfs(x-1, y);
        map[x-1][y] = 0;
    }
    if(isAble(x, y+1)){
        map[x][y+1] = 1;
        dfs(x, y+1);
        map[x][y+1] = 0;
    }
    if(isAble(x, y-1)){
        map[x][y-1] = 1;
        dfs(x, y-1);
        map[x][y-1] = 0;
    }
    return;
}

int main(){
    scanf("%d%d",&N,&M);
    for(int i=0;i<N;++i) for(int j=0;j<M;++j)
        scanf("%d",&map[i][j]);
    scanf("%d%d%d%d",&x1,&y1,&x2,&y2);  
    x1 = x1 - 1; x2 = x2 - 1;
    y1 = y1 - 1; y2 = y2 - 1;
    
    map[x1][y1] = 1;
    dfs(x1,y1);
    printf("%d",cnt);
    return 0 ;
}