`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:56:16 10/23/2021 
// Design Name: 
// Module Name:    gray 
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
`define G0 3'b000
`define G1 3'b001
`define G2 3'b011
`define G3 3'b010
`define G4 3'b110
`define G5 3'b111
`define G6 3'b101
`define G7 3'b100

module gray(
    input Clk,
    input Reset,
    input En ,
    output reg [2:0] Output = `G0,
    output reg Overflow = 0
    );
	reg [2:0] cnt = 0;
	//reg [2:0] grey[0:7]; 这样好像就得initial了
	
//	reg clk = 0;
//	reg en = 0;
//	reg reset = 0;
//	always #10 clk = ~clk;
//	assign Clk = clk;
//	assign En = en;
//	assign Reset = reset;
//	initial begin
//		en = 0; #5;
//		en = 1; #200;
//		reset = 1; #24;
//		reset = 0; en=0; #10;
//	end
	 
	always@(posedge Clk) begin
		if(Reset == 1) begin
			cnt <= 0;
			Output <= `G0;
			Overflow <= 0;
		end else if(En == 1) begin
			case(cnt)
			0 : begin Output <= `G1; cnt <= cnt+1; end
			1 : begin Output <= `G2; cnt <= cnt+1; end
			2 : begin Output <= `G3; cnt <= cnt+1; end
			3 : begin Output <= `G4; cnt <= cnt+1; end
			4 : begin Output <= `G5; cnt <= cnt+1; end
			5 : begin Output <= `G6; cnt <= cnt+1; end
			6 : begin Output <= `G7; cnt <= cnt+1; end
			7 : begin Output <= `G0; cnt <= cnt+1; Overflow <= 1; end		
			endcase
		end
	 end


endmodule
