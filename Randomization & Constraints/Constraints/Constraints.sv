class Packet;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  constraint addr_c { addr < 100; }
  constraint data_c { data inside {[10:50]}; }

  function void display();
    $display("ADDR=%0d DATA=%0d", addr, data);
  endfunction
endclass

module constraints_tb;
  Packet p = new();
  initial begin
    repeat (5) begin
      p.randomize();
      p.display();
    end
  end
endmodule

