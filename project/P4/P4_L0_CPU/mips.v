`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:32:29 11/13/2021 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
	
	wire [2:0] ALUOp;
	wire [1:0] NPCOp, EXTOp, SSel, LSel, M1Sel, M2Sel;
	wire BSel, M3Sel, RFWr, DMWr;
	wire [5:0] op, funct;
	
	integer handle;
	initial begin
		handle = $fopen("../msg_out_cpu.txt","w");
		$fclose(handle);
	end

	datapath dp (
    .Clk(clk), 
    .Rst(reset), 
    .NPCOp(NPCOp), 
    .EXTOp(EXTOp), 
    .ALUOp(ALUOp), 
	 .BSel(BSel),
    .SSel(SSel), 
    .LSel(LSel), 
    .M1Sel(M1Sel), 
    .M2Sel(M2Sel), 
    .M3Sel(M3Sel), 
    .RFWr(RFWr), 
    .DMWr(DMWr), 
    .op(op), 			//Output
    .funct(funct)
    );

	control ctrl (
    .op(op), 
    .funct(funct), 
    .NPCOp(NPCOp), 	//Output
    .EXTOp(EXTOp), 
    .ALUOp(ALUOp), 
	 .BSel(BSel),
    .SSel(SSel), 
    .LSel(LSel), 
    .M1Sel(M1Sel), 
    .M2Sel(M2Sel), 
    .M3Sel(M3Sel), 
    .RFWr(RFWr), 
    .DMWr(DMWr)
    );


endmodule
