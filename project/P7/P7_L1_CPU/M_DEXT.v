`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:40 12/28/2021 
// Design Name: 
// Module Name:    M_DEXT 
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

`define hData Data[15+16*Addr[1] -: 16]
`define bData Data[7+8*Addr[1:0] -: 8 ]
`define h_sign Data[15+16*Addr[1]]
`define b_sign Data[7+8*Addr[1:0]]

module M_DEXT(
    input [1:0] Addr,
    input [31:0] Data,
    input [2:0] DMOp,
    output [31:0] DOut
    );

	assign DOut = (DMOp == `DM_w) ? Data :
					  (DMOp == `DM_h) ? {{16{`h_sign}},`hData} :
					  (DMOp == `DM_b) ? {{24{`b_sign}},`bData} :
					  (DMOp == `DM_hu)? {16'd0,`hData} :
					  (DMOp == `DM_bu)? {24'd0,`bData} : -1;

endmodule
