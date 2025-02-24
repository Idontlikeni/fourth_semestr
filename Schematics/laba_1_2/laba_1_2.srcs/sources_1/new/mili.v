`timescale 1ns / 1ps

module mili(
    input clk, a, b, c,
    output reg [1:0] state,
    output reg d
    );
    initial begin
        state = 0;
    end
    always@(posedge clk)
    begin
        case (state)
            2'd0:begin
                if(~c)state <= 2'd2;
                else if(b && c)state <= 2'd3;
                else if(~b && c)state <= 2'd0;
                d <= ~(c & b);
            end
            2'd1:begin
                if(c)state <= 2'd2;
                else if(~b && ~c)state <= 2'd0;
                else if(b && ~c)state <= 2'd1;
                d = (~a & b) | (a & ~b);
            end
            2'd2:begin
                if(~b)state <= 2'd3;
                else if(b)state <= 2'd1;
                d = ~(a & c);
            end
            2'd3:begin
                if(a)state <= 2'd1;
                else if(~a)state <= 2'd0;
                d = b | c;
            end
        endcase
    end
endmodule
