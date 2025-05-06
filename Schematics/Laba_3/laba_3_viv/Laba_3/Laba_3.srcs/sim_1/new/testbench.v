`timescale 1ns / 1ps
module testbench();

reg clk, R_I, reset;
reg [3:0] dataIn;
wire [3:0] dataOut;

initial
begin 

    clk <= 0;
    reset <= 1;
    R_I <= 0;
    dataIn <= 0;
    
    #30;    
    reset <= 0;
    dataIn <= 4'b0101;
    R_I <= 1;
    #30; dataIn <= 4'b0111; 
    #20; dataIn <= 4'b0011; 
    #20; dataIn <= 4'b0110; 
    #20; dataIn <= 4'b0001; 
    #20; dataIn <= 4'b0010; 
    #100;
    reset <= 1;
    R_I <= 0;
//    #60; reset = 1;    
end
always #10 clk <= ~clk;


fsm #(5, 4)fsm1 (
    .clk(clk),
    .reset(reset),
    .R_I(R_I),
    .dataIn(dataIn),
    .dataOut(dataOut),
    .R_O(R_O)
);
endmodule
