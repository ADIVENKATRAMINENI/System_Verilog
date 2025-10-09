module comb_example;
  logic a, b, y;
  always_comb y = a & b;
  initial begin
    a=1; b=0; #1 $display("y=%b", y);
  end
endmodule

