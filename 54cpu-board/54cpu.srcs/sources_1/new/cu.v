`timescale 1ns / 1ps

module cu(
   input  [31:0]inst,
   output [14:0]mux,
   input zf,
   input nf,
   output [3:0] aluc,
   output rf_we,
   output dm_ena,
   output dm_w,
   output dm_r,
   output [2:0]dm_sel,
   output mfc0,
   output mtc0,
   output exception,
   output eret,
   output [4:0]cause,
   output hi_ena,
   output lo_ena,
   output divu_ena,
   output div_ena
    );
    
    //31 inst
    wire add_op, addu_op, sub_op, subu_op, and_op, or_op, xor_op, nor_op;
    wire slt_op, sltu_op, sll_op, srl_op, sra_op, sllv_op, srlv_op, srav_op, jr_op;
    assign add_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b100000)?1'b1:1'b0;
    assign addu_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b100001)?1'b1:1'b0;
    assign sub_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b100010)?1'b1:1'b0;
    assign subu_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b100011)?1'b1:1'b0;
    assign and_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b100100)?1'b1:1'b0;
    assign or_op   = (inst[31:26]==6'b000000&&inst[5:0]==6'b100101)?1'b1:1'b0;
    assign xor_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b100110)?1'b1:1'b0;
    assign nor_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b100111)?1'b1:1'b0;
    assign slt_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b101010)?1'b1:1'b0;
    assign sltu_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b101011)?1'b1:1'b0;
    assign sll_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b000000)?1'b1:1'b0;
    assign srl_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b000010)?1'b1:1'b0;
    assign sra_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b000011)?1'b1:1'b0;
    assign sllv_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b000100)?1'b1:1'b0;
    assign srlv_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b000110)?1'b1:1'b0;
    assign srav_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b000111)?1'b1:1'b0;
    assign jr_op   = (inst[31:26]==6'b000000&&inst[5:0]==6'b001000)?1'b1:1'b0;
    
    wire addi_op, addiu_op, andi_op, ori_op, xori_op;
    wire  lw_op, sw_op, beq_op, bne_op,slti_op, sltiu_op, lui_op;
    assign addi_op = (inst[31:26]==6'b001000)?1'b1:1'b0;
    assign addiu_op= (inst[31:26]==6'b001001)?1'b1:1'b0;
    assign andi_op = (inst[31:26]==6'b001100)?1'b1:1'b0;
    assign ori_op  = (inst[31:26]==6'b001101)?1'b1:1'b0;
    assign xori_op = (inst[31:26]==6'b001110)?1'b1:1'b0;
    assign lw_op   = (inst[31:26]==6'b100011)?1'b1:1'b0;
    assign sw_op   = (inst[31:26]==6'b101011)?1'b1:1'b0;
    assign beq_op  = (inst[31:26]==6'b000100)?1'b1:1'b0;
    assign bne_op  = (inst[31:26]==6'b000101)?1'b1:1'b0;
    assign slti_op = (inst[31:26]==6'b001010)?1'b1:1'b0;
    assign sltiu_op= (inst[31:26]==6'b001011)?1'b1:1'b0;
    assign lui_op  = (inst[31:26]==6'b001111)?1'b1:1'b0;
    
    wire j_op, jal_op;
    assign j_op    = (inst[31:26]==6'b000010)?1'b1:1'b0;
    assign jal_op  = (inst[31:26]==6'b000011)?1'b1:1'b0;
    
    //32-54 inst
    wire clz_op,divu_op,div_op,multu_op,mul_op;
    assign clz_op  = (inst[31:26]==6'b011100&&inst[5:0]==6'b100000)?1'b1:1'b0;
    assign divu_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b011011)?1'b1:1'b0;
    assign div_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b011010)?1'b1:1'b0;
    assign multu_op= (inst[31:26]==6'b000000&&inst[5:0]==6'b011001)?1'b1:1'b0;
    assign mul_op  = (inst[31:26]==6'b011100&&inst[5:0]==6'b000010)?1'b1:1'b0;//*÷∏µº È
    //assign mul_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b011000)?1'b1:1'b0;
    
    wire lb_op,lbu_op, lh_op,lhu_op, sb_op,sh_op;  
    wire mfhi_op,mflo_op,mthi_op,mtlo_op;
    assign lb_op   = (inst[31:26]==6'b100000)?1'b1:1'b0;
    assign lbu_op  = (inst[31:26]==6'b100100)?1'b1:1'b0;
    assign lh_op   = (inst[31:26]==6'b100001)?1'b1:1'b0;
    assign lhu_op  = (inst[31:26]==6'b100101)?1'b1:1'b0;  
    assign sb_op   = (inst[31:26]==6'b101000)?1'b1:1'b0;
    assign sh_op   = (inst[31:26]==6'b101001)?1'b1:1'b0;
    assign mfhi_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b010000)?1'b1:1'b0;
    assign mflo_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b010010)?1'b1:1'b0; 
    assign mthi_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b010001)?1'b1:1'b0;
    assign mtlo_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b010011)?1'b1:1'b0;
    
    wire bgez_op,jalr_op;
    assign bgez_op = (inst[31:26]==6'b000001)?1'b1:1'b0;
    assign jalr_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b001001)?1'b1:1'b0;
    
    wire mfc0_op,mtc0_op,syscall_op,teq_op,break_op,eret_op; 
    assign mfc0_op = (inst[31:26]==6'b010000&&inst[25:21]==5'b00000)?1'b1:1'b0;
    assign mtc0_op = (inst[31:26]==6'b010000&&inst[25:21]==5'b00100)?1'b1:1'b0;
    assign syscall_op = (inst[31:26]==6'b000000&&inst[5:0]==6'b001100)?1'b1:1'b0;
    assign teq_op  = (inst[31:26]==6'b000000&&inst[5:0]==6'b110100)?1'b1:1'b0;
    assign break_op= (inst[31:26]==6'b000000&&inst[5:0]==6'b001101)?1'b1:1'b0;
    assign eret_op = (inst[31:26]==6'b010000&&inst[5:0]==6'b011000)?1'b1:1'b0;
    
    /*------------------------------PC-----------------------------*/
    //mux[2:0] select pc_in
    //binary: 001 is jal_op | j_op ; 010 is jr_op | jalr_op ; 011 is syscall | break | teq & zf;100 is (beq_op & zf) |( bne_op & !zf) |(bgez_op & !nf) ; 101 is eret; 000 is others
    //sel: 000--NPC; 001--'||'; 010--'Rf.rs'; 011--32'h00400004; 100--sExt18+NPC
    assign mux[0]=jal_op || j_op || eret_op || syscall_op || break_op || teq_op & zf;
    assign mux[1]=jr_op || jalr_op || syscall_op || break_op || teq_op & zf;
    assign mux[2]=(beq_op & zf)||( bne_op & !zf)||(bgez_op & !nf)|| eret_op;// 0 is pc+4, 1 is ext18 + npc*
    
    /*------------------------------ALU-----------------------------*/
    assign aluc[3] = slt_op || sltu_op || sllv_op || srlv_op || srav_op || sll_op || srl_op || sra_op || slti_op || sltiu_op || lui_op ;
    assign aluc[2] = and_op || or_op || xor_op || nor_op || sllv_op || srlv_op || srav_op || sll_op || srl_op || sra_op || andi_op || ori_op || xori_op ;
    assign aluc[1] = add_op || sub_op || xor_op || nor_op || slt_op || sltu_op || sllv_op || sll_op || addi_op || xori_op || slti_op || sltiu_op || bgez_op;//*bgez
    assign aluc[0] = sub_op || subu_op || or_op || nor_op || slt_op || srlv_op || srl_op || ori_op || slti_op || beq_op || bne_op || bgez_op || teq_op;//*bgez,teq
    //select aluc_a; mux[4:3] 
    //binary 01-- sll_op | srl_op | sra_op ; 10--jal_op | jalr_op; 00 -- other
    assign mux[3]= sll_op || srl_op || sra_op;
    assign mux[4]= jal_op || jalr_op;
    //select aluc_b; mux[6:4] 
    //binary 001--4; 010--sExt16;100 --uExt16; 110--0; 000-Rt
    assign mux[5]= addi_op || addiu_op || sw_op || lw_op || slti_op || sltiu_op || lb_op || lbu_op || lh_op || lhu_op || sh_op || sb_op || bgez_op;
    assign mux[6]= andi_op || ori_op || xori_op || lui_op|| bgez_op;
   
    /*------------------------------RegFile-----------------------------*/
    //binary:lw is 0001, lb is 0010 , lbu is 0011 ,lh is 0100, lhu is 0101, clz is 0110 , mfhi is 0111, mflo is 1000, mfc0 is 1001, mul is 1010,jalr/jal is 1101others are 0000
    //select RegFile wData mux[10:7]
    assign mux[7] = lw_op || lbu_op || lhu_op || mfhi_op || mfc0_op || jal_op || jalr_op;
    assign mux[8] = lb_op || lbu_op || clz_op || mfhi_op || mul_op || jal_op || jalr_op;
    assign mux[9] = lh_op || lhu_op || clz_op || mfhi_op;
    assign mux[10]= mfc0_op || mflo_op || mul_op || jal_op || jalr_op;
   //select waddr mux[12:11]
    assign mux[11]= addi_op || addiu_op || lw_op || slti_op || sltiu_op || andi_op || ori_op || xori_op || lui_op || mfc0_op ||  lb_op || lbu_op || lh_op || lhu_op ;
    assign mux[12]= jal_op;
    assign rf_we = !(jr_op || beq_op || bne_op|| sw_op || j_op || bgez_op || sh_op || sb_op || mthi_op || mtlo_op || mtc0_op || syscall_op || teq_op || break_op || eret_op || multu_op || div_op ||divu_op);   
    
    /*------------------------------DMEM-----------------------------*/
    assign dm_ena = lw_op || sw_op || lb_op || lbu_op || lhu_op || lh_op || sh_op || sb_op;
    assign dm_w = sw_op || sb_op || sh_op;
    assign dm_r = lw_op || lb_op || lbu_op || lh_op || lhu_op;
    //101:lbu_op 110:lhu_op
    assign dm_sel[2] = sb_op || lb_op || lbu_op;//DM_byte,sign
    assign dm_sel[1] = sh_op || lh_op || lhu_op;//DM_half,sign
    assign dm_sel[0] = sw_op || lw_op ;//DM_word
    
   /*------------------------------CP0-----------------------------*/ 
   assign mfc0 = mfc0_op;
   assign mtc0 = mtc0_op;
   assign exception = syscall_op || break_op ||(teq_op & zf);
   assign eret = eret_op;
   assign cause= syscall_op? 5'b01000 : break_op? 5'b01001 : teq_op? 5'b01101 : 5'b0;
   
   /*------------------------------LO/HI-----------------------------*/ 
   assign hi_ena = divu_op || div_op || multu_op || mthi_op;
   assign lo_ena = divu_op || div_op || multu_op || mtlo_op;
   //sel hi_data_in&lo_data_in   divu:00;div:01;multu:10;mthi:11
   assign mux[13] = div_op || mthi_op || mtlo_op;
   assign mux[14] = multu_op || mthi_op || mtlo_op;
   
   /*-----------------------------DIV/DIVU---------------------------*/
   assign divu_ena = divu_op;
   assign div_ena  = div_op;
        
endmodule
