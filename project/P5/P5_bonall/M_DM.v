`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:56 11/20/2021 
// Design Name: 
// Module Name:    M_DM 
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

`define hData DM[addr][15+16*A[1] -: 16]
`define bData DM[addr][7+8*A[1:0] -: 8 ]
`define h_sign DM[addr][15+16*A[1]]
`define b_sign DM[addr][7+8*A[1:0]]

module M_DM( //向roife致敬
    input [31:0] WPC,
    input Clk,
    input Rst,
    input DMWr,
    input [31:0] A,
    input [31:0] WD,
    input [2:0] DMOp,
    output [31:0] RD
    );
	reg [31:0] DM[0:3071];
	wire [11:0] addr; //DM中的地址-索引
	integer i;
	integer handle;
	
	assign addr = A[13:2];
	
	assign RD = (DMOp == `DM_w) ? DM[addr] :
					(DMOp == `DM_h) ? {{16{`h_sign}},`hData} :
					(DMOp == `DM_b) ? {{24{`b_sign}},`bData} :
					(DMOp == `DM_hu)? {16'd0,`hData} :
					(DMOp == `DM_bu)? {24'd0,`bData} : -1;
	
	always @(posedge Clk) begin
		if(Rst == 1) begin
			for(i=0;i<3072;i=i+1) DM[i] <= 0;
		end else if (DMWr == 1) begin
			case(DMOp)
				`DM_w : DM[addr] <= WD;
				`DM_h : `hData	<= WD[15:0];
				`DM_b : `bData	<= WD[7:0];
				default: ;
			endcase
			//$display("%d@%h: *%h <= %h", $time, WPC, A, WD);
			$display("@%h: *%h <= %h", WPC, A, WD); //记得改回
			
			handle = $fopen("../msg_out_cpu.txt","a");
			$fdisplay(handle,"@%h: *%h <= %h", WPC, A, WD);
			$fclose(handle);
		end
	end

	initial begin
		for(i=0;i<3072;i=i+1) DM[i] = 0;
	end
	
endmodule
