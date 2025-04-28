`timescale 1ns / 1ps

module test;

reg clk_write;
reg clk_read;
reg read;
reg write;
reg[3:0] to_input;
initial clk_write = 0;
initial clk_read = 0;

integer clk_write_timming = 20;
always #clk_write_timming clk_write <= ~clk_write;

integer clk_read_timming = 5;
always #clk_read_timming clk_read <= ~clk_read;


wire [3:0] data_out;
wire full, empty, valid;

fifo_two_clock uut
(
    .data_in(to_input),
    .clk_write(clk_write),
    .clk_read(clk_read),
    .read_mode(read),
    .write_mode(write),
    .enable(1),
    .reset(0),
    
    .data_out(data_out),
    .full(full),
    .empty(empty),
    .valid(valid)
    
);

always #(clk_write_timming*2)
    if(!full && write) 
        to_input = to_input + 1;

initial
begin
    to_input = 1;
    read = 0;
    write = 1;
    #100
    read = 1;
    write = 1;
    #360
    read = 1;
    write = 0;
    #300
    
    $stop;
end

endmodule
