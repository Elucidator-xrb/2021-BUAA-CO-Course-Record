`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:30 10/26/2021 
// Design Name: 
// Module Name:    cpu_checker2 
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
`define S0 4'd0
`define S1 4'd1
`define S2 4'd2
`define S3 4'd3
`define S4 4'd4
`define S5 4'd5
`define S6 4'd6
`define S7 4'd7
`define S8 4'd8
`define S9 4'd9

`define SA 4'd10
`define SB 4'd11

module cpu_checker2(
    input clk,
    input reset,
    input [7:0] char,
    input [15:0] freq,
    output [1:0] format_type,
    output [3:0] error_code
    );
	reg [3:0] status = `S0;
	reg [3:0] cnt = 0;
	reg op;
	reg [3:0] error = 4'b0000;
	
	reg [31:0] pc = 0;
	reg [31:0] addr = 0;
	reg [31:0] grf = 0;
	reg [15:0] t = 0;
	reg [15:0] f = freq >> 1;
	
	assign format_type = (status == `S9 && op == 0) ? 2'b01 :
								(status == `S9 && op == 1) ? 2'b10 : 2'b00 ;
	assign error_code[0] = isTime(t) ? 0 : 1;
	assign error_code[1] = isPC(pc) ? 0 : 1;
	assign error_code[2] = isADDR(addr) ? 0 : 1;
	assign error_code[3] = isGRF(grf) ? 0 : 1;
	
	always@(posedge clk) begin
		if(reset == 1) begin
			status <= `S0;
			cnt <= 0;
		end	
		else begin
			case(status)
			`S0 : begin
							if(char == "^") status <= `S1;
							else status <= `S0;		
					end
			`S1 : begin
							if("0" <= char && char <= "9") begin
								cnt <= 1;
								status <= `S2;
							end else status <= `S0;
					end
			`S2 : begin
							if("0" <= char && char <= "9" && cnt < 4) begin
								cnt <= cnt + 1;
								status <= `S2;
							end else if(char == "@") begin
								cnt <= 0;
								status <= `S3;
							end else status <= `S0;
					end
			`S3 : begin
							if( ("0" <= char && char <= "9" || "a" <= char && char <= "f") && cnt < 8 ) begin
								cnt <= cnt + 1;
								status <= `S3;
							end else if(char == ":" && cnt == 8) begin
								cnt <= 0;
								status <= `S4;
							end else status <= `S0;
					end
			`S4 : begin
							if(char == " ") status <= `S4;
							else if(char == "$") begin
								status <= `SA;
								op <= 0;
							end else if(char == 8'd42) begin
								status <= `SB;
								op <= 1;
							end else status <= `S0;
					end
			`SA : begin
							if("0" <= char && char <= "9" && cnt < 4) begin
								cnt <= cnt + 1;
								status <= `SA;
							end else if(char == " " && cnt > 0) begin  //because cnt start from 0 here
								cnt <= 0;
								status <= `S5;
							end else if(char == "<" && cnt > 0) begin
								cnt <= 0;
								status <= `S6;
							end else status <= `S0;
					end
			`SB : begin
							if( ("0" <= char && char <= "9" || "a" <= char && char <= "f") && cnt < 8 ) begin
								cnt <= cnt + 1;
								status <= `SB;
							end
							else if(char == " " && cnt == 8) begin
								cnt <= 0;
								status <= `S5;
							end
							else if(char == "<" && cnt == 8) begin
								cnt <= 0;
								status <= `S6;
							end
							else status <= `S0;
					end
			`S5 : begin
							if(char == " ") status <= `S5;
							else if(char == "<") status <= `S6;
							else status <= `S0;
					end
			`S6 : begin
							if(char == "=") status <= `S7;
							else status <= `S0;
					end
			`S7 : begin
							if("0" <= char && char <= "9" || "a" <= char && char <= "f") begin
								cnt <= 1;
								status <= `S8;
							end else if(char == " ") status <= `S7;
							else status <= `S0;
					end
			`S8 : begin
							if( ("0" <= char && char <= "9" || "a" <= char && char <= "f") && cnt < 8 ) begin
								cnt <= cnt + 1;
								status <= `S8;
							end else if(char == "#" && cnt == 8) begin
								cnt <= 0;
								status <= `S9;
							end else status <= `S0;
					end
			`S9 : begin
							if(char == "^") status <= `S1;
							else status <= `S0;
					end
			default :	status <= `S0;
			endcase
		end
	end
	
endmodule
