module timer(
    input rst,
    input clk,
    input t_en,
    output reg t_valid,
    output reg [15:0] t_out
);

reg [15:0] count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        t_valid <= 0;
        t_out <= 0;
    end
    else begin
        if (t_en) begin
            count <= count + 1;
            t_valid <= 1;
            t_out <= count[15:0];
        end
        else begin
            t_valid <= 0;
            t_out <= 0;
        end
    end
end

endmodule