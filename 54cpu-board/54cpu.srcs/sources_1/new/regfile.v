`timescale 1ns / 1ps

module regfile(
   input clk,    
   input rst,
   input ena,    
   input we, 
   input  [4:0] raddr1,  
   input  [4:0] raddr2, 
   input  [4:0] waddr,   
   input  [31:0] wdata, 
   output [31:0] rdata1,
   output [31:0] rdata2
);

   reg [31:0]array_reg[31:0];
   integer i=0;
   assign rdata1 = ena?array_reg[raddr1]:32'bz;
   assign rdata2 = ena?array_reg[raddr2]:32'bz;
   
   always @(posedge clk or posedge rst)
    begin
       if(rst==1'b1)
         for(i=0;i<32;i=i+1)
           array_reg[i] <= 32'b0;
       else if ((ena&we)&& (waddr != 0))
         array_reg[waddr] <= wdata;
       else;
    end
    
endmodule

