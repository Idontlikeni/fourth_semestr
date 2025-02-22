`timescale 1ns / 1ps

module main(
   input [15:0] a, b, c, d, e,
   output [31:0] f
    );
    assign f = a * b >> c/d + e;
endmodule
