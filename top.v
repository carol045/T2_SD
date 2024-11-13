`define S_IDLE      3'b000
`define S_COMM_F    3'b001
`define S_WAIT_F    3'b010
`define S_COMM_T    3'b011
`define S_WAIT_T    3'b100
`define S_BUF_EMPTY 3'b101


module top 
(
  input rst, clk, start_f, start_t, stop_f_t, update, 
  input[2:0] prog,
  output[5:0] led, 
  output[7:0] an, dec_ddp,
  output parity
);

reg [2:0] EA, PE;
  
  edge_detector start_f_ed (.clock(clk), .reset(rst), .din(start_f), .rising(start_f_rising));
  edge_detector start_t_ed (.clock(clk), .reset(rst), .din(start_t), .rising(start_t_rising));
  edge_detector stop_f_t_ed (.clock(clk), .reset(rst), .din(stop_f_t), .rising(stop_rising));
  edge_detector update_ed (.clock(clk), .reset(rst), .din(update), .rising(update_rising));

   always @(posedge clock or posedge reset)
    begin  
        if (reset == 1'b1) begin
            EA <= `S_IDLE;
        end else begin
            EA <= PE;
        end
    end
    
    always @(*)
    begin
        case (EA)
          
            `S_IDLE: begin
              if (start_f_rising) begin
                    PE = `S_COMM_F;
              end else if (start_t_rising) begin
                    PE = `S_COMM_T;
              end else begin
                    PE = `S_IDLE;
                 end
              end

          `S_COMM_F: begin
            if (buffer_full) begin
                    PE = `S_WAIT_F;
            end else if (stop_rising) begin
                    PE = `S_BUF_EMPTY;
              end else begin
                    PE = `S_COMM_F;
                 end
              end

          `S_WAIT_F: begin
            if (!buffer_full) begin
                    PE = `S_COMM_F;
            end else if (stop_rising) begin
                    PE = `S_BUF_EMPTY;
              end else begin
                    PE = `S_WAIT_F;
                 end
              end


          `S_COMM_T: begin
            if (buffer_full) begin
                    PE = `S_WAIT_T;
            end else if (stop_rising) begin
                    PE = `S_BUF_EMPTY;
              end else begin
                    PE = `S_COMM_T;
                 end
              end

         `S_WAIT_T: begin
            if (!buffer_full) begin
                    PE = `S_COMM_T;
            end else if (stop_rising) begin
                    PE = `S_BUF_EMPTY;
              end else begin
                    PE = `S_WAIT_T;
                 end
              end

          `S_BUF_EMPTY: begin
            if (buffer_empty && !data_2_valid) begin
                    PE = `S_IDLE;
                end else begin
                    PE = `S_BUF_EMPTY;
                end
            end
          
            default: begin
                PE = `S_IDLE;
            end
        endcase
    end

endmodule