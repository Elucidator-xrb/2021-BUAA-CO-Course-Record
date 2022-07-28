#include<stdio.h>

int Arr[100];

void mergeSort(int low, int high);
void merge(int low, int mid, int high);

int main(){
    getInfo();
    mergeSort(1,100);
    return 0;
}

void mergeSort(int low, int high){
    if(low < high){
        int mid = (high + low) / 2;
        mergeSort(low, mid);
        mergeSort(mid+1, high);
        merge(low, mid, high);
    }
}

void merge(int low, int mid, int high){
    int i = low, j = mid + 1;
    int p = low;
    int tmp[100]={0};
    while(i<=mid && j<=high){
        if(Arr[i]<=Arr[j])  tmp[p++] = Arr[i++];
        else                tmp[p++] = Arr[j++];
    }
    while(i<=mid) tmp[p++] = Arr[i++];
    while(j<=mid) tmp[p++] = Arr[j++];
    
    for(i = low; i<high; i++) Arr[i] = tmp[i];
}