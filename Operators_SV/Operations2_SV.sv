module bitwise_ops;
  bit [7:0] x = 8'b10101010;
  initial $display("x=%b, ~x=%b, x<<1=%b, x>>1=%b", x, ~x, x<<1, x>>1);
endmodule
