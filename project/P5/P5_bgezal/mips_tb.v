`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:28:30 11/23/2021
// Design Name:   mips
// Module Name:   D:/0_Personal_File/Grade2_01_Autumn/CO/P5/P5_L0_CPU/mips_tb.v
// Project Name:  P5_L0_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mips_tb;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips mips_cpu (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 0;
		//reset = 1;
		//#10;
		//reset = 0;
		
	end
	
	always #0.5 clk = ~clk;
      
endmodule

