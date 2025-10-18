class Packet;
  rand bit [7:0] addr;
  rand bit [7:0] data;
  rand bit mode;

  constraint addr_c {
    if (mode) addr < 50;
    else addr > 200;
  }

  function void display();
    $display("MODE=%0b ADDR=%0d DATA=%0d", mode, addr, data);
  endfunction
endclass

module Conditional_tb;
  Packet p = new();
  initial begin
    repeat (5) begin
      p.randomize();
      p.display();
    end
  end
endmodule

