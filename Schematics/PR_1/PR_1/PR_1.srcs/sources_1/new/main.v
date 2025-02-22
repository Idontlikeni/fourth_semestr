`timescale 1ns / 1ps

module main(
    input signed a, b, c, d, e,
    output signed [1:0] f
    );
    assign f = a * b >> c/d + e;
endmodule
