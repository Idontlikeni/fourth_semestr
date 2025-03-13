module XNOR_2(input A, B, output Y);
  assign Y = ~(A ^ B);
endmodule