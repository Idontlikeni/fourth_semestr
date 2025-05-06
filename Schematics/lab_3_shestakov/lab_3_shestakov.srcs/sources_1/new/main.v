`timescale 1ns / 1ps
module main(
input [3:0] SWITCHES,
input button_in, clk, button_reset_in,
output reg error_led,
output reg non_error_led,
output [7:0] AN,
output [6:0] SEG,

/*
output reg [31:0] NUMBER,
output wire button_signal_en, reset_signal_en,button_signal,reset_signal,
*/
output reg [7:0] LEDS
);
wire button_signal_en, reset_signal_en,button_signal,reset_signal;
wire clk_div;
reg[7:0] AN_MASK = 8'b11111111;
reg flag = 0;
reg enable = 0;
reg is_data_last = 0;
reg [31:0] NUMBER;
reg [4*8-1:0] data_in = 0;
wire [4*8-1:0] data_out;
reg [3:0] count_in = 0;
reg [3:0] data_last = 0;
reg [31:0] error_code = 0;
wire data_out_enable;
reg [1:0] flag1 = 0;
reg [3:0] n = 0; //колличество значений
initial begin
NUMBER <= 0;
end
filtercon #(128) dbnc(
.clk(clk),
.in_signal(button_in),
.clock_enable(1'b1),
.out_signal(button_signal),
.out_signal_enable(button_signal_en));
filtercon #(128) dbnc_reset(
.clk(clk),
.in_signal(button_reset_in),
.clock_enable(1'b1),
.out_signal(reset_signal),
.out_signal_enable(reset_signal_en));
clk_divider #(1024) div(
.clk(clk),
.clk_div(clk_div));
SevenSegmentLED led(
.AN_MASK(AN_MASK),
.NUMBER(NUMBER),
.clk(clk_div),
.RESET(reset_signal),
.AN(AN),
.SEG(SEG));
batcher_sort_fsm #(8,4)uut(
    .data_count(n),
    .data_in(data_in),
    .reset(reset_signal),
    .enable(enable),
    .clk(clk),
    .data_out(data_out),
    .data_out_enable(data_out_enable)
);
integer i;
always@(posedge clk)
    begin
        if (reset_signal)
            begin
                NUMBER <= 0;
                AN_MASK <= 8'b11111111;
                error_led <=0;
                n<=4'd0;
                data_last<=0;
                is_data_last<=0;
                flag<=0;
                enable<=0;
                LEDS<=8'b00000000;
                count_in<=0;
                data_in<= 0;
                flag1<=0;
                non_error_led<=0;
                error_code<=0;
            end
        else
            if(!error_led) begin
            if (button_signal_en)
                begin
                    if(flag == 0)
                        begin
                            flag<=1;
                            n <= SWITCHES;
                            if (SWITCHES > 8) begin
                                error_led <=1;
                                error_code <= 32'h88888888;
                            end
                            else if(SWITCHES == 0) begin
                                error_led <=1;
                                error_code <= 32'h77777777;
                            end
                            else begin
                            is_data_last <= 1;
                            data_last<=SWITCHES;
                            end
                        end
                    else
                        begin
                            if(count_in == n) begin
                                if(n <8) begin
//                                      for (i = 0; i < (8 - n); i = i + 1) begin
//                                        data_in = {data_in[27:0], 4'b1111}; // дополняем максимальным значением
//                                      end
                                    data_in = pad_data(data_in, n);
                                end
                                is_data_last <= 0;
                                enable <= 1'b1;
                            end
                            else 
                                begin
                                    data_in <= {data_in[27:0], SWITCHES};
                                    count_in <= count_in + 1;
                                    LEDS <= {LEDS[6:0], 1'b1};
                                    is_data_last <= 1;
                                    data_last<=SWITCHES;
                                end
                        end
                        
                    /*NUMBER <= {NUMBER[27:0], SWITCHES};
                    AN_MASK <= {AN_MASK[6:0], 1'b0};*/
                end
                 if (is_data_last) begin
                        NUMBER<=data_last;
                        AN_MASK <= ~8'b00000001;
                    end 
                    else if(data_out_enable) begin
                        non_error_led<=1;
                        NUMBER <= data_out;
                        if (flag1 == 0) begin
                            AN_MASK <= 8'b11111111;
                            flag1 = flag1 +1;
                        end
                        else if(flag1 == 1) begin
                            AN_MASK<= AN_MASK << n; 
                            flag1 = flag1 +1;
                        end
                    end
               end else begin
                    NUMBER <= error_code;
                    AN_MASK<=  ~8'b11111111;
               end
    end
function [31:0] pad_data;
    input [31:0] raw_data;
    input [3:0] n;
    reg [31:0] padding;
    begin
        case (n)
            0: padding = {8{4'b1111}};
            1: padding = {7{4'b1111}};
            2: padding = {6{4'b1111}};
            3: padding = {5{4'b1111}};
            4: padding = {4{4'b1111}};
            5: padding = {3{4'b1111}};
            6: padding = {2{4'b1111}};
            7: padding = {1{4'b1111}};
            8: padding = 32'b0;
            default: padding = 32'b0;
        endcase

        // Сдвигаем исходные данные влево на (8 - n)*4 бит
        pad_data = (raw_data << ((8 - n) * 4)) | padding;
    end
endfunction
    initial begin
        LEDS <= 0;
        error_led<=0;
        non_error_led<=0;
    end
endmodule
