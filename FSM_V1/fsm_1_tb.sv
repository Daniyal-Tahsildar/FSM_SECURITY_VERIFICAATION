`timescale 1 ns / 100 ps

module tb;

logic clk = 0, rst, A, B, C, D;
logic [1:0] out;

logic [1:0] correct_out;

fsm DUT (.*);

//clock
 initial begin : generate_clock
      while(1)
        #10 clk = ~clk;      
   end

//tests
   initial begin
     $timeformat(-9, 0, " ns");
//start with reset
     rst = 1'b1;
//assign initial input values     
     A= 1'b0;
     B= 1'b0;
     C= 1'b0;
     D= 1'b0;
     correct_out = 2'b00;
     for( int i=0; i<5; i++)
     @(posedge clk);

//turn off reset
     rst = 1'b0;
     @(posedge clk);
     
//test for S0
     @(posedge clk);

//test for S2
     C = 1'b1;
     @(posedge clk);
     correct_out = 2'b10;
     for( int i=0; i<5; i++)
     @(posedge clk);

//test for S3
     A = 1'b1;
     @(posedge clk);
     correct_out = 2'b11;
     for( int i=0; i<5; i++)
     @(posedge clk);

//test for S3 to S2 teansition
     A = 1'b0;
     @(posedge clk);
     correct_out = 2'b10;
     for( int i=0; i<5; i++)
     @(posedge clk);

//test for S2 to S1 transition
     B = 1'b1;
     @(posedge clk);
     correct_out = 2'b01;
     for( int i=0; i<5; i++)
     @(posedge clk);

//test for S1 remaning unchanged 
     A= 1'b1;
     B= 1'b1;
     C= 1'b1;
     D= 1'b1;
     @(posedge clk);
     correct_out = 2'b01;
     for( int i=0; i<5; i++)
     @(posedge clk);

//reset to S0
    correct_out = 2'b00;
    @(posedge clk);
     rst = 1'b1;
     A= 1'b0;
     B= 1'b0;
     C= 1'b0;
     D= 1'b0;
     
     for( int i=0; i<5; i++)
     @(posedge clk);

     rst = 1'b0;
     @(posedge clk);

//test for S0 to S1 transition  
     B = 1'b1;
     @(posedge clk);
     correct_out = 2'b01;
     for( int i=0; i<5; i++)
     @(posedge clk);

     A= 1'b1;
     B= 1'b1;
     C= 1'b1;
     D= 1'b1;
     @(posedge clk);
     correct_out = 2'b01;
     for( int i=0; i<5; i++)
     @(posedge clk);

     if(out != correct_out)
     $display("ERROR (time %0t) out = %h instead of %h", $realtime, out, correct_out );

     disable generate_clock;
     $display ("Tests completed");

   end

endmodule