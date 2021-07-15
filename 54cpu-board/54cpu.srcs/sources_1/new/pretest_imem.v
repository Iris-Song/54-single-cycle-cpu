`timescale 1ns / 1ps

module pretest_imem(
    input im_r, //read ena
    input [9:0] addr,
    output reg [31:0] data_out
    );
    
     reg [31:0]mem [1023:0];    
     
    initial 
      begin
       $readmemh("C:/Users/1234/Desktop/test/hex/35_jalr.hex.txt",mem);
      end
      
    always @ (*)
       if(!im_r) 
         data_out <= 32'hz;
       else 
         data_out <= mem[addr];
      
   endmodule
