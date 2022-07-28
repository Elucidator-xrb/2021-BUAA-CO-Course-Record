`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:37:41 09/29/2021
// Design Name:   code
// Module Name:   D:/0_Personal File/Grade2_01_Autumn/CO/ISE/trial/code_tb.v
// Project Name:  trial
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: code
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module code_tb;

	// Inputs
	reg Clk;
	reg Reset;
	reg Slt;
	reg En;

	// Outputs
	wire [63:0] Output0;
	wire [63:0] Output1;

	// Instantiate the Unit Under Test (UUT)
	code uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.Slt(Slt), 
		.En(En), 
		.Output0(Output0), 
		.Output1(Output1)
	);

	initial begin
		Clk = 0;
		Reset = 0;
		Slt = 0;
		En = 1;
		
		#80;
		Slt = 1;
		#480;
		En = 0;
		#20;
		Reset = 1;
	end
      
	always #5 Clk = ~Clk;
	
endmodule

