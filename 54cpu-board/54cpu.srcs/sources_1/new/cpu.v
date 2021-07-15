`timescale 1ns / 1ps

module cpu(
    input clk,
    input reset,
    input [31:0]inst,
    input [31:0] dm_data,
    output [31:0] Rt,
    output [31:0] alu_r,
    output [31:0] pc,
    output dm_ena,  
    output dm_w, 
    output dm_r,
    output [2:0] dm_sel
    );
    
    wire [31:0] sExt18;
    wire [31:0] sExt16,uExt16;
    wire [31:0] uExt5;
    wire [31:0] CLZ_OUT;
    wire [14:0] MUX_OUT;
    
    wire [31:0] PC,NPC;
    wire [31:0] PC_IN;
    
    wire [3:0] ALUC;//alu control
    wire ZF,CF,NF,OF;
    wire [31:0] ALU_a,ALU_b;
    
    wire RF_W; //regfiles write
    wire [4:0] Rdc,Rsc,Rtc;
    wire [31:0] Rs; 
    wire [31:0] RF_WD;
    
    wire MFC0,MTC0,EXP,ERET;
    wire [4:0]CAUSE;
    wire [31:0]STATUS,EXC_Addr,CP0_OUT;
    
    wire HI_ENA,LO_ENA;
    wire [31:0]HI_IN,LO_IN;
    wire [31:0]HI_OUT,LO_OUT;
    
    wire [63:0]MULTU_R,MULT_R;
    wire DIVU_ENA,DIV_ENA;
    wire DIVU_BUSY,DIV_BUSY;
    wire [31:0]DIVU_R,DIV_R;
    wire [31:0]DIVU_Q,DIV_Q;
    wire BUSY;
    
    assign sExt18 = {{14{inst[15]}},{inst[15:0],2'h0}};
    assign sExt16 = {{16{inst[15]}},inst[15:0]};
    assign uExt16 = {16'h0,inst[15:0]};
    assign uExt5  = {27'b0,inst[10:6]};
    clz clz_uut( .clz_in(Rs), .clz_out(CLZ_OUT));
    
    assign pc = PC;
    assign NPC = PC + 4;
    mux_8_1 pc_in_sel(
            .sel(MUX_OUT[2:0]),.oData(PC_IN),
            .iData0(NPC),.iData1({PC[31:28],inst[25:0],2'b00}),.iData2(Rs),.iData3(32'h00400004),
            .iData4(sExt18 + NPC),.iData5(EXC_Addr),.iData6(32'b0),.iData7(32'b0)
          );
  
    mux_4_1 alu_a_sel(
            .sel(MUX_OUT[4:3]),.oData(ALU_a),
            .iData0(Rs),.iData1(uExt5),.iData2(Rs),.iData3(32'bz)
          );
    mux_8_1 alu_b_sel(
            .sel(MUX_OUT[6:4]),.oData(ALU_b),
            .iData0(Rt),.iData1(32'h4),.iData2(sExt16),.iData3(32'b0),
            .iData4(uExt16),.iData5(32'bz),.iData6(32'b0),.iData7(32'b0)
          );
 
    assign Rsc = inst[25:21];
    assign Rtc = inst[20:16];
    //assign Rdc = MUX_OUT[8]? inst[20:16] :(MUX_OUT[4]? 5'd31:inst[15:11]);
    mux_16_1 rf_wdata_sel(
             .sel(MUX_OUT[10:7]),.oData(RF_WD),
             .iData0(alu_r),.iData1(dm_data),
             .iData2({{24{dm_data[7]}}, dm_data[7:0]}),.iData3({24'b0, dm_data[7:0]}),
             .iData4({{16{dm_data[15]}}, dm_data[15:0]}),.iData5({16'b0, dm_data[15:0]}),
             .iData6(CLZ_OUT),.iData7(HI_OUT),.iData8(LO_OUT),.iData9(CP0_OUT),
             .iData10(MULT_R[31:0]),.iData11(NPC),.iData12(32'bz),.iData13(32'bz),
             .iData14(32'b0),.iData15(32'b0)
            );
    mux_4_1_5bit rdc_sel(
            .sel(MUX_OUT[12:11]),.oData(Rdc),
            .iData0(inst[15:11]),.iData1(Rtc),
            .iData2(5'd31),.iData3(5'b0)   
            );//选出的位数是5位
            
    mux_4_1 hi_in(
             .sel(MUX_OUT[14:13]),.oData(HI_IN),
             .iData0(DIVU_R),.iData1(DIV_R),
             .iData2(MULTU_R[63:32]),.iData3(Rs)   
            );
    mux_4_1 lo_in(
             .sel(MUX_OUT[14:13]),.oData(LO_IN),
             .iData0(DIVU_Q),.iData1(DIV_Q),
             .iData2(MULTU_R[31:0]),.iData3(Rs)   
            );
    
    //assign BUSY = DIVU_BUSY || DIV_BUSY;
    
    pcreg pc_uut(
          .clk(clk), .reset(reset),.ena(!DIV_BUSY&&!DIVU_BUSY),
          .pc_in(PC_IN),.pc_out(PC)
         );

    regfile cpu_ref(
           .clk(clk),.rst(reset),.ena(1'b1),.we(RF_W),
           .raddr1(Rsc),.rdata1(Rs),
           .raddr2(Rtc),.rdata2(Rt),
           .waddr(Rdc),.wdata(RF_WD) 
         );
        
    alu alu_uut(
           .a(ALU_a),.b(ALU_b),.aluc(ALUC),
           .r(alu_r),
           .zero(ZF),.carry(CF),.negative(NF),.overflow(OF)
         );
       
    CP0 cp0_uut(
          .clk(clk),.rst(reset),.mfc0(MFC0),.mtc0(MTC0),
          .pc(PC),.Rd(inst[15:11]),.wdata(Rt),
          .exception(EXP),.eret(ERET),.cause(CAUSE),
          .rdata(CP0_OUT),.status(STATUS),.exc_addr(EXC_Addr)
         );   
    
    hiloreg hireg_uut(
          .clk(clk),.reset(reset),.ena(HI_ENA),
          .data_in(HI_IN),.data_out(HI_OUT)
         );
                 
    hiloreg loreg_uut(
          .clk(clk),.reset(reset),.ena(LO_ENA),
          .data_in(LO_IN),.data_out(LO_OUT)
         );  
     
    DIVU divu_uut(
          .clock(clk),.reset(reset),
          .dividend(Rs),.divisor(Rt),
          .q(DIVU_Q),.r(DIVU_R),
          .start(~DIVU_BUSY&DIVU_ENA),.busy(DIVU_BUSY)
         );
           
    DIV div_uut(
           .clock(clk),.reset(reset),
           .dividend(Rs),.divisor(Rt),
           .q(DIV_Q),.r(DIV_R),
           .start(~DIV_BUSY&DIV_ENA),.busy(DIV_BUSY)
         ); 
    
    MULTU multu_uut(
         // .clk(clk),.reset(reset),
           .a(Rs),.b(Rt),.z(MULTU_R)
    );
    
    MULT mult_uut(
         // .clk(clk),.reset(reset),
          .a(Rs),.b(Rt),.z(MULT_R)
    );    
    
    cu cu_uut(
           .inst(inst),.zf(ZF),.nf(NF),.aluc(ALUC),
           .mux(MUX_OUT),.rf_we(RF_W),
           .dm_ena(dm_ena),.dm_w(dm_w),.dm_r(dm_r),.dm_sel(dm_sel),
           .mfc0(MFC0),.mtc0(MTC0),.exception(EXP),.eret(ERET),.cause(CAUSE),
           .hi_ena(HI_ENA),.lo_ena(LO_ENA),
           .divu_ena(DIVU_ENA),.div_ena(DIV_ENA)
         );
               
endmodule
