`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:49 09/29/2021 
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
    input [3:0] inA,
    input [3:0] inB,
    input [1:0] op,
	 input clk,
	 input en,
    output reg [3:0] ans
    );
	wire [3:0] tmp;
	
	assign tmp = (op == 2'd0) ? (inA + inB) :
					 (op == 2'd1) ? (inA - inB) :
					 (op == 2'd2) ? (inA & inB) : 
										 (inA | inB) ;
	always@(posedge clk) begin
		if(en == 1) ans <= tmp;
		else ans <= ans;
	end
	
endmodule
