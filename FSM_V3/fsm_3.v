// FSM module
// Group 5

`timescale 1 ns / 100 ps

module fsm_3 (
    input wire clk,
    input wire rst,
    input wire A, B, C, D,
    output [1:0] out
);
 
  // Defining State variable   
parameter S0 = 2'b00,
             S1 = 2'b01,
             S2 = 2'b10,
             S3 = 2'b11;
  
  reg [1:0] state_r, next_state;
  reg [1:0] out_state, out_r;
  

  assign out = out_state;

  // This process contains sequential part of the FSM
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      state_r <=  S0;
      out_r <=  2'b00;
    end else begin
      state_r <= next_state;
      out_r <=  out_state;
    end
  end
  
  // This is combinational of the sequential design, 
  // which contains the logic for next-state
  always @(state_r,A,B,C,D) begin
  
    next_state = state_r;  //default next state
    
    case (state_r)
        S0 : begin
             out_state = 2'b00;
             if (B == 1'b1 && C==1'b0) begin 
                next_state = S1; 
             end
             else if (C == 1'b1 && B==1'b0) begin  
                next_state = S2; 
             end
        end

        S1 : begin
             out_state = 2'b01;
        end

        S2 : begin
             out_state = 2'b10;
             if (B == 1'b1 && !(A)) begin 
                next_state = S1; 
             end
             else if (A == 1'b1 && !(B)) begin  
                next_state = S3; 
             end
        end

        S3 : begin
             out_state = 2'b11;
             if (A == 1'b0) begin 
                next_state = S2; 
             end
        end
		default:begin
				out_state = 2'b00;
				next_state = S0;
				end
    endcase
  end 
            
endmodule
