`timescale 1ns / 1ps

module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
    );
    
    wire [31:0] imm;
    wire [31:0]im_addr;
    wire [31:0] Rt;
    wire [31:0] alu_r;
    wire [31:0]dm_addr;
    wire dm_ena;
    wire dm_w;
    wire dm_r;
    wire [31:0] dm_data;
    wire [2:0] dm_sel;
    
    assign inst = imm;
    assign im_addr = pc- 32'h00400000;
    assign dm_addr = alu_r-32'h10010000;
    imem imem(im_addr[12:2],imm);
    
    //pretest_imem imem(1'b1,im_addr[11:2],imm);

    cpu sccpu (clk_in,reset,imm,dm_data, //input
                Rt,alu_r,pc,dm_ena,dm_w,dm_r,dm_sel); //output

    dmem dmem_uut (clk_in,dm_ena,dm_w,dm_r,dm_sel,
                dm_addr,Rt,dm_data);   
    
endmodule

