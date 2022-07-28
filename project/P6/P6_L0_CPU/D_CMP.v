`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:10:10 11/20/2021 
// Design Name: 
// Module Name:    D_CMP 
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

module D_CMP(
    input signed [31:0] A,
    input signed [31:0] B,
    output [1:0] ACmpB,
    output [1:0] ACmp0
    );
	//其实基础branch指令里只用到了A==B,用之前的Zero即可，但这样整齐好看，也方便加一些奇怪指令
	assign ACmpB = (A == B) ? 2'b00 : 
						(A > B ) ? 2'b01 :
						(A < B ) ? 2'b10 : -1;
	assign ACmp0 = (A == 0) ? 2'b00 : 
						(A > 0 ) ? 2'b01 :
						(A < 0 ) ? 2'b10 : -1;
endmodule
