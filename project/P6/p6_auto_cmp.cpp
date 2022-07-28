#include<cstdio>
#include<fstream>
#include<string>
#include<iostream>
using namespace std;

void fileCmp(){
	int cnt=0, flag = 1;
	string tmp_cpu,tmp_mars;

	ifstream cpufile("msg_out_cpu.txt");
	ifstream marfile("msg_out_mars.txt");
	ofstream cmpfile("msg_cmp.txt");

	while(getline(cpufile,tmp_cpu) && getline(marfile,tmp_mars)){
		cnt++;
		if(tmp_cpu != tmp_mars){
			flag = 0;
			cmpfile << "mismatch - line" << cnt << "\t: ";
			cmpfile << "[cpu] " << tmp_cpu << "\t[mars] " << tmp_mars << endl;
		}
	}
	if(flag) cmpfile << "no error";
}

int main(){
	fileCmp();
    return 0;
}