`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:10:10 11/20/2021 
// Design Name: 
// Module Name:    D_CMP 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module D_CMP(
    input [31:0] A,
    input [31:0] B,
    output [1:0] ACmpB,
    output [1:0] ACmp0
    );
	//��ʵ����branchָ����ֻ�õ���A==B,��֮ǰ��Zero���ɣ�����������ÿ���Ҳ�����һЩ���ָ��
	assign ACmpB = (A == B) ? 2'b00 : 
						(A > B ) ? 2'b01 :
						(A < B ) ? 2'b10 : -1;
	assign ACmp0 = (A + B == 0 && A != 32'h8000_0000) ? 2'b00 : 2'b01 ;
	
endmodule
