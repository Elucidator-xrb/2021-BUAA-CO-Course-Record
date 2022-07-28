`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:00 11/13/2021 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	 input [31:0] PC, //为了打印信号而传入
    input Clk,
    input Rst,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
	 input RFWr,
    output [31:0] RD1,
    output [31:0] RD2
    );
	integer handle; 
	 
	reg [31:0] rf[31:1];
	integer i;
	
	assign RD1 = (A1 == 0) ? 0 : rf[A1];
	assign RD2 = (A2 == 0) ? 0 : rf[A2];
	
	always @(posedge Clk) begin
		if(Rst == 1) begin
			for(i=1;i<32;i=i+1)
				rf[i] <= 32'h0000_0000;
		end else if(RFWr == 1 && A3 != 0) begin
			rf[A3] <= WD;				
			$display("@%h: $%d <= %h", PC, A3, WD);
			handle = $fopen("../msg_out_cpu.txt","a");
			$fdisplay(handle,"@%h: $%d <= %h", PC, A3, WD);
			$fclose(handle);
		end
	end
	
	initial begin
		for(i=1;i<32;i=i+1)
			rf[i] <= 32'h0000_0000;
	end

endmodule
