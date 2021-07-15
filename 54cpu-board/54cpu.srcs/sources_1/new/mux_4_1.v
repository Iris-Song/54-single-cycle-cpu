`timescale 1ns / 1ps

module mux_4_1(
    input [1:0] sel,
    input [31:0] iData0,
    input [31:0] iData1,
    input [31:0] iData2,
    input [31:0] iData3,
    output reg[31:0] oData
    );
    
    always@(*)
      case(sel)
        2'b00: oData = iData0;
        2'b01: oData = iData1;
        2'b10: oData = iData2;
        2'b11: oData = iData3;
        default:oData = 32'bz;
      endcase
      
endmodule
