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
	 output md,
	 output mf,
	 output mt,
	 
	 output [1:0] NPCOp,
	 output EXTOp,
	 output [1:0] ALUASel,
	 output [1:0] ALUBSel,
	 output [3:0] ALUOp,
	 output [3:0] HILOOp,
	 output [1:0] EYSel,
	 output [2:0] DMOp,
	 output DMWr,
	 output RFWr,
	 output [1:0] GRFA3Sel,
	 output [1:0] GRFWDSel
    );
	
	//op
	parameter special	= 6'b00_0000;
	parameter regimm	= 6'b00_0001;

	parameter ADD		= 6'b10_0000;	//funct
	parameter ADDU		= 6'b10_0001;	//funct
	parameter SUB		= 6'b10_0010;	//funct 
	parameter SUBU		= 6'b10_0011;	//funct
	parameter AND		= 6'b10_0100;	//funct
	parameter OR		= 6'b10_0101;	//funct
	parameter XOR		= 6'b10_0110;	//funct
	parameter NOR		= 6'b10_0111;	//funct
	parameter SLT		= 6'b10_1010;	//funct
	parameter SLTU		= 6'b10_1011;	//funct
	
	parameter SLL		= 6'b00_0000;	//funct
	parameter SRL		= 6'b00_0010;	//funct
	parameter SRA		= 6'b00_0011;	//funct
	parameter SLLV		= 6'b00_0100;	//funct
	parameter SRLV		= 6'b00_0110;	//funct
	parameter SRAV		= 6'b00_0111;	//funct
	
	parameter ADDI		= 6'b00_1000;
	parameter ADDIU 	= 6'b00_1001;
	parameter SLTI		= 6'b00_1010;
	parameter SLTIU	= 6'b00_1011;
	parameter ANDI		= 6'b00_1100;
	parameter ORI		= 6'b00_1101;
	parameter XORI		= 6'b00_1110;
	parameter LUI		= 6'b00_1111;
	
	parameter MULT		= 6'b01_1000;	//funct
	parameter MULTU	= 6'b01_1001;	//funct
	parameter DIV		= 6'b01_1010;	//funct
	parameter DIVU		= 6'b01_1011;	//funct
	parameter MFHI		= 6'b01_0000;	//funct
	parameter MTHI		= 6'b01_0001;	//funct
	parameter MFLO		= 6'b01_0010;	//funct
	parameter MTLO		= 6'b01_0011;	//funct
	
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
	parameter BLEZ 	= 6'b00_0110;
	parameter BGTZ 	= 6'b00_0111;	/* 这设置好生奇怪，互补为一对是嘛 */
	parameter BGEZ 	= 5'b0_0001;	//rt_op
	parameter BLTZ 	= 5'b0_0000;	//rt_op
	
	parameter JAL		= 6'b00_0011;
	parameter J			= 6'b00_0010;
	parameter JR		= 6'b00_1000;	//funct
	parameter JALR 	= 6'b00_1001;  //funct

	parameter BGEZAL	= 5'b1_0001;   //rt_op
	
	
	//wire addu,subu,ori,addiu,lui,sll,slt,lw,lh,lhu,lb,lbu,sw,sh,sb,beq,bne,jal,jr,j,jalr,bgezal;
	
	assign addu		= (op == special) & (funct == ADDU);
	assign add		= (op == special) & (funct == ADD );
	assign subu		= (op == special) & (funct == SUBU);
	assign sub		= (op == special) & (funct == SUB );
	assign _and		= (op == special) & (funct == AND );
	assign _or		= (op == special) & (funct == OR  );
	assign _xor		= (op == special) & (funct == XOR );
	assign _nor		= (op == special) & (funct == NOR );
	assign slt		= (op == special) & (funct == SLT );
	assign sltu		= (op == special) & (funct == SLTU);
	
	assign sll		= (op == special) & (funct == SLL );
	assign srl		= (op == special) & (funct == SRL );
	assign sra		= (op == special) & (funct == SRA );
	assign sllv		= (op == special) & (funct == SLLV);
	assign srlv		= (op == special) & (funct == SRLV);
	assign srav		= (op == special) & (funct == SRAV);
	
	assign addi		= (op == ADDI);
	assign addiu	= (op == ADDIU);
	assign slti		= (op == SLTI);
	assign sltiu	= (op == SLTIU);
	assign andi		= (op == ANDI);
	assign ori		= (op == ORI);
	assign xori		= (op == XORI);
	assign lui		= (op == LUI);
	
	assign mult		= (op == special) & (funct == MULT );
	assign multu	= (op == special) & (funct == MULTU);
	assign div		= (op == special) & (funct == DIV  );
	assign divu		= (op == special) & (funct == DIVU );
	assign mfhi		= (op == special) & (funct == MFHI );
	assign mthi		= (op == special) & (funct == MTHI );
	assign mflo		= (op == special) & (funct == MFLO );
	assign mtlo		= (op == special) & (funct == MTLO );
	
	assign lw		= (op == LW	);
	assign lh		= (op == LH	);
	assign lhu		= (op == LHU);
	assign lb		= (op == LB	);
	assign lbu		= (op == LBU);
	
	assign sw		= (op == SW	);
	assign sh		= (op == SH	);
	assign sb		= (op == SB	);
	
	assign beq		= (op == BEQ);
	assign bne		= (op == BNE);
	assign bgtz 	= (op == BGTZ);
	assign blez		= (op == BLEZ);
	assign bgez		= (op == regimm)	& (rt_op == BGEZ);
	assign bltz		= (op == regimm)	& (rt_op == BLTZ);
	
	assign jal		= (op == JAL);
	assign j			= (op == J  );
	assign jr		= (op == special) & (funct == JR	 );
	assign jalr 	= (op == special) & (funct == JALR);
	
	assign bgezal	= (op == regimm)	& (rt_op == BGEZAL);
	
	//指令分类
	assign cal_r  = add | addu | sub | subu | slt | sltu | _and | _or | _xor | _nor |
						 sll | sllv | srl | srlv | sra | srav ;
	assign cal_i  = addi | addiu | slti | sltiu | andi | ori | xori | lui ;
	assign md	  = mult | multu | div  | divu ;
	assign mt	  = mthi | mtlo ;
	assign mf	  = mfhi | mflo ;
	assign load   = lw | lh | lb | lhu | lbu ;
	assign store  = sw | sh | sb ;
	assign branch = beq | bne | bgtz | blez | bgez | bltz | bgezal ;
	assign j_addr = j | jal ;
	assign j_link = jal | jalr | bgezal ;
	assign j_reg  = jr | jalr ;
	
	/* =================================================== */
	
	assign NPCOp = ((beq && ACmpB == `CMP_equal)	| 
						 (bne && ACmpB != `CMP_equal)	|
						 (bgtz && ACmp0 == `CMP_great)|
						 (blez && ACmp0 != `CMP_great)|
						 (bltz && ACmp0 == `CMP_small)|
						 (bgez && ACmp0 != `CMP_small)|
						 (bgezal && ACmp0 != `CMP_small)) ? `NPC_branch :
						(j | jal)	? `NPC_jump	:
						(jr | jalr)	? `NPC_reg	:
						`NPC_order ;
	assign EXTOp = (andi | ori | xori | lui) ? `EXT_zero : `EXT_sign ;
	
	assign ALUASel = ( sll  | srl  | sra  ) ? `ALUA_shamt : `ALUA_rd1 ;
	assign ALUBSel = (cal_i | load | store) ? `ALUB_imm   : `ALUB_rd2 ;
	assign ALUOp = (addu | add | addi | addiu) ? `ALU_add :
						(subu | sub ) ? `ALU_sub :
						(slt  | slti) ? `ALU_slt :
						(sltu | sltiu)? `ALU_sltu:
						(_and | andi) ? `ALU_and :
						(_or  | ori ) ? `ALU_or  :
						(_xor | xori) ? `ALU_xor :
						(_nor) ? `ALU_nor : 
						(sll  | sllv) ? `ALU_sll :
						(srl  | srlv) ? `ALU_srl :
						(sra  | srav) ? `ALU_sra :
						(lui)  ? `ALU_lui :
						`ALU_add ; //好多缺省的都用ALU_add
	assign HILOOp = (mult ) ? `HILO_mult  :
						 (multu) ? `HILO_multu :
						 (div  ) ? `HILO_div   :
						 (divu ) ? `HILO_divu  :
						 (mfhi ) ? `HILO_mfhi  :
						 (mthi ) ? `HILO_mthi  :
						 (mflo ) ? `HILO_mflo  :
						 (mtlo ) ? `HILO_mtlo  :
							4'b1000;
	assign EYSel = (mf) ? `EY_hilo : `EY_alu ;
	
	assign DMOp  = (lw | sw) ? `DM_w :
						(lh | sh) ? `DM_h :
						(lb | sb) ? `DM_b :
						(lhu)     ? `DM_hu:
						(lbu)     ? `DM_bu:
						`DM_w ;
	assign DMWr  = store ;
	
	assign RFWr  = cal_r | cal_i | load | j_link | mf ;
	assign GRFA3Sel = (cal_r | jalr | mf) ? `GRFA3_rd :
							(cal_i | load) ? `GRFA3_rt :
							(bgezal && ACmp0 == `CMP_small) ? `GRFA3_00 :
							`GRFA3_31 ;
	assign GRFWDSel =	(load)   ? `GRFWD_dm  : 
							(j_link) ? `GRFWD_pc8 :
							`GRFWD_alu ;

endmodule
