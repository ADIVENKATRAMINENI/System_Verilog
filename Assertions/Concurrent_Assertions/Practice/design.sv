module dut(input logic clk, input logic reset_n,
           input logic req, output logic ack);

  logic [2:0] counter;

  // DUT behavior: generate ACK 3 cycles after REQ
  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      ack <= 0;
      counter <= 0;
    end else begin
      if (req) begin
        if (counter == 3) begin
          ack <= 1;       // after 3 cycles -> this will PASS property within [1:3]
          counter <= 0;
        end else begin
          counter <= counter + 1;
          ack <= 0;
        end
      end else begin
        counter <= 0;
        ack <= 0;
      end
    end
  end
endmodule
