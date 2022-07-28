#include<iostream>
#include<fstream>
#include<string>
#include<vector>
#include<algorithm>
#include<cstdlib>
#include<ctime>
using namespace std;


int main(){
	//generateMips();
    system("java -jar Mars_perfect.jar db nc mc CompactDataAtZero 8000 dump .text HexText P6_L1_CPU/code.txt self_test.asm > msg_out_mars.txt");
	
    return 0;
}

//java -jar Hazard-Calculator.jar code.txt --im-base 0x3000 --dm-base 0x0000 --im-size 16384 --dm-size 12288