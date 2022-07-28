#include<fstream>
#include<vector>
#include<algorithm>
#include<cstdlib>
#include<ctime>
using namespace std;
ofstream cout("test_stg_mips.txt");
struct op
{
	int type,r1,r2,r3;
	op(){}
	op(int a1,int a2,int a3,int a4){
		type=a1,r1=a2,r2=a3,r3=a4;
	}
};
int size_im,size_dm,size_op,small_reg, ra;
op a[10010];
vector<int> branch[10010];
int is_small[40],small[40],val[40],cnt;
int r(int a,int b,int except1)//����1�żĴ���ʹ��ʱ���ܳ��ִ�����������ָ�����1�żĴ���
{
	int t0=rand()*2+rand()%2;
	int res=t0%(b-a+1)+a;
	return ((res==1)&&except1==1)?0:res;
}
int t[10010];
void get_small()//���ѡȡ���ɸ��Ĵ�������lw��sw�����ǵ�ֵС��dm��С�Ҳ���
{
	int i;
	for(i=1;i<=26;i++) t[i]=i;
	for(i=1;i<=26;i++) swap(t[i],t[rand()%30+1]);
	for(i=1;i<=small_reg;i++) small[i]=t[i]+1,is_small[t[i]+1]=1;
}
int nosmall()//���һ��������lw��sw�ļĴ���
{
	int u=r(0,27,1);
	while(is_small[u]==1){u=r(0,27,1);}
	return u;
}
void print(int x)
{
	if(a[x].type==0) cout<<"nop"<<endl;
	else if(a[x].type==1) cout<<"addu $"<<a[x].r1<<",$"<<a[x].r2<<",$"<<a[x].r3<<endl;
	else if(a[x].type==2) cout<<"subu $"<<a[x].r1<<",$"<<a[x].r2<<",$"<<a[x].r3<<endl;
	else if(a[x].type==3) cout<<"lui $"<<a[x].r1<<","<<a[x].r3<<endl;
	else if(a[x].type==4) cout<<"ori $"<<a[x].r1<<",$"<<a[x].r2<<","<<a[x].r3<<endl;
	else if(a[x].type==5) cout<<"lw $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==6) cout<<"sw $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==7) cout<<"beq $"<<a[x].r1<<",$"<<a[x].r2<<",branch"<<a[x].r3<<endl;
	//else if(a[x].type==8) cout<<"sll $"<<a[x].r1<<",$"<<a[x].r2<<","<<a[x].r3<<endl;
	//else if(a[x].type==9) cout<<"slt $"<<a[x].r1<<",$"<<a[x].r2<<",$"<<a[x].r3<<endl;
	//else if(a[x].type==10) cout<<"addiu $"<<a[x].r1<<",$"<<a[x].r2<<","<<a[x].r3<<endl;
	else if(a[x].type==11) cout<<"lb $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==12) cout<<"sb $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==13) cout<<"lh $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	else if(a[x].type==14) cout<<"sh $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;

	//else if(a[x].type==15) cout<<"bne $"<<a[x].r1<<",$"<<a[x].r2<<",branch"<<a[x].r3<<endl;
	else if(a[x].type==16) cout<<"j "<<"branch"<<a[x].r3<<endl;
	else if(a[x].type==17) cout<<"jal "<<"branch"<<a[x].r3<<endl;
	else if(a[x].type==18) cout<<"jr $ra"<<endl;
    //else if(a[x].type==19) cout<<"lhu $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;
	//else if(a[x].type==20) cout<<"lbu $"<<a[x].r1<<","<<a[x].r3<<"($"<<a[x].r2<<")"<<endl;

}
int main()
{
	// 0nop 1addu 2subu 3lui 4ori 5lw 6sw 7beq 8sll 9slt /10addiu 11lb 12sb 13lh 14sh /15bne
	// 16j 17jal 18jr 19lhu 20lbu

	int i,j;
	srand(time(0));
	size_im=100;//���ɵ�ָ��Ĵ�С
	size_dm=128;//DM�Ĵ�С
	size_op=18;//֧�ֵ�ָ��Ĵ�С
	small_reg=10;//��ǰ��small_reg��ָ���ori���ȶԼĴ������и�ֵ
	get_small();
	for(i=1;i<=small_reg;i++)
		a[i]=(op(4,small[i],0,val[small[i]]=r(0,size_dm-1,0)));
	for(i=small_reg+1;i<=size_im;i++)
	{
		int op0=r(0,size_op-1,0),r1,r2,r3;
		if(op0==0) a[i]=(op(0,0,0,0));
		else if(op0==1||op0==2||op0==9){//addu��subu
			a[i]=op(op0,nosmall(),r(0,27,1),r(0,27,1));
		}
		else if(op0==3||op0==4||op0==10){//lui��ori
			a[i]=(op(op0,nosmall(),r(0,27,1),r(0,65535,0)));
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
		else if(op0==14){
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
		else if(op0==7||op0==15|| op0 == 16 || op0 == 17){//beq j jal����������ת���ܳ�����ѭ��������ֻ����������ת
			r3=r(i,size_im,0);
			a[i]=(op(op0,r(0,27,1),r(0,27,1),++cnt));
			branch[r3].push_back(cnt);
			if(op0 == 17) ra = r3;

		}
		else if(op0 == 18 && ra)
		{
			a[i]=op(op0,nosmall(),r(0,27,1),r(0,27,1));
			ra = 0;
		}
	}
	for(i=1;i<=size_im;i++)
	{
		print(i);
		for(j=0;j<branch[i].size();j++)
			cout<<"branch"<<branch[i][j]<<":"<<endl;
	}
}
