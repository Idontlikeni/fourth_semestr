`timescale 1ns / 1ps

module tb_batcher_sort_fsm;
    // Parameters from DUT
    parameter WIDTH = 8;
    parameter BITS  = 4;

    // Clock period
    localparam CLK_PERIOD = 10;

    // Testbench signals
    reg  [WIDTH*BITS-1:0] data_in;
    reg                   reset;
    reg                   enable;
    reg                   clk;
    wire [WIDTH*BITS-1:0] data_out;
    wire                  data_out_enable;

    // Instantiate the DUT
    batcher_sort_fsm #(
        .WIDTH(WIDTH),
        .BITS(BITS)
    ) uut (
        .data_in(data_in),
        .reset(reset),
        .enable(enable),
        .clk(clk),
        .data_out(data_out),
        .data_out_enable(data_out_enable)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize inputs
        reset  = 1;
        enable = 0;
        data_in = {WIDTH*BITS{1'b0}};

        // Apply reset
        #(CLK_PERIOD);
        reset = 0;
        #(CLK_PERIOD);

        // Test vector 1
        data_in = {4'd5, 4'd2, 4'd15, 4'd0, 4'd7, 4'd9, 4'd1, 4'd3};
        enable = 1;
        $display("Applying data_in = %h", data_in);

        // Wait for sorting and output
        #(3*CLK_PERIOD);
        enable = 0;

        // Check output
        if (data_out_enable) begin
            $display("Sorted output = %h", data_out);
        end else begin
            $display("No valid output");
        end

        // Finish simulation
        #(2*CLK_PERIOD);
        reset = 1;
        #(CLK_PERIOD);
        reset = 0;
        #(2*CLK_PERIOD);
        
         data_in = {4'd8, 4'd11, 4'd13, 4'd4, 4'd5, 4'd1, 4'd2, 4'd3};
         enable = 1;
        #(3*CLK_PERIOD);
        enable = 0;
        $finish;
    end

    // Monitor
    initial begin
        $monitor("At time %0t: state_changed, data_out_enable=%b, data_out=%h", $time, data_out_enable, data_out);
    end

endmodule