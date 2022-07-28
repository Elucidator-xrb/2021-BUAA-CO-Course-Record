`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:34:59 11/20/2021 
// Design Name: 
// Module Name:    E_ALU 
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

module E_ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
	 
	 output ExcOv,
    output [31:0] Y
    );
	wire [32:0] A_ext, B_ext, tmp_add, tmp_sub;
	
	assign A_ext = {A[31],A};
	assign B_ext = {B[31],B};
	assign tmp_add = A_ext + B_ext;
	assign tmp_sub = A_ext - B_ext;
	assign ExcOv = ((ALUOp == `ALU_addu) && (tmp_add[32]==tmp_add[31])) |
						((ALUOp == `ALU_subu) && (tmp_sub[32]==tmp_sub[31])) ;
	 
	assign Y = ((ALUOp == `ALU_add) | (ALUOp == `ALU_addu)) ? A + B	: // add addu addi addiu 
              ((ALUOp == `ALU_sub) | (ALUOp == `ALU_subu)) ? A - B	: // sub subu
				  (ALUOp == `ALU_and ) ? A & B 	: // and andi
				  (ALUOp == `ALU_or  ) ? A | B	: // or ori
              (ALUOp == `ALU_xor ) ? A ^ B 	: // xor xori
              (ALUOp == `ALU_nor ) ? ~(A|B)	: // nor
				  (ALUOp == `ALU_lui ) ? B << 16 : // lui
              (ALUOp == `ALU_sll ) ? B << A[4:0]	: // sll sllv
              (ALUOp == `ALU_srl ) ? B >> A[4:0]	: // srl srlv
              (ALUOp == `ALU_sra ) ? $signed($signed(B) >>> A[4:0]): // sra srav
              (ALUOp == `ALU_slt ) ? $signed(A) < $signed(B)  : // slt
              (ALUOp == `ALU_sltu) ? A < B 	: // sltu
					-1;

endmodule
