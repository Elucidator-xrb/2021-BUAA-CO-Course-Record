`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:06:58 11/13/2021 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
	 input [4:0] Shamt,
    input [2:0] ALUOp,
    output [31:0] Y,
    output Zero,
	 output [1:0] ACmp0
    );
	assign Y = (ALUOp == 3'b000) ? A + B :
				  (ALUOp == 3'b001) ? A - B :
				  (ALUOp == 3'b010) ? A | B :
				  (ALUOp == 3'b011) ? B << Shamt :
				  (ALUOp == 3'b100) ? A < B : -1;
				   
	assign Zero  = (A == B) ? 1'b1 : 1'b0 ;
	assign ACmp0 = (A == 0) ? 2'b00 :
						(A >  0) ? 2'b01 :
						(A <  0) ? 2'b10 : -1;
endmodule
