`timescale 1ns/1ns

module dcm_tb;

  // parâmetros do Testbench
  parameter PERIOD = 10;
  parameter RST_PERIOD = PERIOD * 2;
  parameter CLK_PERIOD = PERIOD / 10;
  parameter SIM_TIME = PERIOD * 100;

  // sinais do Testbench
  reg rst;
  reg clk;
  reg [2:0] prog_in;
  reg update;
  wire clk_1;
  wire clk_2;
  wire [2:0] prog_out;

  // instância do DCM
  dcm dcm_inst (
    .rst(rst),
    .clk(clk),
    .prog_in(prog_in),
    .update(update),
    .clk_1(clk_1),
    .clk_2(clk_2),
    .prog_out(prog_out)
  );

  // gerador do clock de referência (100 MHz)
  always #CLK_PERIOD clk = !clk;

  // gerador do sinal de reset (ativo alto)
  initial begin
    rst = 1;
    #RST_PERIOD rst = 0;
  end

  // estímulos para teste do DCM
  initial begin
    // testando clock lento em diferentes modos
    prog_in = 3'b000;
    update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
    prog_in = 3'b001;
    update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
    prog_in = 3'b010;
    update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
    prog_in = 3'b011;
    update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
    prog_in = 3'b100;
    update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
    prog_in = 3'b101;
    update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
    prog_in = 3'b110;
    update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
    prog_in = 3'b111;
    update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
    // testando atualização do clock lento sem mudar o modo
    prog_in = 3'b001;
    update = 1;
    #PERIOD update = 0;
    #PERIOD update = 1;
    #PERIOD update = 0;
    #SIM_TIME;
  end

endmodule

