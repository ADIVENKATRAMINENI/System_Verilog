module case_example;
  bit [1:0] sel = 2'b10;
  initial case(sel)
    2'b00: $display("ZERO");
    2'b01: $display("ONE");
    2'b10: $display("TWO");
    default: $display("INVALID");
  endcase
endmodule

