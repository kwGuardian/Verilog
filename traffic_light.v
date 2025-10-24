//Moore
module traffic_light_moore (
    input clk,
    input rst,
    output reg red,
    output reg yellow,
    output reg green
);
    typedef enum reg [1:0] {
        RED = 2'b00,
        GREEN = 2'b01,
        YELLOW = 2'b10
    } state_t;

    state_t state, next_state;
    reg [3:0] counter; // dem time

    //FSM
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= RED;
            counter <= 0;
        end else begin
            if (counter == 0) state <= next_state;
            counter <= (counter == 0) ? (
                (next_state == RED) ? 5 :
                (next_state == GREEN) ? 5 : 2
            ) : counter - 1;
        end
    end

    always @(*) begin
        case (state)
            RED:    next_state = (counter == 0) ? GREEN : RED;
            GREEN:  next_state = (counter == 0) ? YELLOW : GREEN;
            YELLOW: next_state = (counter == 0) ? RED : YELLOW;
            default: next_state = RED;
        endcase
    end

    always @(*) begin
        red    = (state == RED);
        yellow = (state == YELLOW);
        green  = (state == GREEN);
    end
endmodule

//Mealy
module traffic_light_mealy (
    input clk,
    input rst,
    output reg red,
    output reg yellow,
    output reg green
);
    typedef enum reg [1:0] {
        S_RED = 2'b00,
        S_GREEN = 2'b01,
        S_YELLOW = 2'b10
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S_RED;
            counter <= 0;
        end else begin
            state <= next_state;
            counter <= (counter == 0) ? (
                (next_state == S_RED) ? 5 :
                (next_state == S_GREEN) ? 5 : 2
            ) : counter - 1;
        end
    end

    always @(*) begin
        case (state)
            S_RED:    next_state = (counter == 0) ? S_GREEN : S_RED;
            S_GREEN:  next_state = (counter == 0) ? S_YELLOW : S_GREEN;
            S_YELLOW: next_state = (counter == 0) ? S_RED : S_YELLOW;
            default:  next_state = S_RED;
        endcase
        red    = (state == S_RED);
        green  = (state == S_GREEN);
        yellow = (state == S_YELLOW);
    end
endmodule

//tb
module tb_tl;
    reg clk, rst;
    wire red, yellow, green;
    traffic_light_moore uut (.clk(clk), .rst(rst), .red(red), .yellow(yellow), .green(green));
    //traffic_light_mealy uut (.clk(clk), .rst(rst), .red(red), .yellow(yellow), .green(green));
    always #1 clk = ~clk;
    initial begin
        $dumpfile("tl.vcd");
        $dumpvars(0, tb_tl);
        clk = 0;
        rst = 1;
        #2 rst = 0;
        #300 $finish;
    end
endmodule
