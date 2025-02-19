`timescale 1ns / 1ps

module mili(
    input clk, a, b, c,
    output reg [1:0] state
    );
    initial
        state = 0;
    always@(posedge clk)
    begin
        case (state)
            2'd0:begin
                if(c)state <= 2'd1;
                else if(~c)state <= 2'd3;
            end
            2'd1:begin
                if(a)state <= 2'd1;
                else if(~a && ~c)state <= 2'd2;
                else if(~a && c)state <= 2'd0;
            end
            2'd2:begin
                if(~c)state <= 2'd3;
                else if(c)state <= 2'd1;
            end
            2'd3:begin
                if(~c)state <= 2'd2;
                else if(b && c)state <= 2'd0;
                else if(~b && c)state <= 2'd3;
            end
        endcase
    end
endmodule
