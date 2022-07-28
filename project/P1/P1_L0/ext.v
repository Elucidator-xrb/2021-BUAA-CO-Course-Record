`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:33 10/23/2021 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output [31:0] ext
    );
	reg [31:0] ext_reg;
	
	assign ext = ext_reg;

	always@(*) begin
		case(EOp)
		2'b00:begin
						ext_reg = $signed(imm);
				end
		2'b01:begin
						ext_reg = imm;
				end
		2'b10:begin
						ext_reg[31:16] = imm;
						ext_reg[15:0] = 16'd0;
				end
		2'b11:begin
						ext_reg = $signed(imm);
						ext_reg = ext_reg << 2;
				end
		endcase
	end

endmodule
