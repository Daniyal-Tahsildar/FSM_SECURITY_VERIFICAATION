`timescale 1 ns / 100 ps

module fsm_tb_3;

// total tests to run 
localparam RUN_TESTS = 1000;

logic clk = 0, rst, A, B, C, D;
logic [1:0] out;

logic [1:0] next_out;
logic [1:0] current_out;

//signals to count passed and failed tests
int passed, failed;

fsm_3 DUT (.*);

  //clock
  initial begin : generate_clock
    while(1)
      #10 clk = ~clk;      
  end

  //tests
  initial begin : check_states
     $timeformat(-9, 0, " ns");

     passed = 0;
     failed = 0;

     //start with reset
     rst = 1'b1;
     
     //assign initial input values     
     A = 1'b0;
     B = 1'b0;
     C = 1'b0;
     D = 1'b0;
     //signals to verify output states
     next_out = 2'b00;
     current_out = next_out;
     
     for( int i=0; i<5; i++)
       @(posedge clk);

     //turn off reset
     rst = 1'b0;
     @(posedge clk);
  
  //Assign random inputs
     for(int i = 0; i<RUN_TESTS; i++)begin
      rst = 1'b0;
//check if state is S1
//if it is, reset to S0 to check other states
      if (current_out == 2'b01)begin
          next_out = 2'b00;
          current_out = next_out;
          @(posedge clk);
          rst = 1'b1;
          @(posedge clk);
        end
// assign random inputs for A,C, and D
        current_out = next_out;
        @(posedge clk);
        A = $random;
        C = $random;
        D = $random;
// Assign B whenever A and C is 0 to avoid clashes
// this is done to make sure only one input changes at a given time,
// when there are multiple options available for a state transition         
        B = !C & !A;

// check outputs for correctness
        @(negedge clk);
        if(out != next_out) begin
          $display("ERROR (time %0t) out = %h instead of %h", $realtime, out, next_out );
          failed ++;
        end
        else begin
          passed ++;
        end

// test states to assign next output
          if (current_out == 2'b00 && (B)) begin 
              next_out = 2'b01;
          end
          else if (current_out == 2'b00 && (C)) begin
              next_out = 2'b10;
          end
          else if (current_out == 2'b10 && (B)) begin
              next_out = 2'b01;
          end
          else if (current_out == 2'b10 && (A)) begin
              next_out = 2'b11;
          end
          else if (current_out == 2'b11 && !(A)) begin
              next_out = 2'b10;
          end
     end
     disable generate_clock;
     $display ("Tests completed : %0d passed, %0d failed", passed, failed);

   end
 
endmodule
