//Gate-level modeling
module logic_gate_level (
    input a,b,
    output and_out, or_out, not_out, nand_out, nor_out, xor_out
);
    and AND(and_out, a, b);
    or OR(or_out, a, b);
    not NOT(not_out, a);
    not NAND(nand_out, and_out);
    not NOR(nor_out, or_out);
    wire n1, n2; not N1(n1, a); not N2(n2, b);
    wire a1, a2; and A1(a1, n1, b); and A2(a2, a, n2);
    or XOR(xor_out, a1, a2);
endmodule

//Dataflow / RTL modeling
module logic_gate_rtl (
    input a,b,
    output and_out, or_out, not_out, nand_out, nor_out, xor_out
);
    assign and_out = a & b;
    assign or_out = a | b;
    assign not_out = ~a;
    assign nand_out = ~(a & n);
    assign nor_out = ~(a | b);
    assign xor_out = a & (~b) | (~a) & b;
endmodule

//Behavioral modeling
module logic_gate_behavioral (
    input a,b,
    output reg and_out, or_out, not_out, nand_out, nor_out, xor_out
);
    always @(*) begin
        and_out = a & b;
        or_out = a | b;
        not_out = ~a;
        nand_out = ~(a & b);
        nor_out = ~( a | b);
        xor_out = a & (~b) | (~a) & b;
    end
endmodule

//Testbench
module tb_logic_gate;
    reg a, b;
    wire and_out, or_out, not_out, nand_out, nor_out, xor_out;

    logic_gate_level U1 (.a(a), .b(b), .and_out(and_out), .or_out(or_out), .not_out(not_out), .nand_out(nand_out), .nor_out(nor_out), .xor_out(xor_out));
    //logic_gate_rtl U1 (.a(a), .b(b), .and_out(and_out), .or_out(or_out), .not_out(not_out), .nand_out(nand_out), .nor_out(nor_out), .xor_out(xor_out));
    //logic_gate_behavioral U1 (.a(a), .b(b), .and_out(and_out), .or_out(or_out), .not_out(not_out), .nand_out(nand_out), .nor_out(nor_out), .xor_out(xor_out));

    initial begin
        $monitor("a=%b b=%b | AND=%b OR=%b NOT=%b NAND=%b NOR=%b XOR=%b", a, b, and_out, or_out, not_out, nand_out, nor_out, xor_out);
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end
endmodule
