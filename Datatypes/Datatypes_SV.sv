module datatype_basic;
  bit b1 = 1;
  logic l1 = 0;
  integer i1 = 10;
  real r1 = 3.14;

  initial begin
    $display("bit=%b logic=%b int=%0d real=%0f", b1, l1, i1, r1);
  end
endmodule

