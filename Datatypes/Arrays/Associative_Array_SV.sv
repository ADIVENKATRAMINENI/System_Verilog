// File: associative_array.sv
module associative_array;
  int assoc[string];
  string key;
  
  initial begin
    assoc["apple"] = 50;
    assoc["banana"] = 30;
    assoc["cherry"] = 70;
    
    foreach (assoc[key])
      $display("Fruit=%s Price=%0d", key, assoc[key]);
    
    if (assoc.exists("banana"))
      $display("Banana exists and price = %0d", assoc["banana"]);
  end
endmodule


/*
Associative arrays are like hash maps in software.
You can access values using custom keys, iterate over them with foreach, check existence, and delete entries.
Very useful in testbenches for storing transaction data, coverage bins, or stimulus values with flexible indexing.
*/
