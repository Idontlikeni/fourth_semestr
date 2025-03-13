`timescale 1ns / 1ps
module testbench;
    reg[3:0] SWITCHES = 0;
    reg clk = 0;
    reg button = 0;
    reg button_reset = 0;
    wire[7:0] AN;
    wire[6:0] SEG;
    wire[31:0] NUMBER;
    wire button_en;
    wire button_reset_en;
    main cntlr(
        .SWITCHES(SWITCHES),
        .button_in(button),
        .clk(clk),
        .button_reset_in(button_reset),
        .AN(AN),
        .NUMBER(NUMBER),
        .SEG(SEG),
        .button_en(button_en),
        .button_reset_en(button_reset_en)
    );
    always #5 clk = ~clk;
    initial
    begin
        #4000
        $srandom(35000);
        SWITCHES = 4'b1111;
        repeat($urandom_range(50,0))
        begin
            button = $random;
            #3;
        end
        button = 1;
        #1000;
        
        repeat($urandom_range(50,0))
        begin
            button = $random;
            #3;
        end
        button = 0;
        #8000;
        
        SWITCHES = 4'b0110;
        repeat($urandom_range(50,0))
        begin
            button = $random;
            #3;
        end
        button = 1;
        #1000;
        
        repeat($urandom_range(50,0))
        begin
            button = $random;
            #3;
        end
        button = 0;
        #8000;
        repeat($urandom_range(50,0))
        begin
            button_reset = $random;
            #3;
        end
        button_reset = 1;
        #800;
        
        repeat($urandom_range(50,0))
        begin
            button_reset = $random;
            #3;
        end
        button_reset = 0;  
    end
endmodule
