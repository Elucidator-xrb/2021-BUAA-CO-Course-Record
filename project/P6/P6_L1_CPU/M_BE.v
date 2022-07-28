`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:25 12/28/2021 
// Design Name: 
// Module Name:    M_BE 
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
`include "const.v"

module M_BE(
    input [1:0] Addr,
    input [31:0] Write,
    input [2:0] DMOp,
	 input DMWr,
    output reg [3:0] ByteEn,
    output reg [31:0] DataWd
    );
	
	always @(*) begin
		if(DMWr == 1) begin
			case(DMOp)
			 `DM_w : begin
							DataWd <= Write;
							ByteEn <= 4'b1111;
						end
			 `DM_h : begin
							if(Addr[1] == 1'b0) begin
								DataWd <= {16'h0,Write[15:0]};
								ByteEn <= 4'b0011;
							end else if(Addr[1] == 1'b1) begin
								DataWd <= {Write[15:0],16'h0};
								ByteEn <= 4'b1100;
							end
						end
			 `DM_b : begin
							if(Addr == 2'b00) begin
								DataWd <= {24'h0,Write[7:0]};
								ByteEn <= 4'b0001;
							end else if(Addr == 2'b01) begin
								DataWd <= {16'h0,Write[7:0],8'h0};
								ByteEn <= 4'b0010;
							end else if(Addr == 2'b10) begin
								DataWd <= {8'h0,Write[7:0],16'h0};
								ByteEn <= 4'b0100;
							end else if(Addr == 2'b11) begin
								DataWd <= {Write[7:0],24'h0};
								ByteEn <= 4'b1000;
							end
						end
			 default: ;
			endcase
		end else begin
			DataWd <= Write;
			ByteEn <= 4'b0000;
		end
	end

endmodule
