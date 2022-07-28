`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:23 10/24/2021 
// Design Name: 
// Module Name:    string 
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
`define S0 2'b00
`define S1 2'b01
`define L0 2'b10

module string(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
	reg [1:0] state = `S0;
	
	assign out = (state == `S1) ? 1 : 0;
	
	always@(posedge clr) begin
		state <= `S0;
	end
	
	always@(posedge clk) begin
		if(clr == 1) state <= `S0;
		else begin
			case(state)
			`S0 : begin
							if("0" <= in && in <= "9") state <= `S1;
							else state <= `L0;
					end
			`S1 : begin
							if(in == "+" || in == "*") state <= `S0;
							else state <= `L0;
					end
			`L0 : begin
							state <= `L0;
					end
			default : 	state <= `L0;
			endcase
		end
	end


endmodule
