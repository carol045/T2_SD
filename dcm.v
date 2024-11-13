module dcm (
  input rst,               // Reset ativo alto
  input clk,               // Clock de referência de 100 MHz
  input [2:0] prog_in,     // Entrada de programação para o clock lento
  input update,            // Sinal para atualizar o clock lento
  output reg clk_1,        // Clock rápido de 10 Hz
  output reg clk_2,        // Clock lento configurável
  output reg [2:0] prog_out // Saída que reflete a frequência atual do clock lento
);

  reg [22:0] counter_fast;  // Contador para gerar o clock rápido (10 Hz)
  reg [30:0] counter_slow;  // Contador para gerar o clock lento baseado em prog_in
  reg [30:0] slow_divider;  // Divisor atual do clock lento, configurado por prog_in

  // Geração do clock rápido (10 Hz)
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter_fast <= 0;
      clk_1 <= 0;
    end else begin
      if (counter_fast == 5000000 - 1) begin // Divisor para 10 Hz
        clk_1 <= ~clk_1;
        counter_fast <= 0;
      end else begin
        counter_fast <= counter_fast + 1;
      end
    end
  end

  // Seleção do divisor do clock lento com base em prog_in
  always @* begin
    case (prog_in)
      3'b000: slow_divider = 5000000;     // 10 Hz
      3'b001: slow_divider = 10000000;    // 5 Hz
      3'b010: slow_divider = 20000000;    // 2.5 Hz
      3'b011: slow_divider = 40000000;    // 1.25 Hz
      3'b100: slow_divider = 62500000;    // 0.8 Hz
      3'b101: slow_divider = 125000000;   // 0.4 Hz
      3'b110: slow_divider = 250000000;   // 0.2 Hz
      3'b111: slow_divider = 500000000;   // 0.1 Hz (78.125 mHz)
      default: slow_divider = 5000000;    // Fallback para 10 Hz
    endcase
  end

  // Geração do clock lento configurável
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter_slow <= 0;
      clk_2 <= 0;
      prog_out <= 3'b000;
    end else if (update) begin
      prog_out <= prog_in;  // Atualiza prog_out quando update é ativado
      counter_slow <= 0;    // Reinicia o contador
    end else if (counter_slow == slow_divider - 1) begin
      clk_2 <= ~clk_2;
      counter_slow <= 0;
    end else begin
      counter_slow <= counter_slow + 1;
    end
  end

endmodule