`timescale 1ns / 1ps

module pcreg(
   input clk,
   input reset,
   input ena,
   input  [31:0]pc_in,
   output reg [31:0]pc_out
    );
    
    reg [31:0] pc_reg;
    
    always @(negedge clk or posedge reset)
       if(reset)
         pc_out <= 32'h00400000;
       else if(ena)
         pc_out <= pc_in;
       else 
         pc_out <= pc_out;
            
endmodule