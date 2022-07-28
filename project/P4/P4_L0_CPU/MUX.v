`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:49:29 11/15/2021 
// Design Name: 
// Module Name:    MUX 
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
module MUX32_4to1(
	 output [31:0] O,
	 input [1:0] OP,
	 input [31:0] A00,
	 input [31:0] A01,
	 input [31:0] A10,
	 input [31:0] A11
    );
	assign O = (OP == 2'b00) ? A00 :
				  (OP == 2'b01) ? A01 :
				  (OP == 2'b10) ? A10 :
				  (OP == 2'b11) ? A11 : 0;
endmodule

module MUX5_4to1(
	 output [4:0] O,
	 input [1:0] OP,
	 input [4:0] A00,
	 input [4:0] A01,
	 input [4:0] A10,
	 input [4:0] A11
    );
	assign O = (OP == 2'b00) ? A00 :
				  (OP == 2'b01) ? A01 :
				  (OP == 2'b10) ? A10 :
				  (OP == 2'b11) ? A11 : 0;
endmodule

module MUX32_8to1(
	 output [31:0] O,
	 input [2:0] OP,
	 input [31:0] A000,
	 input [31:0] A001,
	 input [31:0] A010,
	 input [31:0] A011,
	 input [31:0] A100,
	 input [31:0] A101,
	 input [31:0] A110,
	 input [31:0] A111
	 );
	assign O = (OP == 3'b000) ? A000 :
				  (OP == 3'b001) ? A001 :
				  (OP == 3'b010) ? A010 :
				  (OP == 3'b011) ? A011 :
				  (OP == 3'b100) ? A100 :
				  (OP == 3'b101) ? A101 :
				  (OP == 3'b110) ? A110 :
				  (OP == 3'b111) ? A111 : 0;
endmodule


