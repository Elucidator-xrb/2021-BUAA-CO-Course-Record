import os

#修改1：魔改版MARS的位置
# mars_dir = 'C:\\Users\\Dr.H\\Desktop\\Project5\\MARS.jar'
mars_dir = 'D:\\0_Personal_File\\Grade2_01_Autumn\\CO\\P5\\Mars_perfect.jar'

#修改2：将要自动生成的十六进制代码的存放位置
# hexcode_dir = 'C:\\Users\\Dr.H\\Desktop\\Project5\\code.txt'
hexcode_dir = 'D:\\0_Personal_File\\Grade2_01_Autumn\\CO\\P5\\code.txt'

#mipscode_dir在后面生成，这里不用修改
mipscode_dir = ''

#修改3：MARS提供的标准输出的存放位置
# standard_outdir = 'C:\\Users\\Dr.H\\Desktop\\Project5\\answer_fromMars.txt'
standard_outdir = 'D:\\0_Personal_File\\Grade2_01_Autumn\\CO\\P5\\ans_out_mars.txt'

#修改4：analysis文件夹和包含有带.asm后缀的MIPS源代码的位置
# walk = os.walk('C:\\Users\\Dr.H\\Desktop\\analysis\\work\\P5_LX_github')
walk = os.walk('D:\\0_Personal_File\\Grade2_01_Autumn\\CO\\P5\\P5tester\\analysis\\work\\P5_test_zrp')

fcmp = open('ans_cmp.txt','w')

epoch = 0
for path1, docu_list, file_list in walk:
    for file_name in file_list:
        if('.asm' in file_name):
            mipscode_dir = os.path.join(path1, file_name)
            
            print(epoch + 1,mipscode_dir)
            
            epoch = epoch + 1
            os.system('java -jar ' + mars_dir + ' ' + mipscode_dir + ' nc mc CompactDataAtZero a dump .text HexText ' + hexcode_dir) #编译出十六进制文件
            os.system('java -jar ' + mars_dir + ' ' + mipscode_dir + ' db nc mc CompactDataAtZero 30000 >' + standard_outdir)      
            
            print('mars finished')

            #进行编译
            #修改5：ISE/fuse/prj/conf四个文件的位置，详情见@何梓源同学的帖子
            # os.environ['XILINX'] = 'D:\\ise_full\\14.7\\ISE_DS\\ISE'
            os.environ['XILINX'] = 'D:\\Xilinx\\14.7\\ISE_DS\\ISE'
            # fuse_dir = 'D:\\ise_full\\14.7\\ISE_DS\\ISE\\bin\\nt64\\fuse'
            fuse_dir = 'D:\\Xilinx\\14.7\\ISE_DS\\ISE\\bin\\nt64\\fuse'
            # prj_dir = 'D:\\ISE_codes\\p5_version2\\testprj.prj'
            prj_dir = 'D:\\0_Personal_File\\Grade2_01_Autumn\\CO\\P5\\P5_L0_CPU\\mips_tb_beh.prj'
            # tcl_dir = 'D:\\ISE_codes\\p5_version2\\conf.tcl'
            tcl_dir = 'D:\\0_Personal_File\\Grade2_01_Autumn\\CO\\P5\\P5_L0_CPU\\conf.tcl'

            print('ise file prepared')

            #使用编译产生的可执行文件，输出CPU的答案
            #修改6：这里ISE的输出会在test.py当前的文件夹(cmd运行时的文件夹)下面输出
            #如果需要的话，需要指定ISE输出文件的位置
            os.system(fuse_dir + ' -nodebug -prj ' + prj_dir + ' -o testX.exe mips_tb > log.txt')
            os.system('testX.exe -nolog -tclbatch '+ tcl_dir + '> ans_out_cpu.txt')      

            print('ise finished')
             
            #开始比对两个文件
            #修改7：我的ISE在前8行会输出编译的信息，所以删除掉
            #请观察你的ISE输出并适当的修改

            temp = open('ans_out_cpu.txt', 'r')
            useful = temp.readlines()[8:] 
            newtemp = open('ans_out_cpu_new.txt', 'w')
            newtemp.writelines(useful)
            temp.close()
            newtemp.close()

            temp = open('ans_out_mars.txt', 'r')
            useful = temp.readlines()
            while useful[0][0:9] < '@00003000' :
                del useful[0]
            newtemp = open('ans_out_mars_new.txt', 'w')
            newtemp.writelines(useful)
            temp.close()
            newtemp.close()

            file1 = open('ans_out_cpu_new.txt')
            l1 = file1.readlines()
            file2 = open('ans_out_mars_new.txt')
            l2 = file2.readlines()

            new_l1 = []
            new_l2 = []

            for i in range(len(l1)):
                if(l1[i][0] == '@'):
                    new_l1.append(l1[i])
            for i in range(len(l2)):
                if(l2[i][0] == '@'):
                    new_l2.append(l2[i])

            same = True
            if(len(new_l1) != len(new_l2)):
                same = False
            else:
                for i in range(len(new_l1)):
                    if(new_l1[i].strip() != new_l2[i].strip()):
                        print(i,'\n', new_l1[i], new_l2[i])
                        same = False
            if(same == False):
                print('Failure in: ', file_name, '  epoch: {}, result = {}'.format(epoch, same))
                fcmp.write('Failure in: ' + file_name + '  epoch: {}, result = {}\n'.format(epoch, same))
                break

            print('epoch: {}, result = {}'.format(epoch, same))
            fcmp.write('epoch: {}, result = {}\n'.format(epoch, same))

fcmp.close()