`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:53:52 11/14/2021 
// Design Name: 
// Module Name:    test 
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
module test(
	 input wire [31:0] IM_D,
	 output [2:0] out
    );
	reg [31:0] rf[1023:0];
	reg [31:0] rf2;
	assign rf2 = 0; 
	
	integer handle;
	
	initial begin
		handle = $fopen("h.txt","w");
		$fdisplay("hhhh");
		$fclose(handle);

		handle = $fopen("h.txt","a");
		$fdisplay("aaaa");
		$fclose(handle);
	end

endmodule
