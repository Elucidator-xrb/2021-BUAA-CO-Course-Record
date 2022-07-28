`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:39 10/23/2021 
// Design Name: 
// Module Name:    trial 
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
module trial();
	reg [3:0] a;
	reg c;
	wire [7:0] b;
	
	assign b = (c == 1) ? $signed(a) : a ;
	 
	initial begin
		c = 1;
		a = 4'b1001;	
	end
 
endmodule
