module wrapper 
(
  input rst,              // Reset ativo alto
  input clk_1, clk_2,     // Clock rapido e lento 
  input data_1_en,        // Sinal enable que indica q o dado de entrada é válido
  input [15:0] data_1,    // Dado vindo de Fibonacci ou Timer
  output buffer_empty,    // Flag de controle que indica q o buffer interno está vazio
  output buffer_full,     // Flag de controle que indica q o buffer interno está cheio 
  output data_2_valid,    // Valor consumido é válido
  output [15:0] data_2    // Valor consumido no momento atual gerado por Fibonacci ou Timer
);

endmodule