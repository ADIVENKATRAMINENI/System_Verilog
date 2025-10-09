module assign_ops;
  int a=8;
  initial begin
    a += 4; $display("a=%0d", a);
    a <<= 1; $display("a shifted=%0d", a);
  end
endmodule

