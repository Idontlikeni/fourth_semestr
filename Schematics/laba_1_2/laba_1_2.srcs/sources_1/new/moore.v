`timescale 1ns / 1ps

module moore#
(parameter
S0_0=3'b000, S0_1=3'b001,
S1_0=3'b010, S1_1=3'b011,
S2_0=3'b100, S2_1=3'b101,
S3_0=3'b110, S3_1=3'b111)
(input clk,a,b,c,
output reg [2:0] state,
output reg d);
    reg [2:0] new_state=0;
    initial begin
        state = 0;
    end
    always @(posedge clk)
    begin
        state = new_state;
        casex(state)
            3'bxx1: d = 1'b1;
            3'bxx0: d = 1'b0;
        endcase
        casex({state,a,b,c})
            {S0_0, 3'b000}, {S0_1, 3'b000}: new_state = S2_1;
            {S0_0, 3'b001}, {S0_1, 3'b001}: new_state = S0_1;
            {S0_0, 3'b010}, {S0_1, 3'b010}: new_state = S2_1;
            {S0_0, 3'b011}, {S0_1, 3'b011}: new_state = S3_0;
            {S0_0, 3'b100}, {S0_1, 3'b100}: new_state = S2_1;
            {S0_0, 3'b101}, {S0_1, 3'b101}: new_state = S0_1;
            {S0_0, 3'b110}, {S0_1, 3'b110}: new_state = S2_1;
            {S0_0, 3'b111}, {S0_1, 3'b111}: new_state = S3_0;
            {S1_0, 3'b000}, {S1_1, 3'b000}: new_state = S0_0;
            {S1_0, 3'b001}, {S1_1, 3'b001}: new_state = S2_0;
            {S1_0, 3'b010}, {S1_1, 3'b010}: new_state = S1_1;
            {S1_0, 3'b011}, {S1_1, 3'b011}: new_state = S2_1;
            {S1_0, 3'b100}, {S1_1, 3'b100}: new_state = S0_1;
            {S1_0, 3'b101}, {S1_1, 3'b101}: new_state = S2_1;
            {S1_0, 3'b110}, {S1_1, 3'b110}: new_state = S1_0;
            {S1_0, 3'b111}, {S1_1, 3'b111}: new_state = S2_0;
            {S2_0, 3'b000}, {S2_1, 3'b000}: new_state = S3_1;
            {S2_0, 3'b001}, {S2_1, 3'b001}: new_state = S3_1;
            {S2_0, 3'b010}, {S2_1, 3'b010}: new_state = S1_1;
            {S2_0, 3'b011}, {S2_1, 3'b011}: new_state = S1_1;
            {S2_0, 3'b100}, {S2_1, 3'b100}: new_state = S3_1;
            {S2_0, 3'b101}, {S2_1, 3'b101}: new_state = S3_0;
            {S2_0, 3'b110}, {S2_1, 3'b110}: new_state = S1_1;
            {S2_0, 3'b111}, {S2_1, 3'b111}: new_state = S1_0;
            {S3_0, 3'b000}, {S3_1, 3'b000}: new_state = S0_0;
            {S3_0, 3'b001}, {S3_1, 3'b001}: new_state = S0_1;
            {S3_0, 3'b010}, {S3_1, 3'b010}: new_state = S0_1;
            {S3_0, 3'b011}, {S3_1, 3'b011}: new_state = S0_1;
            {S3_0, 3'b100}, {S3_1, 3'b100}: new_state = S1_0;
            {S3_0, 3'b101}, {S3_1, 3'b101}: new_state = S1_1;
            {S3_0, 3'b110}, {S3_1, 3'b110}: new_state = S1_1;
            {S3_0, 3'b111}, {S3_1, 3'b111}: new_state = S1_1;
        endcase
    end
endmodule