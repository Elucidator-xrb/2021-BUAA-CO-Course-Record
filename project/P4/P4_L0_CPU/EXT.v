`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:49 11/13/2021 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] I,
    input [1:0] EXTOp,
    output [31:0] O
    );
	assign O = (EXTOp == 2'b00) ? {16'h0000,I} 	:
				  (EXTOp == 2'b01) ? {{16{I[15]}},I}:
				  (EXTOp == 2'b10) ? {I,16'h0000} 	: -1 ;
					
endmodule
