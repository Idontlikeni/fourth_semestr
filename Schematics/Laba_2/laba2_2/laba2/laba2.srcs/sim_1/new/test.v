`timescale 1ns / 1ps
module testbench;
    reg[3:0] SWITCHES = 0;
    reg clk = 0;
    reg button = 0;
    reg button_reset = 0;
    wire[7:0] AN;
    wire[6:0] SEG;
    wire[31:0] NUMBER;
    wire button_signal;
    wire button_signal_en;
    wire reset_signal_en;
    wire reset_signal;
    main cntlr(
        .SWITCHES(SWITCHES),
        .button_in(button),
        .clk(clk),
        .button_reset_in(button_reset),
        .AN(AN),
        .NUMBER(NUMBER),
        .SEG(SEG),
        .button_signal(button_signal),
        .button_signal_en(button_signal_en),
        .reset_signal_en(reset_signal_en),
        .reset_signal(reset_signal)
    );
    always #5 clk = ~clk;
    initial
    begin
        #4000
        $srandom(35000);
        SWITCHES = 4'b0000;
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
        
        SWITCHES = 4'b0001;
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
        
        #4000
        $srandom(35000);
        SWITCHES = 4'b0010;
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
        
        #4000
        $srandom(35000);
        SWITCHES = 4'b0011;
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
        
        #4000
        $srandom(35000);
        SWITCHES = 4'b0100;
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
        
        #4000
        $srandom(35000);
        SWITCHES = 4'b0101;
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
        
        #4000
        $srandom(35000);
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
        
        #4000
        $srandom(35000);
        SWITCHES = 4'b0111;
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
        
        #4000
        $srandom(35000);
        SWITCHES = 4'b1000;
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
        
        #4000
        $srandom(35000);
        SWITCHES = 4'b1000;
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
//        repeat($urandom_range(50,0))
//        begin
//            button_reset = $random;
//            #3;
//        end
//        button_reset = 1;
//        #800;
        
//        repeat($urandom_range(50,0))
//        begin
//            button_reset = $random;
//            #3;
//        end
        button_reset = 0;  
    end
endmodule
