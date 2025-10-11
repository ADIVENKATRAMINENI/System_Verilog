// =============================================================
// 4-bit synchronous up-counter with active-high reset
// =============================================================

`timescale 1ns/1ps
module counter (
  input  logic clk,
  input  logic rst,
  input  logic en,
  output logic [3:0] count
);

  // Sequential logic: counts on posedge of clk
  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      count <= 4'b0000;
    else if (en)
      count <= count + 1;
    else
      count <= count; // hold value
  end

endmodule

