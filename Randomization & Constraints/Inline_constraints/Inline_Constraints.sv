class Packet;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  constraint addr_c { addr < 100; }
  constraint data_c { data inside {[10:50]}; }

  function void display();
    $display("ADDR=%0d DATA=%0d", addr, data);
  endfunction
endclass

module Inline_tb;
  Packet p = new();
  initial begin
    p.randomize(); $display("Normal:"); p.display();

    p.addr_c.constraint_mode(0);
    p.randomize(); $display("Addr constraint OFF:"); p.display();

    p.randomize() with { addr > 200; data < 20; };
    $display("Inline constraint:"); p.display();
  end
endmodule

