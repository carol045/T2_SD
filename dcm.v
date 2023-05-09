module dcm 
(
    input rst,
    input clk,
    input [2:0] prog_in, // indica qual frequencia o clk lento deve operar
    input update,        // indica que o clk lento deve ser atualizado para a freq indicada pelo prog_in 
    output reg clk_1,    // clk rapido gerado em 10Hz
    output reg clk_2,    //clk lento gerado q opera entre 10Hz e 78.125MHz
    output reg [2:0] prog_out //sinal de programacao de saida da freq do clk lento 
);

  reg [2:0] mode;

  always @(posedge clk or posedge rst) begin
    if(rst) begin
      //zerar tudo, estartar as coisas
    end
    else begin
      case (mode)
        3'b000 :
        3'b001 :
        3'b010 :
        3'b011 :
        3'b100 :
        3'b101 :
        3'b110 :
        default : clk_2 = xxxxxx;
      endcase
    end
  end

endmodule