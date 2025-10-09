module procedural_basic;
  bit clk=0;
  always #5 clk = ~clk;
  initial begin
    #20 $display("Simulation done");
    #25 $finish;
  end
endmodule

