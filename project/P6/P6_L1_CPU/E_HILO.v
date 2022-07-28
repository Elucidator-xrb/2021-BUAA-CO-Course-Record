`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:35 12/27/2021 
// Design Name: 
// Module Name:    HILO 
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

module E_HILO(
    input Clk,
    input Rst,
	 input [3:0] HILOOp,
    input [31:0] D1,
    input [31:0] D2,
	 output IsBusy,
    output [31:0] Out
    );
	reg [31:0] HI,LO;
	reg [31:0] HI_tmp, LO_tmp;
	
	integer Wait;
	wire Start;
	reg  Busy;
	
	assign Start = (HILOOp == `HILO_mult) | (HILOOp == `HILO_multu) |
						(HILOOp == `HILO_div ) | (HILOOp == `HILO_divu ) ;
	
	assign IsBusy = Start | Busy ;
	assign Out = (HILOOp == `HILO_mfhi) ? HI :
					 (HILOOp == `HILO_mflo) ? LO : 0;
	
	always @(posedge Clk) begin
		if(Rst == 1) begin
			HI <= 0;
			LO <= 0;
			Wait <= 0;
			Busy <= 0;
		end else begin
			if(Wait == 0) begin
				case(HILOOp)
				 `HILO_mult	: begin
										Busy <= 1;
										Wait <= 5;
										{HI_tmp,LO_tmp} <= $signed(D1) * $signed(D2);
								  end
				 `HILO_multu: begin
										Busy <= 1;
										Wait <= 5;
										{HI_tmp,LO_tmp} <= D1 * D2 ;
								  end
				 `HILO_div	: begin
										Busy <= 1;
										Wait <= 10;
										LO_tmp <= $signed(D1) / $signed(D2);
										HI_tmp <= $signed(D1) % $signed(D2);
								  end
				 `HILO_divu	: begin
										Busy <= 1;
										Wait <= 10;
										LO_tmp <= D1 / D2 ;
										HI_tmp <= D1 % D2 ;
								  end
				 `HILO_mthi	: begin
										HI <= D1 ;			 
								  end
				 `HILO_mtlo	: begin
										LO <= D1 ;
								  end
				 default		: ;
				endcase
			end else if(Wait == 1) begin
				Wait <= 0;
				Busy <= 0;
				HI <= HI_tmp;
				LO <= LO_tmp;
			end else Wait <= Wait - 1;
		end
	end

	initial begin
		HI = 0;
		LO = 0;
		Wait = 0;
		Busy = 0;
	end

endmodule
