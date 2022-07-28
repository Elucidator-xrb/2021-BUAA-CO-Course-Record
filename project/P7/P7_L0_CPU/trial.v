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
	 output reg [31:0] test
    );
    initial begin
        $display("abcd");
    end
	always @(*) begin
		test <= 0;
		test[15:0] <= 16'h1234;
	end

endmodule
