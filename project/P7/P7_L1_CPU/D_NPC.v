`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:11:23 11/21/2021 
// Design Name: 
// Module Name:    D_NPC 
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
`include "const.v"

module D_NPC(
	 input Req,
	 input eret,
	 input [31:0] EPC_in,
    input [31:0] PC,
	 input [31:0] PC_F,
    input [25:0] IMM,
    input [31:0] RA,
    input [1:0] NPCOp,
    output [31:0] NPC
    );
	wire [31:0] PC_b,PC_j;
	assign PC_b = PC + 4 + {{14{IMM[15]}},IMM[15:0],2'b00};
	assign PC_j = {PC[31:28], IMM, 2'b00};
	// branch��ָ����ｫZero ACmp0�Ⱦ����Ƿ���ת��ָ���CU��ͨ������NPCOp�������Ƿ���ת����Ϣ��
	// �������Խ�PC4���ݵ�ѡ��ȫ����NPCOp�����,�����ظ�ָ�����ݣ������ھ۳̶�

	assign NPC = (Req) ? 32'h0000_4180 :
					 (eret)? EPC_in :   //�Ƿ�Ҫ��4���쳣����ʽϸ�ڲ����
					 (NPCOp == `NPC_order)  ? PC_F + 4 : //�״������������F����PC���Ե�;������תʱ�޷���PC+8�����
					 (NPCOp == `NPC_branch) ? PC_b :
					 (NPCOp == `NPC_jump )  ? PC_j :
					 (NPCOp == `NPC_reg	)  ? RA 	 : 
						PC_F + 4 ;

endmodule
