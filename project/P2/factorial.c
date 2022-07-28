#include<stdio.h>

int ans[100007];
int N;

int main(){
    int len = 0;
    scanf("%d",&N);
    ans[0] = 1;

    for(int num=2;num<=N;++num){ 
        for(int i=0;i<=len;++i)
            ans[i] *= num;
        for(int i=0;i<=len;++i){
            int lo = ans[i]/10;
            ans[i] = ans[i]%10;
            if(lo){
                ans[i+1] += lo;
                if(i==len) len++;
            }
           /*  if(i==len-1 && ans[i]/10) len++; 
            ans[i+1] += ans[i]/10;
            ans[i] %= 10; */
        }
    } 

    for(int i=len;i>=0;--i)
        printf("%d",ans[i]);

    return 0;
}