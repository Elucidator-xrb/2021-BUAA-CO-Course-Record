`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:28:56 09/29/2021
// Design Name:   id_fsm
// Module Name:   D:/0_Personal File/Grade2_01_Autumn/CO/ISE/trial/id_fsm_tb.v
// Project Name:  trial
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: id_fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module id_fsm_tb;

	// Inputs
	reg [7:0] char;
	reg clk;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	id_fsm uut (
		.char(char), 
		.clk(clk), 
		.out(out)
	);

	initial begin
		clk = 0;
		char = "a"; #10;
		char = "b"; #10;
		char = "3"; #10;
		char = "2"; #10;
		char = ")"; #10;
		char = "1"; #10;
		char = "e"; #10;
		char = "1"; #10;
		char = "e"; #10;
		char = "6"; #10;
	end
	
	always #5 clk = ~clk;
      
endmodule

