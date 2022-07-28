`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:44:44 11/20/2021 
// Design Name: 
// Module Name:    D_GRF 
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
module D_GRF(
    input [31:0] WPC,
    input Clk,
    input Rst,
    input RFWr,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2
    );
	reg [31:0] grf[0:31]; //这里还是生成了0号寄存器，为了内部转发时写得方便
	integer i;
//	integer handle;
	
	wire [31:0] grf4 = grf[4];
	
	assign RD1 = (A3 == A1 && RFWr == 1 && A1 != 0) ? WD : grf[A1] ; //D级内部转发
	assign RD2 = (A3 == A2 && RFWr == 1 && A2 != 0) ? WD : grf[A2] ; //cao,误写
	
	always @(posedge Clk) begin
		if(Rst == 1) begin
			for(i=0;i<32;i=i+1) grf[i] <= 0;
		end else if(RFWr == 1 && A3 != 0) begin
			grf[A3] <= WD;				
//			$display("%d@%h: $%d <= %h", $time, WPC, A3, WD);
//			//$display("@%h: $%d <= %h", WPC, A3, WD);  //记得改回
//			
//			handle = $fopen("../msg_out_cpu.txt","a");
//			$fdisplay(handle,"@%h: $%d <= %h", WPC, A3, WD);
//			$fclose(handle);
		end
	end
	
	initial begin
		for(i=0;i<32;i=i+1) grf[i] <= 0;
	end

endmodule
