class packet;
bit [7:0] addr;
bit [7:0] data;

function void display();
	$display("ADDR=%0h DATA=%0h",addr,data);
endfunction
endclass

module class_tb;

initial begin
packet p1,p2;
p1=new();
p2=new();
p1.addr=8'hAF;
p2.addr=8'hBC;
p1.data=8'hE0;
p2.data=8'h39;

$display("-------Packet 1------");
p1.display();


$display("-------Packet 1------");
p2.display();


#10 $finish;
end

endmodule







/* =============================================================================
BASIC CLASS & OBJECT PRACTICE

1. What this does:
   - Creates a class called Packet with 2 fields: addr, data
   - Adds a method display() to print those fields
   - In testbench, creates 2 Packet objects using new()
   - Assigns values and prints them using display()

2. Key Points:
   - Class defines structure; object stores real data
   - Handles (p1, p2) point to actual objects in memory
   - new() allocates memory for the object
   - p1.display() calls that object?s method

3. What you?ll see in QuestaSim:
   - The $display() lines print addr and data values
   - Simulation ends after 10 time units

4. Commands:
   vlog packet_tb.sv
   vsim tb     ----- Loads the compiled top-level module or testbench for simulation.
   run -all    ----- Execute the simulation from time 0 to the end.
============================================================================= */






/*
================================================================================
SystemVerilog Classes & OOP Notes
================================================================================

1. Class Fundamentals
--------------------------------------------------------------------------------
1. What is a class?
- A class is a template to define objects with:
  * Data members (variables)
  * Methods (functions/tasks)
- Classes are **used to model reusable entities** (transactions, packets, etc.)

2. Object Handles and Instantiation
- **Handle** = reference to object in memory
- Object is created in heap using `new()` constructor

Example:
class Packet;
  int id;
  function new(int id_in);
    id = id_in;
  endfunction
endclass

module tb;
  Packet p1;               // handle declaration
  initial begin
    p1 = new(10);          // object creation
    $display("Packet ID=%0d", p1.id);
  end
endmodule

Doubt clarification: 
- `Packet p1 = new(10);` first allocates memory and then calls constructor `new(10)`.
- If you declare multiple objects like `p1` and `p2`, they are created **sequentially**, one after another.  

--------------------------------------------------------------------------------
3. Accessing data in objects
- Direct child object can access:
  * Inherited parent fields
  * Its own child fields

Example:
class Packet;
  bit [7:0] addr;
  bit [7:0] data;
  function void display();
    $display("ADDR=%0h DATA=%0h", addr, data);
  endfunction
endclass

module tb;
  Packet p1, p2;
  initial begin
    p1 = new(); p2 = new();
    p1.addr = 8'hA5; p1.data = 8'h3C;
    p2.addr = 8'hB2; p2.data = 8'h55;
    p1.display(); p2.display();
  end
endmodule


4. Multiple Objects
   - Example: 
       Packet p1 = new(1,"Data1");
       Packet p2 = new(2,"Data2");
   - **Sequential Execution:** Each `new()` runs one after another, not concurrently.  

--> `super.new()` ? Constructor Chaining
- Used in child class to call parent constructor for initialization.



--> `this` Keyword
- Refers to the **current object?s instance**.
- Example: `this.id = id_in;`

--------------------------------------------------------------------------------
2. Encapsulation & Inheritance
--------------------------------------------------------------------------------
1. Encapsulation
- Hides internal data; access via functions/tasks
- Protects internal data using `protected` or `local`.
- Access through **setter/getter functions**.
- Protects data from accidental modification

Example:
class BaseTrans;
  protected bit [7:0] addr;
  function void set_addr(bit [7:0] a); addr = a; endfunction
  function bit [7:0] get_addr(); return addr; endfunction
endclass

+----------------+
| Transaction    |
|----------------|
| protected addr |
| set_addr()     |
| get_addr()     |
+----------------+

- DV Use: Transaction fields (addr, data) are modified safely.

2. Inheritance
- Child class reuses parent members/methods
- Child can **add extra fields** and **override methods**
- Accessing child data **directly through child object** works without `virtual`(if using **child object**, both parent and child data are accessible.)
- `virtual` is only needed when **using a base class handle** pointing to child.(**Virtual not required** for direct child objects.)

Example:
class WriteTrans extends BaseTrans;
  bit [7:0] data;
  function void display();
    $display("Write Addr=%0h Data=%0h", get_addr(), data);
  endfunction
endclass



Transaction (Parent)
+ addr, set/get_addr()
       |
       v
WriteTrans (Child)
+ data, display()



3. Constructor Chaining
   - Use `super.new()` in child constructor to call parent constructor.
   - Ensures proper initialization of parent members.

--------------------------------------------------------------------------------
3. Polymorphism & Virtual Methods
--------------------------------------------------------------------------------
1. Polymorphism
- Base handle can point to multiple child objects
- Enables dynamic runtime behavior

2. Virtual function
- Declared in parent with `virtual`.
- **Purpose:** Ensure child?s overridden function executes when called via base handle.
- Without `virtual`, base handle always calls base method (static binding).

Example:
virtual class Transaction;
  virtual function void display(); endfunction
endclass

class ReadTrans extends Transaction;
  function void display(); $display("Read Transaction"); endfunction
endclass

class WriteTrans extends Transaction;
  function void display(); $display("Write Transaction"); endfunction
endclass

module tb;
  Transaction t; // base handle
  initial begin
    t = new ReadTrans(); t.display();   // prints Read Transaction
    t = new WriteTrans(); t.display();  // prints Write Transaction
  end
endmodule


Base Handle (Transaction)
      |
      |---> ReadTrans.display()
      |---> WriteTrans.display()


Doubt clarification:
- Base handle cannot access child-specific fields **directly**
- Use **virtual functions** to access child behavior through base handle.
- Direct child object: access parent + child fields, no virtual needed.
- Base handle ? child object: **virtual needed** to call child methods and access child data dynamically.


3. Summary Table
| Concept        | What it Means                          | Example                                  | DV Benefit                                      |
|----------------|--------------------------------------|------------------------------------------|------------------------------------------------|
| Encapsulation  | Protect internal data                 | protected addr + set/get functions      | Safe modification of transaction fields       |
| Inheritance    | Reuse parent code in child classes   | WriteTrans extends BaseTrans            | Reduces code duplication                       |
| Polymorphism   | Base handle calls child methods      | Transaction t = new ReadTrans()         | One handle can manage multiple transaction types dynamically |

--------------------------------------------------------------------------------
Doubt Clarifications / Notes
--------------------------------------------------------------------------------
1. Object Creation & Handles:
- Declaration alone does NOT allocate memory:
  Packet p1; // handle only
- Memory allocation + constructor:
  p1 = new(10);
- Control goes directly to constructor.


2. Sequence of creation:
- Multiple objects are created sequentially, not concurrently.


3. Accessing child data:
- Child object: addr (inherited) + data (child) accessible
- Base handle: cannot access child data directly ? use virtual functions


4. Virtual functions:
- Required **only for base handles** pointing to child objects
- Ensures correct child method runs at runtime (polymorphism)
- Without virtual: base handle calls **base method only**
- Non-virtual ? compile-time binding ? base method always executes via base handle.
- Virtual ? runtime binding ? child?s overridden method executes via base handle.


5. Encapsulation vs Inheritance vs Polymorphism
- Encapsulation ? protect data, controlled access.
- Inheritance ? reuse parent fields/methods, extend child with extra fields.
- Polymorphism ? base handle dynamically executes child methods (requires virtual).

---------------------------------------------------------------------------
Tips for DV Practice
-------------------
- Always calculate expected values from DUT spec.
- Use tasks/functions for self-checking.
- Base handles + virtual functions ? scalable testbench.
- Encapsulation ensures transaction fields are protected.
- Inheritance avoids redundant code for multiple transaction types.
- Polymorphism enables generic sequences for multiple child types.

================================================================================
SystemVerilog Classes & OOP - FAQ Notes
===========================================================================

1. Do `new()` calls run concurrently?
   - NO. Each `new()` call executes **sequentially** in simulation.
   - When you write:
       Packet p1 = new(1,"Data1");
       Packet p2 = new(2,"Data2");
     - `p1` constructor runs first, completes allocation, then `p2` runs.
   - There is no automatic concurrency unless you explicitly spawn processes.


2. How to access child data without virtual functions?
   - If you have a **child object** directly, you can access both parent and child fields freely.
   - Example:
       WriteTrans w = new();
       w.addr = 8'hA5;  // inherited from parent
       w.data = 8'h3C;  // child-specific
       w.display();      // accesses both fields
   - ? Virtual functions are NOT needed here.


3. Why use virtual functions?
   - Required when you use a **base class handle** to point to a child object.
   - Without `virtual`, calling a method via base handle always executes the **base class version**.
   - Example:
       BaseTrans b;
       b = new WriteTrans();
       b.display(); // Without virtual ? calls BaseTrans.display()
   - Declaring `display()` as `virtual` ensures the **child's overridden function executes**.


4. Base handle storing multiple transaction types
   - In DV, sequences often store multiple transaction objects in an array of base handles.
   - Example:
       Transaction t[10];
       t[0] = new ReadTrans();
       t[1] = new WriteTrans();
   - To call the correct child method dynamically:
       foreach(t[i]) t[i].display();  // display must be virtual
   - ? This allows **generic testbench sequences** to work for different transaction types using a single base handle.

===========================================================================
Key Takeaways
- Direct child object ? full access, virtual not needed.
- Base handle ? child object ? virtual required for runtime binding.
- `new()` calls are sequential, constructors run in order.
- Virtual functions + base handles = scalable and reusable DV sequences.
===========================================================================*/

/*
=========================================================================================

4 ? STATIC MEMBERS, COPYING & INTEGRATION
-----------------------------------------------------------------------------------------
Static Variables
- Belong to the **class**, not the object.
- Shared among all instances.
- Useful for counting objects or maintaining common data.
- Example:
    static int count = 0;
    function new(); count++; endfunction

Object Copying
- Classes are **reference types** (handles, not values).
- Two types of copying:
    1. Shallow Copy ? Copies only handle, both point to same object.
    2. Deep Copy ? Creates new object, copies contents manually.

Shallow Copy Example:
    t2 = t1;
    // Both point to same memory; modifying one affects the other.

Deep Copy Example:
    function Transaction copy();
        Transaction t2 = new();
        t2.data = this.data;
        return t2;
    endfunction
    // Creates a new independent object with same content.

Shallow vs Deep (Quick Table)
| Type | What is Copied | Independent? | Use Case |
|-------|----------------|--------------|-----------|
| Shallow | Handle only | ? No | Temporary sharing |
| Deep | Entire object | ? Yes | Scoreboard snapshots |


Integration Example:
- Driver creates Transaction objects using `new()`, randomizes them,
  and drives to DUT.
- Static counter keeps track of total transactions created.
- Combines multiple classes: Transaction + Driver + Testbench.

Example:
    class Transaction;
      rand bit [3:0] addr, data;
      static int count = 0;
      function new(); count++; endfunction
    endclass

    class Driver;
      Transaction t;
      function void drive();
        t = new();
        assert(t.randomize());
        $display("Driving: addr=%0h data=%0h", t.addr, t.data);
      endfunction
    endclass

=========================================================================================

ADVANCED INSIGHTS
-----------------------------------------------------------------------------------------
Use virtual base classes when multiple derived types share same interface.
Always prefer `protected` data + getter/setter for safer access.
Use `deep copy()` when transactions are passed between monitor & scoreboard.
Static variables are excellent for tracking created objects or coverage items.
Polymorphism is key to UVM ? everything (driver, monitor, agent) works via base handles.

=========================================================================================
END OF NOTES
=========================================================================================
*/