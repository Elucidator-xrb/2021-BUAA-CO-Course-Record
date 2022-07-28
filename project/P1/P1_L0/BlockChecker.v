`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:20 10/25/2021 
// Design Name: 
// Module Name:    BlockChecker 
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
`define Fa 4'd0
`define Sp 4'd1

`define B1 4'd2
`define B2 4'd3
`define B3 4'd4
`define B4 4'd5
`define B5 4'd6

`define E1 4'd7
`define E2 4'd8
`define E3 4'd9

module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );
	reg [3:0] state = `Sp;
	reg signed [31:0] match = 0;
	reg lock = 0;
	
	assign result = (match == 0 && lock == 0) ? 1 : 0;
	
//	always@(posedge reset) begin
//		state <= `Sp;
//		match <= 0;
//		lock <= 0;
//	end
	
	always@(posedge clk or posedge reset) begin
		if(reset == 1) begin
			state <= `Sp;
			match <= 0;
			lock <= 0;
		end else begin
			case(state)
			`Fa : begin
							if(in == " ") state <= `Sp;
							else state <= `Fa;
					end
			`Sp : begin
							if(in == "b" || in == "B") state <= `B1;
							else if(in == "e" || in == "E") state <= `E1;
							else if(in == " ") state <= `Sp;
							else state <= `Fa;
					end

			`B1 : begin
							if(in == "e" || in == "E") state <= `B2;
							else if(in == " ") state <= `Sp;
							else state <= `Fa;
					end
			`B2 : begin
							if(in == "g" || in == "G") state <= `B3;
							else if(in == " ") state <= `Sp;
							else state <= `Fa;
					end
			`B3 : begin
							if(in == "i" || in == "I") state <= `B4;
							else if(in == " ") state <= `Sp;
							else state <= `Fa;
					end
			`B4 : begin
							if(in == "n" || in == "N") begin
								state <= `B5;
								match <= match + 1;
							end else if(in == " ") state <= `Sp;
							else state <= `Fa;
					end
			`B5 : begin
							if(in == " ") state <= `Sp;
							else begin
								state <= `Fa;
								match <= match - 1;
							end
					end
			`E1 : begin
							if(in == "n" || in == "N") state <= `E2;
							else if(in == " ") state <= `Sp;
							else state <= `Fa;
					end
			`E2 : begin
							if(in == "d" || in == "D") begin
								state <= `E3;
								match <= match - 1;
							end else if(in == " ") state <= `Sp;
							else state <= `Fa;
					end
			`E3 : begin
							if(in == " ") begin
								state <= `Sp;
								if(match < 0) lock <= 1;
							end else begin 
								state <= `Fa;
								match <= match + 1;
							end
					end
			endcase
		end
	end

endmodule
