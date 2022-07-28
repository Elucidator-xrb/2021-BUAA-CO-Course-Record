#include<iostream>
#include<fstream>
#include<string>
#include<vector>
#include<algorithm>
#include<cstdlib>
#include<ctime>
using namespace std;
ofstream outfile("test_stg_mips.asm");

struct op{
	int type,r1,r2,r3;
	op(){}
	op(int a1,int a2,int a3,int a4){
		type=a1,r1=a2,r2=a3,r3=a4;
	}
};

int size_im, size_dm, size_op, small_reg, ra;
op a[10010]; //instruction
vector<int> branch[10010];
int is_small[40],small[40],val[40],cnt;

int r(int a,int b,int except1){//range: [a...b]-{except1} 由于1号寄存器使用时可能出现错误，所以生成指令不包含1号寄存器
	int t0=rand()*2+rand()%2;
	int res=t0%(b-a+1)+a;
	return ((res==1)&&except1==1)?0:res;
}

int t[10010];
void get_small(){//随机选取若干个寄存器用于lw和sw，他们的值小于dm大小且不变
	int i;
	for(i=1;i<=26;i++) t[i]=i;
	for(i=1;i<=26;i++) swap(t[i],t[rand()%30+1]); // t[i] range from 1...30, thus t[i]+1 range from 2...31
	for(i=1;i<=small_reg;i++) small[i]=t[i]+1,is_small[t[i]+1]=1;
}
int nosmall(){//随机一个不用于lw和sw的寄存器
	int u=r(0,27,1);
	while(is_small[u]==1){u=r(0,27,1);}
	return u;
}
void print(int x){
	if(a[x].type==0) outfile<<"nop"<<endl;
	else if(a[x].type==1) outfile<<"addu $"<<a[x].r1<<",$"<<a[x].r2<<",$"<<a[x].r3<<endl;
	else if(a[x].type==2) outfile<<"subu $"<<a[x].r1<<",$"<<a[x].r2<<",$"<<a[x].r3<<endl;
	else if(a[x].type==3) outfile<<"lui $"<<a[x].r1<<","<<a[x].r3<<endl;
	else if(a[x].type==4) outfile<<"ori $"<<a[x].r1<<",$"<<a[x].r2<<","<<a[x].r3<<endl;
	else if(a[x].type==5) outfile<<"lw $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==6) outfile<<"sw $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==7) outfile<<"beq $"<<a[x].r1<<",$"<<a[x].r2<<",branch"<<a[x].r3<<endl;
	else if(a[x].type==8) outfile<<"sll $"<<a[x].r1<<",$"<<a[x].r2<<","<<a[x].r3<<endl;
	else if(a[x].type==9) outfile<<"slt $"<<a[x].r1<<",$"<<a[x].r2<<",$"<<a[x].r3<<endl;
	//else if(a[x].type==10) outfile<<"addiu $"<<a[x].r1<<",$"<<a[x].r2<<","<<a[x].r3<<endl;
	else if(a[x].type==11) outfile<<"lb $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==12) outfile<<"sb $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==13) outfile<<"lh $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==14) outfile<<"sh $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;

	else if(a[x].type==15) outfile<<"bne $"<<a[x].r1<<",$"<<a[x].r2<<",branch"<<a[x].r3<<endl;
	else if(a[x].type==16) outfile<<"j "<<"branch"<<a[x].r3<<endl;
	else if(a[x].type==17) outfile<<"jal "<<"branch"<<a[x].r3<<endl;
	else if(a[x].type==18) outfile<<"jr $ra"<<endl;
    //else if(a[x].type==19) outfile<<"lhu $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	//else if(a[x].type==20) outfile<<"lbu $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
}

void generateMips(){
	// 0nop 1addu 2subu 3lui 4ori 5lw 6sw 7beq 8sll 9slt 10addiu 11lb 12sb 13lh 14sh 15bne
	// 16j 17jal 18jr 19lhu 20lbu

	int i,j;
	srand(time(0));
	size_im=300;//size_of_im : number of the instructions generated
	size_dm=1023;//size_of_dm
	size_op=18;//size of instruction set
	
    small_reg=15;//最前面small_reg个指令都是ori，先对寄存器进行赋值
	get_small();
	for(i=1;i<=small_reg;i++)
		a[i]=(op(4,small[i],0,val[small[i]]=r(0,size_dm-1,0)));
	for(i=small_reg+1;i<=size_im;i++){
		int op0=r(0,size_op-1,0),r1,r2,r3;
		if(op0==0) a[i]=(op(0,0,0,0));
		else if(op0==1||op0==2||op0==9){//addu subu
			a[i]=op(op0,nosmall(),r(0,27,1),r(0,27,1));
		}
		else if(op0==3||op0==4||op0==10){//lui ori
			a[i]=(op(op0,nosmall(),r(0,27,1),r(0,0x0000ffff,0)));
		}
		else if(op0==8){
			a[i]=(op(op0,nosmall(), r(0, 27, 1), r(0, 31, 0)));
		}
		else if(op0==5){//lw
			r1=r(0,size_dm-1,0)*4;
			r2=r(1,small_reg,0);
			a[i]=(op(op0,nosmall(),small[r2],r1-val[small[r2]]));
		}
		else if(op0==13 || op0 == 19){// lh lhu
			r1=r(0, size_dm-1, 0)*2;
			r2=r(1, small_reg, 0);
			a[i]=(op(op0,nosmall(),small[r2],r1-val[small[r2]]));
		}
		else if(op0==6){//sw
			r1=r(0,size_dm-1,0)*4;
			r2=r(1,small_reg,0);
			a[i]=(op(op0,r(0,27,1),small[r2],r1-val[small[r2]]));
		}
		else if(op0==14){//sh
			r1=r(0,size_dm-1,0)*2;
			r2=r(1,small_reg,0);
			a[i]=(op(op0,r(0,27,1),small[r2],r1-val[small[r2]]));
		}
		else if(op0==11 || op0 == 20){//lb lbu
			r1=r(0, size_dm-1, 0);
			r2=r(1, small_reg, 0);
			a[i]=(op(op0, nosmall(), small[r2], r1-val[small[r2]]));
		}
		else if(op0==12){//sb
			r1=r(0, size_dm-1, 0);
			r2=r(1, small_reg, 0);
			a[i]=(op(op0, r(0, 27, 1), small[r2], r1-val[small[r2]]));
		}
		else if(op0==7||op0==15|| op0 == 16 || op0 == 17){//beq bne j jal由于往上跳转可能出现死循环，所以只生成往下跳转
			r3=r(i,size_im,0);
			a[i]=(op(op0,r(0,27,1),r(0,27,1),++cnt));
			branch[r3].push_back(cnt);
			if(op0 == 17) ra = r3;

		}
		else if(op0 == 18 && ra){//jr
			a[i]=op(op0,nosmall(),r(0,27,1),r(0,27,1));
			ra = 0;
		}
	}

	for(i=1;i<=size_im;i++){
		print(i);
		for(j=0;j<branch[i].size();j++)
		 	outfile<<"branch"<<branch[i][j]<<":"<<endl;
	}

	outfile.close();
	return;
}
    
void fileCmp(){
	// FILE *fp_cpu,*fp_mars;
	// char tmp_cpu[100],tmp_mars[100];
	int cnt=0, flag = 1;
	string tmp_cpu,tmp_mars;

	ifstream cpufile("msg_out_cpu.txt");
	ifstream marfile("msg_out_mars.txt");
	ofstream cmpfile("cmp_result.txt");

	// fp_cpu 	= fopen("msg_out_cpu.txt","r");
	// fp_mars = fopen("msg_out_mars.txt","r");
	// while( fgets(tmp_cpu,100,fp_cpu)!=NULL && fgets(tmp_mars,100,fp_mars)!=NULL ){
	// 	cnt++;
		
	// }
	//while(cpufile >> tmp_cpu && marfile >> tmp_mars){
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
	generateMips();
    system("java -jar MARS.jar nc mc CompactDataAtZero dump .text HexText test_stg_code.txt test_stg_mips.asm > msg_out_mars.txt");
	
	//fileCmp();
    return 0;
}
