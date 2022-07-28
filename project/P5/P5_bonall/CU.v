`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:48:20 11/20/2021 
// Design Name: 
// Module Name:    CU 
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

module CU(
    input [5:0] op,
    input [5:0] funct,
    input [4:0] rt_op,
	 input [1:0] ACmpB,
	 input [1:0] ACmp0,
	 
	 output cal_r,
	 output cal_i,
	 output load,
	 output store,
	 output branch,
	 output j_addr,
	 output j_link,
	 output j_reg,
	 
	 output [1:0] NPCOp,
	 output EXTOp,
	 output [3:0] ALUOp,
	 output [2:0] DMOp,
	 output RFWr,
	 output DMWr,
	 output [1:0] GRFA3Sel,
	 output [1:0] ALUBSel,
	 output [1:0] GRFWDSel,
	 
	 output Nullify
    );
	
	//op
	parameter special	= 6'b00_0000;

	parameter ADDU		= 6'b10_0001;	//funct
	parameter SUBU		= 6'b10_0011;	//funct
	parameter ORI		= 6'b00_1101;
	parameter SLL		= 6'b00_0000;	//funct
	parameter ADDIU 	= 6'b00_1001;
	parameter LUI		= 6'b00_1111;
	parameter SLT		= 6'b10_1010;	//funct
	
	parameter LB		= 6'b10_0000;
	parameter LH		= 6'b10_0001;
	parameter LW		= 6'b10_0011;
	parameter LBU		= 6'b10_0100;
	parameter LHU		= 6'b10_0101;
	parameter SB		= 6'b10_1000;
	parameter SH		= 6'b10_1001;
	parameter SW		= 6'b10_1011;
	
	parameter BEQ		= 6'b00_0100;
	parameter BNE		= 6'b00_0101;
	parameter BONALL  = 6'b01_1001;
	
	parameter JAL		= 6'b00_0011;
	parameter JR		= 6'b00_1000;	//funct
	parameter J			= 6'b00_0010;
	parameter JALR 	= 6'b00_1001;  //funct

	
	wire addu,subu,ori,addiu,lui,sll,slt,lw,lh,lhu,lb,lbu,sw,sh,sb,beq,bne,jal,jr,j,jalr,bonall;
	
	assign addu = (op == special) & (funct == ADDU);
	assign subu = (op == special) & (funct == SUBU);
	assign jr	= (op == special) & (funct == JR	 );
	assign sll	= (op == special) & (funct == SLL );
	assign slt	= (op == special) & (funct == SLT );
	assign jalr = (op == special) & (funct == JALR);
	assign ori	= (op == ORI);
	assign addiu= (op == ADDIU);
	assign lw	= (op == LW	);
	assign lh	= (op == LH	);
	assign lhu	= (op == LHU);
	assign lb	= (op == LB	);
	assign lbu	= (op == LBU);
	assign sw	= (op == SW	);
	assign sh	= (op == SH	);
	assign sb	= (op == SB	);
	assign beq	= (op == BEQ);
	assign bne	= (op == BNE);
	assign bonall = (op == BONALL);
	assign jal	= (op == JAL);
	assign j		= (op == J  );
	assign lui	= (op == LUI);
	
	//指令分类
	assign cal_r = addu | subu ;
	assign cal_i = ori | lui | addiu ;
	assign load  = lw | lh | lb | lhu | lbu ;
	assign store = sw | sh | sb ;
	assign branch = beq | bne | bonall ;
	assign j_addr = j | jal ;
	assign j_link = jal | jalr | bonall ;
	assign j_reg = jr | jalr ;
	
	/* =================================================== */
	assign Nullify = ( bonall && ACmp0 != 2'b00 ) ;
	assign NPCOp = ((beq && ACmpB == 2'b00)| 
						 (bne && ACmpB != 2'b00)|
						 (bonall && ACmp0 == 2'b00)) ? `NPC_branch :
						(j | jal)	? `NPC_jump	:
						(jr | jalr)	? `NPC_reg	:
						`NPC_order ;
	assign EXTOp = (ori | lui) ? `EXT_zero : `EXT_sign ;
	assign ALUOp = (addu | addiu) ? `ALU_add :
						(subu) ? `ALU_sub :
						(ori)  ? `ALU_or  :
						(sll)  ? `ALU_sll :
						(lui)  ? `ALU_lui :
						`ALU_add ; //好多缺省的都用ALU_add
	assign ALUBSel  = (cal_i | load | store) ? `ALUB_imm :
							(sll) ? `ALUB_shamt : `ALUB_rd2 ;
	assign DMOp  = (lw | sw) ? `DM_w :
						(lh | sh) ? `DM_h :
						(lb | sb) ? `DM_b :
						(lhu)     ? `DM_hu:
						(lbu)     ? `DM_bu:
						`DM_w ;
	
	assign DMWr  = store ;
	assign RFWr  = cal_r | cal_i | load | j_link | bonall ;
	assign GRFA3Sel = (cal_r | jalr) ? `GRFA3_rd :
							(cal_i | load) ? `GRFA3_rt :
												  `GRFA3_31 ;
	assign GRFWDSel =	(load)   ? `GRFWD_dm  : 
							(j_link | bonall) ? `GRFWD_pc8 :
									     `GRFWD_alu ;

endmodule
