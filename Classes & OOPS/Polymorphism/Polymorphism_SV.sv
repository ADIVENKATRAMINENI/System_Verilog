class Transaction;
  // Declare send() as virtual ? allows runtime override behavior
  virtual function void send();
    $display("Base Transaction: Generic send()");
  endfunction
endclass

class ReadTransaction extends Transaction;
  function void send();
    $display("ReadTransaction: Performing READ operation");
  endfunction
endclass

class WriteTransaction extends Transaction;
  function void send();
    $display("WriteTransaction: Performing WRITE operation");
  endfunction
endclass

module tb;
  // Base class handle
  Transaction t;

  initial begin
    // Point to a ReadTransaction object
    t = new ReadTransaction();
#5;
    t.send(); 
#5;// ? Calls ReadTransaction.send()

    // Now point to a WriteTransaction object
    t = new WriteTransaction();
#5;
    t.send(); 
#5;// ? Calls WriteTransaction.send()

    $display("[%0t] Testbench finished.", $time);

    $finish;
  end
endmodule







// ============================================================================
//SystemVerilog OOP - Polymorphism & Virtual Methods (DV Notes)
// ============================================================================
// Concepts Covered:
//   - Virtual Functions
//   - Method Overriding
//   - Base Handle & Dynamic Binding
//   - Polymorphism in DV (UVM-style)
//
// ----------------------------------------------------------------------------
// What is Polymorphism?
// ----------------------------------------------------------------------------
// ? "One interface, multiple behaviors."
//   It means a single base class handle can point to many different child
//   class objects, and call the correct function at runtime.
//
//   Example in words:
//     Transaction t;
//     t = new ReadTransaction();   ? Calls ReadTransaction.send()
//     t = new WriteTransaction();  ? Calls WriteTransaction.send()
//
// ----------------------------------------------------------------------------
// Why Use 'virtual' Keyword?
// ----------------------------------------------------------------------------
//   - If a function is NOT declared virtual ? SystemVerilog binds it at
//     compile time (static binding). The base version is always called.
//
//   - If declared as 'virtual' ? SystemVerilog waits until runtime to check
//     which object type (child or base) the handle points to. This enables
//     "dynamic binding" or "runtime polymorphism".
//
// ----------------------------------------------------------------------------
// Base vs. Child Functions
// ----------------------------------------------------------------------------
//   - Base class provides the general interface (example: send()).
//   - Child class overrides that function to perform specialized behavior.
//
//   For instance:
//     Base:    Transaction ? send() = "Generic send"
//     Child 1: ReadTransaction ? send() = "Performing READ"
//     Child 2: WriteTransaction ? send() = "Performing WRITE"
//
// ----------------------------------------------------------------------------
// super() vs. this()
// ----------------------------------------------------------------------------
//   - 'super' ? Refers to parent class members/functions.
//   - 'this'  ? Refers to current class members/functions.
//
// ----------------------------------------------------------------------------
// Typical Use Cases:
// ----------------------------------------------------------------------------
//   In UVM or DV testbenches:
//     - A driver works with a base 'Transaction' handle.
//     - Depending on the test scenario, the same driver sends either
//       a ReadTransaction or WriteTransaction without changing its code.
//     - Polymorphism makes the testbench reusable and scalable.
//
// ----------------------------------------------------------------------------
//Common Doubts Explained
// ----------------------------------------------------------------------------
// Q1: Why do we need 'virtual'? Can't we just override directly?
//     ? You can override, but without 'virtual', SystemVerilog won?t call
//       the child version when using a base handle. It will always call
//       the base version (static binding).
//
// Q2: Why call send() through a base handle and not directly on each child?
//     ? Because in DV we write reusable components (drivers, monitors, etc.)
//       that work on generic 'Transaction' handles. Using polymorphism, they
//       automatically adapt to the object type.
//
// Q3: How does SystemVerilog know which send() to execute?
//     ? During runtime, the simulator checks what the base handle currently
//       points to and calls that class?s implementation.
//
// ----------------------------------------------------------------------------
// ? Summary
// ----------------------------------------------------------------------------
//   - 'virtual' allows runtime function resolution.
//   - Same handle ? different behaviors depending on actual object.
//   - Core concept behind UVM?s polymorphic structure (e.g., sequences, items).
// ============================================================================

