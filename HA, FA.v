//half adder: Sum = A.B' + A'.B, Cout = A.B
//Gate-level modeling
module HA_gate_level (
    input a,b,
    output S, Cout
)
wire n1, n2, o1, o2;
not N1(n1, a);
not N2(n2, b);
and O1(o1, a, n2);
and O2(o2, n1, b);
or Sum(s, o1, o2);
and Cout(Cout, a, b);
endmodule
//Dataflow / RTL modeling
module HA_rtl (
    input a, b,
    output S, Cout
    };
assign S = a & (~b) | (~a) & b;
assign Cout = a & b;
endmodule
//Behavioral modeling
module HA_behavioral (
    input a, b,
    output reg S, Cout
);
always @(*) begin
assign S = a & (~b) | (~a) & b;
assign Cout = a & b;
end
endmodule
//Testbench
module tb_HA;
reg a, b;
wire S, Cout;
HA_gate_level U1(.a(a), .b(b), .S(s), .Cout(Cout));
//HA_rtl U2(.a(a), .b(b), .S(s), .Cout(Cout));
//HA_behavioral U3(.a(a), .b(b), .S(s), .Cout(Cout));
initial begin
    $monitor("a = %d, b = %d | S = %d, Cout = %d",a b, S, Cout)
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
end
endmodule


//full adder: S = a^b^Cin, Cout = ab + (a ^ b)Cin
//Gate-level modeling
module FA_gate_level (
    input a, b, Cin,
    output S, Cout
);
wire s1, c1, c2;
xor S1(s1, a, b);
xor Sum(S, s1, Cin);
and C1(c1, a ,b);
and C2(C2, s1, Cin);
or Cout(Cout, c1, c2);
endmodule
//Dataflow / RTL modeling
module FA_rtl (
    input a, b, Cin,
    output S, Cout
);
assign S = a^b^Cin;
assign Cout = a & b | (a & b) & Cin;
endmodule
//Behavioral modeling
module FA_behavioral (
    input a, b, Cin,
    output reg S, Cout
);always @(*) begin
    assign S = a ^ b ^ Cin;
    assign Cout = a & nb | (a ^ b) & Cin;
end
endmodule
//Testbench
module tb_FA;
reg a, b, Cin;
wire S, Cout;
FA_gate_level U1(.a(a), .b(b), .Cin(Cin), .S(S), .Cout(Cout));
//FA_rtl U2(.a(a), .b(b), .Cin(Cin), .S(S), .Cout(Cout);
//FA_behavioral U3(.a(a), .b(b), .Cin(Cin), .S(S), .Cout(Cout));
initial begin
    $monitor("a = %d, b = %d, Cin = %d | S = %d, Cout = %d", a, b, Cin, S, Cout);
    a = 0; b = 0; Cin = 0; #10;
    a = 0; b = 0; Cin = 1; #10;
    a = 0; b = 1; Cin = 0; #10;
    a = 0; b = 1; Cin = 1; #10;
    a = 1; b = 0; Cin = 0; #10;
    a = 1; b = 0; Cin = 1; #10;
    a = 1; b = 1; Cin = 0; #10;
    a = 1; b = 1; Cin = 1; #10;
end
endmodule