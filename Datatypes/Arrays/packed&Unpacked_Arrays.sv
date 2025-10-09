// File: array_example.sv
module array_example;
  bit [7:0] packed_a;         // packed array ? 8-bit vector
  bit unpacked_a[0:7];        // unpacked array ? 8 elements of 1-bit each
  integer i;

  initial begin
    packed_a = 8'b1010_1100;
    $display("packed_a = %b", packed_a);
    
    // Assign values individually in unpacked array
    for (i=0; i<8; i++) unpacked_a[i] = i%2;
    $write("unpacked_a = ");
    for (i=0; i<8; i++) $write("%0b", unpacked_a[i]);
    $write("\n");
  end
endmodule


/*
a) packed_a
Declared as bit [7:0].
This is a packed array, meaning all bits are together in a single 8-bit vector.
Think of it like: packed_a = {b7, b6, b5, b4, b3, b2, b1, b0}.
Packed arrays are contiguous bits, can be sliced, used in arithmetic, concatenation, and bitwise operations.

b) unpacked_a
Declared as bit unpacked_a[0:7];
This is an unpacked array, which is like an array of 8 independent 1-bit elements.
Each element can be accessed individually: unpacked_a[0], unpacked_a[1], ....
Unpacked arrays cannot be directly used for arithmetic like packed arrays. They are mostly for storage and loops.

c) integer i
A loop variable for iterating over the unpacked array.
*/