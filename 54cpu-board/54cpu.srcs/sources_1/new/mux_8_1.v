`timescale 1ns / 1ps

module mux_8_1(
    input [2:0] sel,
    input [31:0] iData0,
    input [31:0] iData1,
    input [31:0] iData2,
    input [31:0] iData3,
    input [31:0] iData4,
    input [31:0] iData5,
    input [31:0] iData6,
    input [31:0] iData7,
    output reg[31:0] oData
    );
    
    always@(*)
      case(sel)
        3'b000: oData = iData0;
        3'b001: oData = iData1;
        3'b010: oData = iData2;
        3'b011: oData = iData3;
        3'b100: oData = iData4;
        3'b101: oData = iData5;
        3'b110: oData = iData6;
        3'b111: oData = iData7;
        default:oData = 32'bz;
      endcase
      
endmodule
