module fibonacci (
  input rst,               // Sinal de reset ativo alto
  input clk,               // Clock de 10 Hz
  input f_en,              // Enable do módulo
  output reg [15:0] f_out, // Saída com o valor atual da sequência
  output reg f_valid       // Indica se o valor de saída é válido
);

reg [15:0] fib1, fib2;

always @(posedge clk or posedge rst) begin
  if (rst) begin
    fib1 <= 16'd0;          // Inicializa o primeiro número de Fibonacci
    fib2 <= 16'd1;          // Inicializa o segundo número de Fibonacci
    f_out <= 16'd0;         // Define a saída inicial como 0
    f_valid <= 1'b0;        // Sinaliza que a saída não é válida inicialmente
  end else if (f_en) begin
    f_out <= fib1;          // Atualiza a saída com o valor atual de fib1
    f_valid <= 1'b1;        // Define o sinal de validade para 1
    fib1 <= fib2;           // Atualiza fib1 com o valor de fib2
    fib2 <= fib1 + fib2;    // Calcula o próximo número de Fibonacci
  end else begin
    f_valid <= 1'b0;        // Quando desativado, sinaliza saída inválida
  end
end

endmodule