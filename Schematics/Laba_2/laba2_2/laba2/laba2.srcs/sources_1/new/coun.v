module counter #(STEP = 1, MODULE = 2)(
 input clk, reset, enable, direction,
 output reg[$clog2(MODULE)-1:0] cnt
);
initial cnt = 0;
always@(posedge clk)
begin
 if (reset)
 cnt <= 0;
 else if (enable)
 cnt <= direction ? (MODULE + cnt - STEP) % MODULE : (cnt + STEP) %
MODULE;
end
endmodule