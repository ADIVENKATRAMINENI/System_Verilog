typedef struct {
  bit [3:0] id;
  logic     valid;
  int       data;
} pkt_t;

module struct_typedef;
  pkt_t p1 = '{id:4'hA, valid:1, data:123};
  initial $display("Packet: id=%h valid=%b data=%0d", p1.id, p1.valid, p1.data);
endmodule

