`timescale 1ns / 1ps
module testbench2;
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
    
//    clk <= 0;
//    reset <= 1;
//    R_I <= 0;
//    dataIn <= 0;
    
//    #30;    
//    reset <= 0;
//    dataIn <= 4'b0101;
//    R_I <= 1;
//    #30; dataIn <= 4'b0111; 
//    #20; dataIn <= 4'b0011; 
//    #20; dataIn <= 4'b0110; 
//    #20; dataIn <= 4'b0001; 
//    #20; dataIn <= 4'b0010; 
//    #100;
//    reset <= 1;
//    R_I <= 0;
    
    initial
    begin
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
    end
endmodule
