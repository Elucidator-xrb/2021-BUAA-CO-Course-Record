`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:56 11/22/2021 
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
module trial(
	 output C,
	 output D,
	 output E,
	 output F,
	 output [7:0] Da,
	 output [7:0] Ea
    );
	 
	wire [7:0] A = 8'b1011_1100;
	wire B = 1;
	
	assign C = ^A;				// 1
	assign D = ^A && B;		// 1
	assign E = ^A & B;		// 0
	assign F = ^(A & B);		// 0
	assign Da = ^A && B;	 	
	assign Ea = ^A & B;

endmodule
