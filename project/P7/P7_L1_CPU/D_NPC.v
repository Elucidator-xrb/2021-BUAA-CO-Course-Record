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
	// branch类指令：这里将Zero ACmp0等决定是否跳转的指令传到CU，通过控制NPCOp来反馈是否跳转的信息。
	// 这样可以将PC4内容的选择全放在NPCOp里完成,减少重复指令内容，增加内聚程度

	assign NPC = (Req) ? 32'h0000_4180 :
					 (eret)? EPC_in :   //是否要加4？异常处理方式细节不清楚
					 (NPCOp == `NPC_order)  ? PC_F + 4 : //易错，增量是相对于F级的PC而言的;且在跳转时无法用PC+8替代。
					 (NPCOp == `NPC_branch) ? PC_b :
					 (NPCOp == `NPC_jump )  ? PC_j :
					 (NPCOp == `NPC_reg	)  ? RA 	 : 
						PC_F + 4 ;

endmodule
