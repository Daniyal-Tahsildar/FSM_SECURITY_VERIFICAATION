`timescale 1 ns / 100 ps

module fsm_tb_2;

logic clk = 0, rst, A, B, C, D;
logic [1:0] out;

logic [1:0] correct_out;
logic [1:0] prev_out;

fsm_2 DUT (.*);

//clock
 initial begin : generate_clock
      while(1)
        #10 clk = ~clk;      
   end

//tests
   initial begin : check_states
     $timeformat(-9, 0, " ns");
//start with reset
     rst = 1'b1;
//assign initial input values     
     A = 1'b0;
     B = 1'b0;
     C = 1'b0;
     D = 1'b0;
     correct_out = 2'b00;
     prev_out = correct_out;
     for( int i=0; i<5; i++)
     @(posedge clk);

//turn off reset
     rst = 1'b0;
     @(posedge clk);
  //Test states, only checks for A and C and not B.
     for(int i = 0; i<50; i++)begin
        prev_out = correct_out;
        rst =1'b0;
        @(posedge clk);
        A = $random;
        B = 1'b0;
        //b !c
        C = $random;

        if(out != correct_out)
        $display("ERROR (time %0t) out = %h instead of %h", $realtime, out, correct_out );
        @(posedge clk);

        if (prev_out == 2'b00 && (C)) begin
            correct_out = 2'b10;
        end
        else if (prev_out == 2'b10 && (A)) begin
            correct_out = 2'b11;
        end
        else if (prev_out == 2'b11 && !(A)) begin
            correct_out = 2'b10;
        end
     end
     
     disable generate_clock;
     $display ("Tests completed");
   end

endmodule