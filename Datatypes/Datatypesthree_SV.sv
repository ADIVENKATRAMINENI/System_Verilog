// Define enum type
typedef enum {IDLE, BUSY, DONE} state_t;

module enum_typedef;
  // Declare a variable of enum type
  state_t s = IDLE;

  // Initial block to display the enum value
  initial begin
    $display("Initial state: %s", s.name());
    
    // Change states manually to demonstrate
    s = BUSY;
    $display("Next state: %s", s.name());
    
    s = DONE;
    $display("Next state: %s", s.name());
  end
endmodule

