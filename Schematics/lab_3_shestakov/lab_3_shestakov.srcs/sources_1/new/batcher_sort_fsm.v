`timescale 1ns / 1ps
module batcher_sort_fsm #(
    WIDTH = 8,
    BITS = 4
)(
    input [WIDTH*BITS-1:0] data_in,
    input reset,
    input [3:0] data_count,
    input enable,
    input clk,
    output reg [WIDTH*BITS-1:0] data_out,
    output reg data_out_enable
    );
    
    reg [WIDTH*BITS-1:0] data_out_next;
    reg [1:0] state, next_state;
    reg data_out_enable_next;
    
    
    always @(posedge clk) 
        if (reset) begin
            data_out <= 0;
            data_out_enable <=0;
            state<=0;
        end
        else
            if(enable) begin
                data_out<=data_out_next;
                data_out_enable<=data_out_enable_next;
                state<=next_state;
            end    
    localparam IDLE = 0, SORT = 1, OUT = 2;
    always @*
        begin
            case(state)
                IDLE: next_state = enable ? SORT : IDLE;
                SORT: next_state = OUT;
                OUT: next_state = enable ? OUT : IDLE;
            endcase
        end
    
    always @*
        begin
            case(state)
                IDLE: 
                    begin
                        data_out_next<=data_out;
                        data_out_enable_next<=data_out_enable;
                    end
                SORT: 
                    begin
                        data_out_next<=sort(data_in);
                        data_out_enable_next<=data_out_enable;
                    end
                OUT:
                    begin
                        data_out_next<=data_out;
                        data_out_enable_next<=1;
                    end
              endcase
        end
        
        function [WIDTH*BITS-1:0] sort(
            input [WIDTH*BITS-1:0] data_in
        );
            integer s, t, i, idx;
            reg [BITS-1:0] arr [0:WIDTH-1];
            reg [BITS-1:0] temp;
            reg [3:0] count;
            reg [3:0] count1;
            reg [3:0] j;
            begin
                for (idx = 0; idx < WIDTH; idx = idx + 1)
                    arr[idx] = data_in[BITS*idx +: BITS];

      
                for (s = 2; s <= WIDTH; s = s << 1) begin
                    for (t = s; t > 1; t = t >> 1) begin
                        for (i = 0; i < WIDTH; i = i + 1) begin
                            if (((i & s) == 0 && arr[i] > arr[i ^ (t>>1)]) ||
                                ((i & s) != 0 && arr[i] < arr[i ^ (t>>1)])) begin
                                temp            = arr[i];
                                arr[i]          = arr[i ^ (t>>1)];
                                arr[i ^ (t>>1)] = temp;
                            end
                        end
                    end
                end
           count = WIDTH;
           count1 = 0;
           j = 0;
           for (idx = 0; idx < WIDTH; idx = idx + 1) begin
                if(count == data_count) begin
                    sort[BITS*(count1) +: BITS] = arr[j];
                    j = j+1;
                    count1 = count1+ 1;
               end else begin
                     sort[BITS*(count-1) +: BITS] = 4'b0000;
                     count = count - 1;
                     j = j+1;
              end
           end
        end
        endfunction
        initial begin
            state<=0;
            next_state<=0;
            data_out<=0;
            data_out_enable<=0;
            data_out_next<=0;
            data_out_enable_next<=0;
        end
endmodule
