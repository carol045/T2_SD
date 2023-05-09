`timescale 1 ns/10 ps

module timer_tb;
    reg rst,
    reg clk,
    reg t_en,
    wire t_valid,
    wire [15:0] t_out

    timer DUT (.rst(rst), .clk(clk), .t_en(t_en), .t_valid(t_valid), .t_out(t_out));
    localparam PERIOD_10Z = 10;

    initial begin
        clock 1'b0;
        forever #(PERIOD/2) clock = ~clock;
    end

    initial begin
        reset = 1'b1;
	    #(PERIOD/2)
	    reset = 1'b0;
    end

    initial begin
        t_en = 1'b0;
        #800
        t_en = 1'b1;
    end

endmodule
