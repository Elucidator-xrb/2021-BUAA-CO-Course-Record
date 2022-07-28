`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:22 11/13/2021 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input Clk,
    input Rst,
    input [25:0] IMM,
    input [31:0] RA,
    input [1:0] NPCOp,
	 input [1:0] ACmp0,
    input Zero,
	 input BSel,
    output [31:0] PC4,
    output [31:0] IM_D,
	 output [31:0] PC_sgn
    );
	reg [31:0] PC;
	reg [31:0] IM[0:1023];
	wire [31:0] NPC;
	
	wire [31:0] PC_b;
	wire [31:0] PC_beq, PC_bne;
	//wire [31:0] PC_bgez, PC_bgtz, PC_blez, PC_bltz;
	integer i;
	
	assign PC4 = PC + 32'd4;
	assign PC_beq  = (Zero == 1'b1) ? PC4 + {{14{IMM[15]}},IMM[15:0],2'b00} : PC4;
	assign PC_bne  = (Zero == 1'b0) ? PC4 + {{14{IMM[15]}},IMM[15:0],2'b00} : PC4;
	//assign PC_bgez = (ACmp0 != 2'b10) ? PC4 + {{14{IMM[15]}},IMM[15:0],2'b00} : PC4;
	//assign PC_bgtz = (ACmp0 == 2'b01) ? PC4 + {{14{IMM[15]}},IMM[15:0],2'b00} : PC4;
	//assign PC_blez = (ACmp0 != 2'b01) ? PC4 + {{14{IMM[15]}},IMM[15:0],2'b00} : PC4;
	//assign PC_blez = (ACmp0 == 2'b10) ? PC4 + {{14{IMM[15]}},IMM[15:0],2'b00} : PC4;
	assign PC_b = (BSel == 1'b0) ?  PC_beq : PC_bne;
	assign NPC = (NPCOp == 2'b00) ? PC4 :
					 (NPCOp == 2'b01) ? PC_b:
					 (NPCOp == 2'b10) ? {PC[31:28], IMM, 2'b00} :
					 (NPCOp == 2'b11) ? RA 	: -1 ;
	assign PC_sgn = PC;
	assign IM_D = IM[(PC-32'h00003000)/4];
	
	always @(posedge Clk) begin
		if(Rst == 1) begin
			PC <= 32'h0000_3000;
		end else begin
			PC <= NPC;
		end
	end
	
	initial begin
		PC = 32'h0000_3000;
		for(i=0;i<1024;i=i+1)
			IM[i] = 32'h0000_0000;
		$readmemh("code.txt",IM);
	end

endmodule