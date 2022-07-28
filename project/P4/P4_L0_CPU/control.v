`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:50:43 11/14/2021 
// Design Name: 
// Module Name:    control 
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
module control(
    input [5:0] op,
    input [5:0] funct,
    output [1:0] NPCOp,
    output [1:0] EXTOp,
    output [2:0] ALUOp,
	 output BSel,
    output [1:0] SSel,
    output [1:0] LSel,
    output [1:0] M1Sel,
    output [1:0] M2Sel,
    output M3Sel,
    output RFWr,
    output DMWr
    );
	//op
	parameter special	= 6'b00_0000;
	parameter ADDU		= 6'b10_0001;	//funct
	parameter SUBU		= 6'b10_0011;	//funct
	parameter ORI		= 6'b00_1101;
	parameter SLL		= 6'b00_0000;	//funct
	
	parameter LW		= 6'b10_0011;
	parameter LH		= 6'b10_0001;
	parameter LB		= 6'b10_0000;
	parameter SW		= 6'b10_1011;
	parameter SH		= 6'b10_1001;
	parameter SB		= 6'b10_1000;
	
	parameter BEQ		= 6'b00_0100;
	parameter BNE		= 6'b00_0101;
	parameter JAL		= 6'b00_0011;
	parameter JR		= 6'b00_1000;	//funct
	parameter J			= 6'b00_0010;
	parameter LUI		= 6'b00_1111;
	parameter SLT		= 6'b10_1010;	//funct
	
	wire addu,subu,ori,lw,lh,lb,sw,sh,sb,beq,bne,jal,jr,j,lui,sll,slt;
	
	assign addu = (op == special) & (funct == ADDU);
	assign subu = (op == special) & (funct == SUBU);
	assign jr	= (op == special) & (funct == JR	 );
	assign sll	= (op == special) & (funct == SLL );
	assign slt	= (op == special) & (funct == SLT );
	assign ori	= (op == ORI);
	assign lw	= (op == LW	);
	assign lh	= (op == LH	);
	assign lb	= (op == LB	);
	assign sw	= (op == SW	);
	assign sh	= (op == SH	);
	assign sb	= (op == SB	);
	assign beq	= (op == BEQ);
	assign bne	= (op == BNE);
	assign jal	= (op == JAL);
	assign j		= (op == J  );
	assign lui	= (op == LUI);
	
	/* =================================================== */

	assign NPCOp[1]	= jal | jr | j ;
	assign NPCOp[0]	= beq | jr | bne ;
	assign EXTOp[1]	= lui ;
	assign EXTOp[0]	= lw | lh | lb | sw | sh | sb ;
	assign ALUOp[2]	= slt ;
	assign ALUOp[1]	= ori | sll ;
	assign ALUOp[0]	= subu | sll ;
	assign BSel			= bne ;
	assign SSel[1]		= sb ;
	assign SSel[0]		= sh ;
	assign LSel[1]		= lb ;
	assign LSel[0]		= lh ;
	
	assign M1Sel[1]	= jal ;
	assign M1Sel[0]	= addu | subu | sll | slt ;
	assign M2Sel[1]	= addu | subu | ori | lui | sll | slt ;
	assign M2Sel[0]	= lw | lui | lh | lb ;
	assign M3Sel		= ori | lw | lh | lb | sw | sh | sb ; 
	assign RFWr			= addu | subu | ori | lw | lh | lb | jal | lui | sll | slt ;
	assign DMWr			= sw | sh | sb ;
			
endmodule
