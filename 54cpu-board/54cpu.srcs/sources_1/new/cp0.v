`timescale 1ns / 1ps

module CP0(
    input clk,
    input rst,
    input mfc0, // CPU instruction is Mfc0
    input mtc0, // CPU instruction is Mtc0
    input [31:0]pc,
    input [4:0] Rd, // Specifies Cp0 register
    input [31:0] wdata, // Data from GP register to replace CP0 register
    input exception,
    input eret, // Instruction is ERET (Exception Return)
    input [4:0]cause,
    //input intr,
    output [31:0] rdata, // Data from CP0 register for GP register
    output [31:0] status,
    //output reg timer_int,
    output [31:0]exc_addr // Address for PC at the beginning of an exception
);
    reg [31:0]cp0_reg[31:0];
    integer i;//reset¼ÆÊýÆ÷
    
    always @(posedge clk or posedge rst)
        begin
           if(rst==1'b1)
             for(i=0;i<32;i=i+1)
               cp0_reg[i] <= 32'b0;
           else if(mtc0)
               cp0_reg[Rd] <= wdata;
           else if(exception) begin
               cp0_reg[12] <= status << 5;
               cp0_reg[14] <= pc;//EPC
               cp0_reg[13] <= {24'b0,cause,2'b0};
           end
           else if(eret)
               cp0_reg[12] <= status >> 5;
           else;
        end
        
    assign status   = cp0_reg[12];
    assign rdata    = mfc0? cp0_reg[Rd]:32'hz; 
    assign exc_addr = eret? cp0_reg[14]:32'hz; 
    
endmodule
