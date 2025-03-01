`timescale 1ns / 1ps

module testbench;



reg[3:0] SWITCHES = 0;
reg clk = 0;
reg button = 0;
reg button_reset = 0;
wire[7:0] AN;
wire[6:0] SEG;
wire [31:0] NUMBER;

//main cntlr(
//    .SWITCHES(SWITCHES),
//    .button_in(button),
//    .clk(clk),
//    .button_reset_in(button_reset),
//    .AN(AN),
//    .SEG(SEG));

main cntlr(
    .clk(clk),
    .btn_c(button),
    .SW(SWITCHES),
    .AN(AN),
    .SEG(SEG),
    .shift_register(NUMBER)
);

//    input clk,
//    input btn_c,
//    input [3:0] SW,
//    output [7:0] AN,
//    output [6:0] SEG


always #5 clk = ~clk;

initial
begin
    #50
    $srandom(35000);
    SWITCHES = 4'b1111;
    repeat($urandom_range(50,0))
    begin
        button = $random;
        #3;
    end
    button = 1;
    #100;
    
    repeat($urandom_range(50,0))
    begin
        button = $random;
        #3;
    end
    button = 0;
    #100;
    
    SWITCHES = 4'b0110;
    repeat($urandom_range(50,0))
    begin
        button = $random;
        #3;
    end
    button = 1;
    #100;
    
    repeat($urandom_range(50,0))
    begin
        button = $random;
        #3;
    end
    button = 0;
    
    repeat($urandom_range(50,0))
    begin
        button_reset = $random;
        #3;
    end
    button_reset = 1;
    #100;
    
    repeat($urandom_range(50,0))
    begin
        button_reset = $random;
        #3;
    end
    button_reset = 0;
end

endmodule
