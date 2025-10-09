// File: dynamic_array.sv
module dynamic_array;
  int static_a[5] = '{1,2,3,4,5};
  int dynamic_a[];
  integer i;

  initial begin
    dynamic_a = new[3];         // allocate 3 elements
    dynamic_a = '{10,20,30};
    $display("Static Array:");
    foreach (static_a[i]) $write("%0d ", static_a[i]);
    $display("\nDynamic Array:");
    foreach (dynamic_a[i]) $write("%0d ", dynamic_a[i]);
    
    dynamic_a = new[5](dynamic_a); // resize and copy old contents
    $display("\nAfter resize:");
    foreach (dynamic_a[i]) $write("%0d ", dynamic_a[i]);
    $display("");
  end
endmodule


/*
a) static_a
Static array ? size is fixed at compile time (5 elements).
Initialized using array literal: '{1,2,3,4,5}.
Each element is accessible using static_a[0] ? static_a[4].
Cannot change the size after declaration.


b) dynamic_a
Dynamic array ? size is not fixed at compile time.
Declared as int dynamic_a[]; ? just the type, no size yet.
Size will be allocated at runtime using new[].

c) integer i
Loop variable used for foreach.
*/