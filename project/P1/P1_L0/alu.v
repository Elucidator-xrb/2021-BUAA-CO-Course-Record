`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:02 10/21/2021 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output [31:0] C
    );
	assign C = (ALUOp == 3'd0) ? A + B :
				  (ALUOp == 3'd1) ? A - B :
				  (ALUOp == 3'd2) ? A & B :
				  (ALUOp == 3'd3) ? A | B :
				  (ALUOp == 3'd4) ? A >> B :
				  (ALUOp == 3'd5) ? $signed($signed(A) >>> B) : 32'sd0;
				 
endmodule
