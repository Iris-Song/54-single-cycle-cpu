`timescale 1ns / 1ps

module pcreg(
   input clk,
   input reset,
   input ena,
   input  [31:0]pc_in,
   output [31:0]pc_out
    );
    
    reg [31:0] pc_reg;
    
    always @(negedge clk or posedge reset)
       if(reset)
         pc_reg <= 32'h00400000;
       else if(ena)
         pc_reg <= pc_in;
       else 
        ;
     assign pc_out=pc_reg;       
endmodule