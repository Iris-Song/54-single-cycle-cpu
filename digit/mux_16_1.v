`timescale 1ns / 1ps

module mux_16_1(
    input [3:0] sel,
    input [31:0] iData0,
    input [31:0] iData1,
    input [31:0] iData2,
    input [31:0] iData3,
    input [31:0] iData4,
    input [31:0] iData5,
    input [31:0] iData6,
    input [31:0] iData7,
    input [31:0] iData8,
    input [31:0] iData9,
    input [31:0] iData10,
    input [31:0] iData11,
    input [31:0] iData12,
    input [31:0] iData13,
    input [31:0] iData14,
    input [31:0] iData15,
    output reg[31:0] oData
    );
    
    always@(*)
      case(sel)
        4'b0000: oData = iData0;
        4'b0001: oData = iData1;
        4'b0010: oData = iData2;
        4'b0011: oData = iData3;
        4'b0100: oData = iData4;
        4'b0101: oData = iData5;
        4'b0110: oData = iData6;
        4'b0111: oData = iData7;
        4'b1000: oData = iData8;
        4'b1001: oData = iData9;
        4'b1010: oData = iData10;
        4'b1011: oData = iData11;
        4'b1100: oData = iData12;
        4'b1101: oData = iData13;
        4'b1110: oData = iData14;
        4'b1111: oData = iData15;
        default:oData = 32'bz;
      endcase
      
endmodule
