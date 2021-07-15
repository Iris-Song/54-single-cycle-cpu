`define ALU_addu                4'b0000
`define ALU_add                 4'b0010
`define ALU_subu                4'b0001
`define ALU_sub                 4'b0011
`define ALU_and                 4'b0100
`define ALU_or                  4'b0101
`define ALU_xor                 4'b0110
`define ALU_nor                 4'b0111
`define ALU_lui                 4'b1000
`define ALU_slt                 4'b1011
`define ALU_sltu                4'b1010
`define ALU_sra                 4'b1100
`define ALU_sll                 4'b1110
`define ALU_srl                 4'b1101

module alu(
     input [31:0] a,        
     input [31:0] b,        
     input [3:0]  aluc,    //control
     output[31:0] r,    //result
     output zero,
     output carry,
     output negative,
     output overflow
     );
    
    reg [32:0] result;
    wire signed [31:0] sa=a,sb=b;
    
    always@(*)begin
       case(aluc)
          `ALU_addu:
              result = a+b;
          `ALU_add: 
              result = sa+sb;
          `ALU_subu: 
              result = a-b;
          `ALU_sub: 
              result = sa-sb;
          `ALU_and: 
              result = a&b;
          `ALU_or: 
              result = a|b;
          `ALU_xor: 
              result = a^b;
          `ALU_nor: 
              result = ~(a|b);
          `ALU_lui:
              result = {b[15:0], 16'b0};
          `ALU_slt: 
              result = sa<sb? 1:0;
          `ALU_sltu: 
              result = a<b? 1:0;
          `ALU_sra: begin
              if (a==0)
               {result[31:0],result[32]} = {b,1'b0};
              else 
               {result[31:0],result[32]} = sb>>>(a-1);
           end
          `ALU_srl: begin
              if(a==0) 
               {result[31:0],result[32]} = {b,1'b0};
              else 
               {result[31:0],result[32]} = b>>(a-1);
           end
         `ALU_sll: 
              result = b<<a;
         default:
              result = a+b;
        endcase
    end
    
    assign r = result[31:0];
    assign carry = result[32]; 
    assign zero = (r==32'b0) ?1'b1:1'b0;
    assign negative = result[31];
    assign overflow = result[32];
    
endmodule