//====================================================
// Design: 2:1 Multiplexer
//====================================================
`timescale 1ns/1ps

module mux2x1 (
  input  logic a, b, sel,
  output logic y
);


  always_comb begin
    if (sel)
      y = a;
    else
      y = b;
  end

endmodule

