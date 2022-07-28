`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:28:14 11/20/2021 
// Design Name: 
// Module Name:    E_REG 
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
module E_REG(
    input Clk,
    input Rst,
    input We,
    input [31:0] IR_in,
    input [31:0] PC_in,
    input [31:0] EXT_in,
    input [31:0] V1_in,
    input [31:0] V2_in,
    output reg [31:0] IR_out,
    output reg [31:0] PC_out,
    output reg [31:0] EXT_out,
    output reg [31:0] V1_out,
    output reg [31:0] V2_out
    );

    always @(posedge Clk) begin
        if(Rst == 1) begin
            IR_out  <= 0;
            PC_out  <= 0;
            EXT_out <= 0;
            V1_out  <= 0;
            V2_out  <= 0;
        end else if(We == 1) begin
            IR_out  <= IR_in;
            PC_out  <= PC_in;
            EXT_out <= EXT_in;
            V1_out  <= V1_in;
            V2_out  <= V2_in;
        end
    end
	 
	initial begin
		IR_out = 0;
      PC_out = 0;
      EXT_out = 0;
      V1_out  = 0;
      V2_out  = 0;
	end

endmodule
