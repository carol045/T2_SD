module dcm (
  input rst,         // reset ativo alto
  input clk,         // clock de referência (100 MHz)
  input [2:0] prog_in,  // entrada de programação (3 bits)
  input update,      // sinal para atualizar o clock lento
  output reg clk_1,  // clock rápido (10 Hz)
  output reg clk_2,  // clock lento (10 Hz a 78.125 mHz)
  output reg [2:0] prog_out // saída de programação (3 bits)
);

  reg [2:0] mode = 0;  // modo de operação do clock lento (inicialmente 0)

  // gerador do clock rápido (10 Hz)
  always @(posedge clk) begin
    if (rst) begin
      clk_1 <= 0;
    end else begin
      clk_1 <= !clk_1;
    end
  end

  // gerador do clock lento (10 Hz a 78.125 mHz)
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      clk_2 <= 0;
    end else begin
      case (mode)
        0: clk_2 <= #(100_000_000/10) 1'b0; // 10 Hz
        1: clk_2 <= #(100_000_000/5) 1'b0;  // 20 Hz
        2: clk_2 <= #(100_000_000/2.5) 1'b0; // 40 Hz
        3: clk_2 <= #(100_000_000/1.25) 1'b0; // 80 Hz
        4: clk_2 <= #(100_000_000/625) 1'b0; // 160 Hz
        5: clk_2 <= #(100_000_000/312.5) 1'b0; // 320 Hz
        6: clk_2 <= #(100_000_000/156.25) 1'b0; // 640 Hz
        7: clk_2 <= #(100_000_000/78.125) 1'b0; // 1280 Hz
        default: clk_2 <= #(100_000_000/10) 1'b0; // fallback to 10 Hz
      endcase
    end
  end

  // atualização do modo de operação do clock lento
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      mode <= 0;
      prog_out <= 3'b000;
    end else begin
      if (update) begin
        mode <= prog_in;
        prog_out <= prog_in;
      end
    end
  end

endmodule
