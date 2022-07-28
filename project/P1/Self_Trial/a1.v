`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:42 10/27/2021 
// Design Name: 
// Module Name:    a1 
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
module a1(
	 input [31:0] in,
	 output [31:0] out
    );
	reg[3:0] mem[1:0];
	reg[1:0] a = 1;
	reg[1:0] b = 2;
	reg[31:0] O;
	
	initial begin 
		mem[0] = 0;
		mem[1] = 1;
		 
		O = {a,b,mem[0],mem[1]};
		
		mem[0][1] = a > b;
	end

endmodule
