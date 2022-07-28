`timescale 1ns / 1ps

module D_REG(
    input Clk,
    input Rst,
    input We,
    input [31:0] IR_in,
    input [31:0] PC_in,
    output reg [31:0] IR_out,
    output reg [31:0] PC_out
    );

	always @(posedge Clk) begin
		if(Rst == 1) begin
			IR_out <= 0;
			PC_out <= 0;
		end else if(We == 1) begin
			IR_out <= IR_in;
			PC_out <= PC_in;
		end
	end
	
	initial begin
		IR_out = 0;
		PC_out = 0;
	end

endmodule
