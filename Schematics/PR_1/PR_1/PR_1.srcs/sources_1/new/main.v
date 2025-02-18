`timescale 1ns / 1ps

module main(
   input a, b, c, d, e,
   output [1:0] f
    );
    assign f = a * b >> c/d + e;
endmodule
