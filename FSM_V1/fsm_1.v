// FSM module
// Group 5

module fsm (
    input wire clk,
    input wire rst,
    input wire A, B, C, D,
    output [1:0] out
);
 
  // Defining State variable   
  localparam S0 = 2'b00,
             S1 = 2'b01,
             S2 = 2'b10,
             S3 = 2'b11;
  
  reg [1:0] state_r, next_state;
  reg [1:0] out_state, out_r;
  reg in_a, in_b, in_c, in_d;

  assign out = out_state;

  // This process contains sequential part of the FSM
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      in_a <= 0;
      in_b <= 0;
      in_c <= 0;
      in_d <= 0;
      state_r <= S0;
      out_r <= 2'b00;
    end else begin
      in_a <= A;
      in_b <= B;
      in_c <= C;
      in_d <= D;  
      state_r <= next_state;
      out_r <= out_state;
    end
  end
  
  // This is combinational of the sequential design, 
  // which contains the logic for next-state
  always @(*) begin
  
    next_state = state_r;  //default next state
    
    case (state_r)
        S0 : begin
             out_state = 2'b00;
             if (in_b == 1'b1 && !(in_c)) begin 
                next_state = S1; 
             end
             else if (in_c == 1'b1 && !(in_b)) begin  
                next_state = S2; 
             end
        end

        S1 : begin
             out_state = 2'b01;
             //next_state = S1;
        end

        S2 : begin
             out_state = 2'b10;
             if (in_b == 1'b1 && !(in_a)) begin 
                next_state = S1; 
             end
             else if (in_a == 1'b1 && !(in_b)) begin  
                next_state = S3; 
             end
        end

        S3 : begin
             out_state = 2'b11;
             if (in_a == 1'b0) begin 
                next_state = S2; 
             end
        end
    endcase
  end 
            
endmodule
