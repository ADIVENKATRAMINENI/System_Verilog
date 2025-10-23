// Code your testbench here
// or browse Examples
module tb;
  logic clk = 0;
  logic reqA, reqB, in;

  // clock generation
  always #5 clk = ~clk;

  // DUT instantiation
  design_ex dut (.clk(clk), .reqA(reqA), .reqB(reqB), .in(in));

  // Stimulus
  initial begin
    // initial values
    reqA = 0; reqB = 0; in = 0;
    repeat (2) @(posedge clk);

    // Cause first assertion failure
    reqA = 0; reqB = 0; in = 0;  // both low → should trigger error
    @(posedge clk);

    // Fix request but violate 'in' condition
    reqA = 1; reqB = 0; in = 1;  // in=1 → should trigger warning
    @(posedge clk);

    // All good case
    reqA = 1; reqB = 0; in = 0;
    @(posedge clk);

    #10 $finish;
  end
endmodule