module dm 
(
  input rst, clk,
  input[2:0] prog, 
  input[1:0] modulee,
  input[15:0] data_2,
  output[7:0] an, dec_ddp
);

  wire[5:0] d1,d2,d3,d4,d5,d6,d7,d8;

  assign d1 = {1'b1, data_2[3:0], 1'b0};
  assign d2 = {1'b1, data_2[7:4], 1'b0};
  assign d3 = {1'b1, data_2[11:8], 1'b0};
  assign d4 = {1'b1, data_2[15:12], 1'b0};
  assign d5 = 6'b0;
  assign d6 = {1'b1, 2'b0, modulee, 1'b0};
  assign d7 = 6'b0;
  assign d8 = {1'b1, 1'b0, prog, 1'b0};

  dspl_drv_NexysA7 display_driver (
    .clock(clk),
    .reset(rst),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .d8(d8),
    .an(an),
    .dec_cat(dec_ddp)
    );


endmodule