`timescale 1ns / 1ps


module main(
    input clk, in,
    output out
);
    reg ff1, ff2;
    always@(posedge clk)begin
        ff1 <= in;
        ff2 <= ~ff1;
    end
    assign out = ff2;
endmodule