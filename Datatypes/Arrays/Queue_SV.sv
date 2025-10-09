
// File: queue_example.sv
module queue_example;
  int q[$] = {1,2,3,4};
  int val;
  
  initial begin
    $display("Initial Queue: %p", q);
    q.push_front(0);
    q.push_back(5);
    $display("After push_front/back: %p", q);
    
    q.insert(3, 99);
    $display("After insert: %p", q);
    
    val = q.pop_front();
    $display("Pop front (%0d): %p", val, q);
    
    val = q.pop_back();
    $display("Pop back (%0d): %p", val, q);
    
    q.delete(2);
    $display("After delete index 2: %p", q);
  end
endmodule

/*
Queues are like dynamic arrays with special operations for adding/removing elements at both ends.
Very flexible for testbenches, FIFO/LIFO buffers, or transaction lists.
Supports iteration, insertion, deletion, push/pop?much easier than manually managing dynamic arrays.
*/