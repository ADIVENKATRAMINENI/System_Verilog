module ternary_example;
  int a=5, b=10, max;
  initial begin
    max = (a>b)? a:b;
    $display("Max = %0d", max);
  end
endmodule

