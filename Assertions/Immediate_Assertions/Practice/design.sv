// Code your design here
module design_ex(input logic clk, reqA, reqB, in);
  always @(posedge clk) begin
    assert (reqA || reqB)
      else $error("Assertion failed: Both reqA and reqB are low at time %0t", $time);
    assert (in == 0)
      else $warning("Warning: in != 0 at time %0t", $time);
  end
endmodule