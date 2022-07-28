`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:02:49 11/20/2021 
// Design Name: 
// Module Name:    D_EXT 
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

module D_EXT(
    input [15:0] I,
    input EXTOp,
    output [31:0] O
    );
	assign O = (EXTOp == `EXT_zero) ? {16'h0000,I} : {{16{I[15]}},I} ;

endmodule
