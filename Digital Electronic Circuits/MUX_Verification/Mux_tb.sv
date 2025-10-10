`timescale 1ns/1ps
module mux2x1_tb;

logic a, b, sel, y;

mux2x1 dut(.a(a),.b(b),.sel(sel),.y(y));

initial begin
$timeformat(-9,1,"ns",5);
$monitor("%0t   a=%b   b=%b   sel =%b   y=%b",$time,a,b,sel,y);
$display("TEST TIMEOUT");
$finish;
end

task expect_test(input expects);
if(y!== expects) begin
$display("output should be y=%b not expects=%b",y,expects);
$display("Test Failed");
$finish;
end
endtask

initial begin
a='0;b='0;sel=0;#5 expect_test('0);
a='0;b='1;sel=1;#10 expect_test('0);
a='1;b='0;sel=0;#15 expect_test('0);
a='1;b='1;sel=0;#20 expect_test('1);
a='0;b='1;sel=1;#25 expect_test('0);
a='1;b='0;sel=1;#30 expect_test('1);
a='0;b='0;sel=1;#35 expect_test('0);
a='1;b='1;sel=1;#40 expect_test('1);
end


endmodule

