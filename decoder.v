//Gate-level modeling
module decoder_2to4_gate_level (
    input a, b,
    output [3:0] y
);
wire na, nb;
not NA(na, a);
not NB(nb, b);
and Y0(y[0], na, nb);
and Y1(y[1], na, b);
and Y2(y[2], a, nb);
and Y3(y[3], a, b);
endmodule
//Dataflow / RTL modeling
module decoder_2to4_rtl (
    input a, b,
    output [3:0] y
);
assign y[0] = ~a & ~b;
assign y[1] = ~a & b;
assign y[2] = a & ~b;
assign y[3] = a & b;
endmodule
//Behavioral modeling
module decoder_2to4_behavioral (
    input a, b,
    output reg [3:0] y
);
always @(*) begin
    case({a,B})
        2'b00: y = 4'b0001;
        2'b01: y = 4'b0010;
        2'b10: y = 4'b0100;
        2'b11: y = 4'b1000;
        default y = 4'b0000;
    endcase
end
endmodule
//Testbench for decoder
module tb_decoder_2to4;
reg a, b;
wire [3:0] y;
decoder_2to4_gate_level U1(.a(a), .b(b), .y(y));
//decoder_2to4_rtl U2(.a(a), .b(b), .y(y));
//decoder_2to4_behavioral U3(.a(a), .b(b), .y(y));
initial begin
    $monitor("time = %t, a = %d, b = %d | y = %", $time, a, b, y);
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
end
endmodule