module tb;
  logic clk = 0;
  logic reset_n = 0;
  logic req, ack;

  // Clock generation
  always #5 clk = ~clk;

  // Instantiate DUT
  dut u1 (.clk(clk), .reset_n(reset_n), .req(req), .ack(ack));

  //============================================================
  // Property 1 – must get ACK within 1 to 3 cycles (should PASS)
  //============================================================
  property p_req_ack_within_3;
    @(posedge clk) disable iff (!reset_n)
    req |-> ##[1:3] ack;
  endproperty

  assert property (p_req_ack_within_3)
    else $error("❌ FAIL: ACK not received within 3 cycles after REQ at %0t", $time);

  //============================================================
  // Property 2 – must get ACK within 1 to 2 cycles (will FAIL)
  //============================================================
  property p_req_ack_within_2;
    @(posedge clk) disable iff (!reset_n)
    req |-> ##[1:2] ack;
  endproperty

  assert property (p_req_ack_within_2)
    else $error("❌ FAIL: ACK not received within 2 cycles after REQ at %0t", $time);

  //============================================================
  // Stimulus
  //============================================================
  initial begin
    req = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;

    // Generate a few requests
    @(posedge clk) req = 1;
    repeat (5) @(posedge clk);
    req = 0;

    @(posedge clk) req = 1;
    repeat (5) @(posedge clk);
    req = 0;

    #20 $finish;
  end
endmodule