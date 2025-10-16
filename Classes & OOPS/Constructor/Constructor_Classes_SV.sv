class packet;

bit [7:0] addr;
bit [7:0] data;

function new(bit [7:0] addr_in=8'h00, bit [7:0] data_in=8'h00);
addr=addr_in;
data=data_in;
endfunction

function void display();
$display("ADDR=%0h   DATA=%0h",addr,data);
endfunction

endclass


module constructor_tb;

initial begin
packet p1,p2;
p1=new(8'hB8,8'hAE);
p2=new(8'h53,8'hF9);

$display("----------Packet 1-----------");
p1.display();
$display("----------Packet 2-----------");
p2.display();
#20 $finish;

end
endmodule






/*
================================================================================
Packet Class: Constructor & Object Handles
================================================================================

1. Class Definition
- Packet class has two fields: addr[7:0] and data[7:0].
- Methods:
    * new(bit [7:0] addr_in, bit [7:0] data_in) ? constructor
    * display() ? prints current field values

--------------------------------------------------------------------------------
2. Constructor: new()
- Special function in SystemVerilog; called automatically **when object is created**.
- Initializes object fields (addr, data) with provided arguments.
- Example:
    p1 = new(8'hA5, 8'h3C);
  * SystemVerilog **automatically calls the constructor** inside Packet class.
  * Arguments (8'hA5, 8'h3C) are passed to constructor parameters (addr_in, data_in).
- Key point: **Only `new()` is treated as a constructor**.
  * Even if other functions exist in the class (display(), reset(), etc.), `new(...)` always routes to the constructor.
  * You do not need to call display() or any other function to initialize the object.

--------------------------------------------------------------------------------
3. Object Handles
- p1, p2 are object handles (references to Packet objects).
- Memory for objects is allocated when `new()` is called.
- Example:
    p1 = new(8'hA5, 8'h3C);
    p2 = new(8'hB2, 8'h55);
- Each handle points to its own instance in memory.

--------------------------------------------------------------------------------
4. display() Method
- Regular method to print object?s current field values.
- Must be **called explicitly**:
    p1.display();
- Arguments are **not passed automatically**; it uses object?s internal fields set by constructor.

--------------------------------------------------------------------------------
5. Key Notes / Doubts:
- Q: Can `new(8'hA5, 8'h3C)` go to display() instead?  
  A: No. SystemVerilog always routes `new(...)` to the constructor. Other functions run only when explicitly called.
- Q: What if multiple functions exist in the class?  
  A: Safe. `new(...)` **always calls the constructor**. Other methods do not interfere.
- Q: Why use constructor instead of assigning fields manually?  
  A: Constructor ensures **automatic initialization** when creating object. Reduces errors, improves readability, follows professional DV style.
- Analogy: 
  * `new()` ? buying a pre-assembled toy (automatic setup)
  * display()/reset() ? inspecting or manipulating the toy (must be called explicitly)

--------------------------------------------------------------------------------
6. Practice
- Always use constructors to initialize objects.
- Keep object fields private if needed (later: encapsulation).
- Use methods like display() for logging or checking values.
- Object handles separate reference from memory (important when creating multiple objects).

================================================================================
End of Notes
================================================================================
*/
