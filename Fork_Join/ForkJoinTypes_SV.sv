// File: fork_join_example.sv
module fork_join_example;
  initial begin
    $display("[%0t] Starting fork-join all", $time);
    
    fork
      begin #5 $display("[%0t] Task 1 done", $time); end
      begin #10 $display("[%0t] Task 2 done", $time); end
      begin #15 $display("[%0t] Task 3 done", $time); end
    join
    
    $display("[%0t] After join-all\n", $time);
    
    fork
      begin #5 $display("[%0t] Task A done", $time); end
      begin #10 $display("[%0t] Task B done", $time); end
    join_any
    $display("[%0t] After join_any\n", $time);
    
    fork
      begin #5 $display("[%0t] Task X done", $time); end
      begin #10 $display("[%0t] Task Y done", $time); end
    join_none
    $display("[%0t] After join_none (parallel continues)\n", $time);
    
    #20 $display("[%0t] Simulation End", $time);
  end
endmodule


// ============================================================================
//           TOPIC: fork-join and Process Control in SystemVerilog
// ============================================================================
//
// Purpose of fork-join
//  -----------------------
//  ? 'fork ... join' is used to start multiple parallel threads inside one block.
//  ? Each thread executes independently, allowing concurrent behavior.
//  ? Commonly used in testbenches for:
//      - Parallel stimulus generation
//      - Running monitors & checkers simultaneously
//      - Delays, timeouts, or background activities
//
//  Syntax:
//      fork
//         // parallel threads
//      join           -> Wait for ALL threads to complete
//      join_any       -> Continue after FIRST thread finishes
//      join_none      -> Continue immediately (fire-and-forget)
//
//  Example:
//      fork
//         begin #5 $display("Task 1"); end
//         begin #10 $display("Task 2"); end
//      join   // waits for both
//
// ============================================================================
//  Process Control
//  ------------------
//  Each thread created by 'fork' is an independent process.
//  SystemVerilog provides ways to control these processes.
//
//  ? wait fork
//      -> Suspends execution of current process until ALL forked child processes end.
//      -> Useful when 'join_none' is used but you later want to wait for completion.
//
//      Example:
//          fork
//             begin #5 $display("A"); end
//             begin #10 $display("B"); end
//          join_none       // main process continues immediately
//
//          // do something else here
//          #2 $display("Main continues...");
//
//          wait fork;       // waits until both A and B are finished
//          $display("All forked tasks done");
//
//  ? disable fork
//      -> Terminates ALL active processes created by the current fork.
//      -> Handy for cancelling pending operations or timing out parallel activities.
//
//      Example:
//          fork
//             begin #100 $display("Timeout reached"); end
//             begin
//                 #20 $display("Event occurred");
//                 disable fork;   // kills the timeout thread
//             end
//          join
//
//      Output:
//          [20] Event occurred
//          -> Timeout thread killed before it could print
//
// ============================================================================
// Summary Table
//  ----------------
//  Keyword        | Description / Behavior
//  -------------------------------------------------------------------------
//  join           | Waits for ALL parallel threads to finish
//  join_any       | Waits for FIRST thread to finish
//  join_none      | Continues immediately; threads run in background
//  wait fork      | Wait until all forked threads are done (used with join_none)
//  disable fork   | Kill all threads under current fork
//
// ============================================================================
//
//  ? Key Takeaways:
//  ? Use fork-join to model parallel activity in simulation.
//  ? join/join_any/join_none control synchronization level.
//  ? wait fork pauses until all threads end (safe synchronization).
//  ? disable fork cancels all running child threads.
//  ? Very common in UVM for concurrent components like monitors, drivers, and scoreboards.
//
// ============================================================================
