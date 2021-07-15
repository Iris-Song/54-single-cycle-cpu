`timescale 1ns / 1ps

module dmem(
    input clk,
    input dm_ena,  
    input dm_w, //write
    input dm_r, //read
    input [2:0] dm_sel,
    input [31:0] addr,
    input [31:0] dm_in,
    output [31:0] dm_out
    );
    
    reg [31:0] dmem_reg[1023:0]; 
      
    assign dm_out=dm_ena? (dm_r? ((dm_sel==3'b100)?{{24{dmem_reg[addr][7]}},dmem_reg[addr][7:0]}:
                                  (dm_sel==3'b010)?{{16{dmem_reg[addr][7]}},dmem_reg[addr][15:0]}:
                                  (dm_sel==3'b001)?{dmem_reg[addr]}:32'bz): 32'h0):
                                 // (dm_sel==3'b101)?{24'b0,dmem_reg[addr][7:0]}:
                                 // (dm_sel==3'b110)?{16'b0,dmem_reg[addr][15:0]}:32'h0):
                                  32'hz;
              
    
    always@(posedge clk or negedge dm_ena)
      if(dm_ena && dm_w) 
          if(dm_sel==3'b100)
              dmem_reg[addr][7:0] <= dm_in[7:0];
          else if(dm_sel==3'b010)
              dmem_reg[addr][15:0] <= dm_in[15:0];
          else if(dm_sel==3'b001)
              dmem_reg[addr] <= dm_in;
          else ;
      else;
      
endmodule
    

