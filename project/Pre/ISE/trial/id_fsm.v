`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:03:31 09/29/2021 
// Design Name: 
// Module Name:    id_fsm 
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
`define S2 2'b10

module id_fsm(
    input [7:0] char,
    input clk,
    output out
    );
	reg [1:0] status = `S0;
	
	always@(posedge clk) begin
		case(status)
		`S0 : begin
					if(65 <= char && char <= 90 ||
						97 <= char && char <= 122) status <= `S1;
					else status <= `S0;
				end
		`S1,`S2 : begin
					if(65 <= char && char <= 90 ||
						97 <= char && char <= 122) status <= `S1;
					else if(48 <= char && char <= 57) status <= `S2;
					else status <= `S0;
				end
		endcase
	end
	 
	assign out = (status == `S2) ? 1 : 0 ;

endmodule
