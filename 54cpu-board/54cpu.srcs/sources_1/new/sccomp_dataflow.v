`timescale 1ns / 1ps

module sccomp_dataflow(
    input clk_in,
    input reset,
    //output [31:0] inst,
    //output [31:0] pc
    input [15:0] sw,
    output [7:0] o_seg,
    output [7:0] o_sel 
    );
    
    wire [31:0] inst;
    wire [31:0] pc;
    
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
    
    wire seg7_cs,switch_cs;
    
    assign inst = imm;
    assign im_addr = pc- 32'h00400000;
    assign dm_addr = alu_r-32'h10010000;
    imem imem(im_addr[12:2],imm);
    
    
    //pretest_imem imem(1'b1,im_addr[11:2],imm);
     reg [22:0] cnt;
                      always @ (posedge clk_in)
                       if (reset)
                         cnt <= 0;
                       else
                         cnt <= cnt + 1'b1;
wire clk = cnt[22]; 

    cpu sccpu (clk_in,reset,imm,dm_data, //input
                Rt,alu_r,pc,dm_ena,dm_w,dm_r,dm_sel); //output

    dmem dmem_uut (clk_in,dm_ena,dm_w,dm_r,dm_sel,
                dm_addr,Rt,dm_data); 
    
                  
//    sw_mem_sel sw_mem_uut(
//            .switch_cs(switch_cs),
//            .sw(sw),
//            .data(dm_data),
//            .data_sel(alu_r)
//                    );
                    
//     io_sel io_sel_uut(
//            .addr(alu_r), 
//            .cs(dm_ena), 
//            .sig_w(dm_w), 
//            .sig_r(~dm_w), 
//            .seg7_cs(seg7_cs), 
//            .switch_cs(switch_cs)
//                      );   
                                         
     seg7x16  seg_uut(
            .clk(clk_in),
            .reset(reset),
           // .cs(seg7_cs),
            .cs(1'b1),
            .i_data(pc),
            .o_seg(o_seg),
            .o_sel(o_sel)
                         );                    
    
endmodule

