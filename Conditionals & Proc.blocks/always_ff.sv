module ff_example;
  logic clk, rst, q;
  always #5 clk = ~clk;
  always_ff @(posedge clk or posedge rst)
    if (rst) q <= 0;
    else q <= ~q;
  initial begin
    clk=0; rst=1; #10 rst=0; #30 $finish;
  end
endmodule

