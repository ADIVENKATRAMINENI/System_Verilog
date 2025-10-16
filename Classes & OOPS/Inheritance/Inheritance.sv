class Packet;
bit [7:0] addr;
bit [7:0] data;

  // Constructor: called automatically on new()
function new(bit [7:0] addr_in=8'h00, bit [7:0] data_in=8'h00);
addr=addr_in;
data=data_in;
endfunction

function void display();
    $display("Packet: ADDR = %0h, DATA = %0h", addr, data);
endfunction
endclass

// Child Class: WritePacket (inherits from Packet)
class Writepacket extends Packet;
bit write_enable; // extra feature in child class

function new(bit [7:0] addr_in=8'h00, bit [7:0] data_in=8'h00, int we_enable=1'b0);
super.new(addr_in,data_in);
write_enable=we_enable;
endfunction

function void display();
$display("%0t  WritePacket:ADDR:%0h  DATA:%0h   Write_enable:%0b",$time,addr,data,write_enable);
endfunction
endclass



module Inheritance_tb;
Writepacket W1,W2;

initial begin
W1=new(8'ha8,8'he7,1'b1);
W2=new(8'hc4,8'hd2,1'b0);

W1.display();
W2.display();
#10 $finish;

end

endmodule















// =============================================================
// INHERITANCE + CONSTRUCTOR CHAINING
// =============================================================
//
// INHERITANCE Concept 
// -------------------------------------------------------------
// 1. The 'WritePacket' class EXTENDS the 'Packet' class.
//    ? This means WritePacket inherits all data and functions
//      from Packet (addr, data, display(), etc.).
//
// 2. We add a new field in child: write_enable.
//
// 3. We OVERRIDE the display() function to include write_enable.
//
// 4. In SystemVerilog, when a child class extends a parent class,
//    the child does NOT automatically initialize parent variables.
//    We must call the parent constructor using "super.new()".
//
// -------------------------------------------------------------
// Constructor Chaining Concept
// -------------------------------------------------------------
// - When you create a WritePacket object using:
//       WritePacket wp = new(8'hA5, 8'h3C, 1);
//
//   The control flow is like this:
//       -> Calls child constructor: WritePacket.new(a, d, we)
//       -> Inside it, calls parent constructor: super.new(a, d)
//       -> Parent constructor initializes addr and data
//       -> Back to child: initializes write_enable
//
// -------------------------------------------------------------
// Why do we write super.new(a, d); instead of super.new(addr, data)?
//
// ? Explanation:
// - The parameters 'a' and 'd' are passed into the child constructor
//   (these are the incoming arguments when we do new(8'hA5, 8'h3C, 1)).
//
// - At the moment the constructor runs, the child class?s 'addr' and
//   'data' variables are still UNINITIALIZED (they have X or 0).
//
// - So, if we call super.new(addr, data), we would be passing default
//   values (0 or X) to the parent constructor.
//
// - Instead, by using super.new(a, d):
//     ? we pass the actual arguments (8'hA5, 8'h3C)
//     ? the parent constructor uses these to initialize addr & data.

//Summary Table:
//
//   super.new(a, d);     ? Correct ? sends real constructor arguments
//   super.new(addr, data); ? Wrong ? sends uninitialized internal vars
//
// -------------------------------------------------------------
// In Short
// - "super" means "call my parent class".
// - "super.new(...)" means "run my parent class constructor".
// - We use 'a' and 'd' because they are actual argument values,
//   while 'addr' and 'data' are class variables not yet assigned.
// =============================================================
