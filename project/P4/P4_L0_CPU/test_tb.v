`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:57:08 11/14/2021
// Design Name:   test
// Module Name:   D:/0_Personal_File/Grade2_01_Autumn/CO/P4/P4_L0_CPU/test_tb.v
// Project Name:  P4_L0_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_tb;

	// Inputs
	reg [31:0] IM_D;

	// Outputs
	wire [2:0] out;
	wire [1:0] aout;
	// Instantiate the Unit Under Test (UUT)
	test uut (
		.IM_D(IM_D), 
		.out(out)
	);
	
	
	assign aout = out[1:0];
	initial begin
		// Initialize Inputs
		IM_D = -1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

