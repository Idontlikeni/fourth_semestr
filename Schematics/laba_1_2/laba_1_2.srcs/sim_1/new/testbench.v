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
        c = 1; // xx1 (1)
        #20 a=0; c=0; // 0x0 (2)
        #20 c=0; // xx0 (3)
        #20 b=0; c=1; // x01 (3)
        #20 c=0; // xx0 (2)
        #20 c=1; // xx1 (1)
        #20 a=1;// 1xx (1)
        #20 a=0; c=1; // 0x1 (0)
        #20 c=0;// xx0 (3)
        #20 b=1;c=1;// x11 (0)
        #50 $stop;
    end
        
    mili M1(.clk(clk), .a(a), .b(b), .c(c), .state(mili_state), .d(mili_out));
    moore M2(.clk(clk), .a(a), .b(b), .c(c), .state(moore_state), .d(moore_out));
endmodule
