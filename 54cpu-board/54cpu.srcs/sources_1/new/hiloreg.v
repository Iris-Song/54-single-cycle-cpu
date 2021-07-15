`timescale 1ns / 1ps

module hiloreg(
   input clk,
   input reset,
   input ena,
   input  [31:0]data_in,
   output [31:0]data_out
        );
   reg [31:0]data;       
   always @(negedge clk or posedge reset)
       if(reset)
         data <= 32'h00400000;
       else if(ena)
         data <= data_in;
       else;
   assign data_out=data;
endmodule
