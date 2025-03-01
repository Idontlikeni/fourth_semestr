`timescale 1ns / 1ps

module main(
    input  [16:0] a, b, c, d, e, 
    input clk,
    output reg [17:0] out
);
    reg [16:0] a_r, b_r, c_r, d_r, e_r;
    always@(posedge clk)
    begin
        a_r <= a;
        b_r <= b;
        c_r <= c;
        d_r <= d;
        e_r <= e;

    end
    always@(posedge clk)
    begin
        out <= a_r * b_r >> c_r/d_r + e_r;
    end
endmodule
