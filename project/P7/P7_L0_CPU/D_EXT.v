`timescale 1ns / 1ps
`include "const.v"

module D_EXT(
    input [15:0] I,
    input EXTOp,
    output [31:0] O
    );
	assign O = (EXTOp == `EXT_zero) ? {16'h0000,I} : {{16{I[15]}},I} ;

endmodule
