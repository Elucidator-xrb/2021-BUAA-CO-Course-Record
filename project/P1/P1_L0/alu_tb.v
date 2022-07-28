`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:38:36 10/23/2021
// Design Name:   alu
// Module Name:   D:/0_Personal_File/Grade2_01_Autumn/CO/P1/P1_L0/alu_tb.v
// Project Name:  P1_L0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [2:0] ALUOp;

	// Outputs
	wire [31:0] C;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.A(A), 
		.B(B), 
		.ALUOp(ALUOp), 
		.C(C)
	);

	initial begin
		// Initialize Inputs
		A = -10;
		B = 1;
		ALUOp = 5;
		
		#5;
		B=2; #5;
		B=3; #5;
		B=4; #5;
		B=5; #5;

	end
      
endmodule

