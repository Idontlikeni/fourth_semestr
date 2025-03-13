`timescale 1ns / 1ps
module clk_divider #(DIV = 2) (
 input clk,
 output reg clk_div);
wire [$clog2(DIV/2)-1:0] cnt;
count #(.step(1), .mod(DIV/2)) cntr(
 .clk(clk),
 .RE(1'b0),
 .CE(1'b1),
 .dir(1'b0),
 .out(cnt)
);
initial clk_div = 0;
always@(posedge clk)
 if (cnt == 0)
 clk_div = ~clk_div;
endmodule