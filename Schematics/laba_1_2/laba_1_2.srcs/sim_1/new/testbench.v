`timescale 1ns / 1ps

module testbench();
    reg a=0;
    reg b=0;
    reg c=0;
    reg clk=0;
    wire [1:0] mili_state;
    wire [2:0] moore_state;
    
    wire mili_out;
    wire moore_out;
    
    always #10 clk = ~clk;
    initial begin
        b = 0;c = 1; // x01 (0)
        #20 c=0; // xx0 (2)
        #20 b=1; // x1x (1)
        #20 b=0; c=0; // x00 (0)
        #20 b=1; c=1; // x11 (3)
        #20 a=1; // 1xx (1)
        #20 c=1;// xx1 (2)
        #20 b=0; // x0x (3)
        #20 a=0;// 0xx (0)
        #50 $stop;
    end
        
    mili M1(.clk(clk), .a(a), .b(b), .c(c), .state(mili_state), .d(mili_out));
    moore M2(.clk(clk), .a(a), .b(b), .c(c), .state(moore_state), .d(moore_out));
endmodule
