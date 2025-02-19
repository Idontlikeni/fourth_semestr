`timescale 1ns / 1ps

module testbench();
reg a=0;
reg b=0;
reg c=0;
reg clk=0;
wire mili_out;
wire moore_out;
always #10 clk = ~clk;
initial begin
    a=1; b=0; //10x (1) 
    #20 a=1; // 1xx (0) a->c
    #20 a=0; b=1; // 0xx (3) b|c
    #20; // 0xx (2) b&c;
    #20 c=1; // x11 (2) b&c
    #20 b=0; // x01 (1) 
    #20; // 0xx (2) b&c 
    #20 c=0; // 0xx (3) b|c 
    #20 a=1; c=1;// 1xx (0) a->c 
    
    #50 $stop;
end
    
Mili M1(.a(a), .b(b), .c(c),.clk(clk), .d(mili_out));
Moore M2(.a(a), .b(b), .c(c),.clk(clk), .d(moore_out));
endmodule
