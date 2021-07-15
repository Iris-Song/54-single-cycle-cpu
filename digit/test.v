`timescale 1ns / 1ps


module cpu_tb;
  reg clk;
  reg rst;
  wire [31:0]inst;
  wire [31:0]pc;
  
  sccomp_dataflow uut(.clk_in(clk),.reset(rst),.inst(inst),.pc(pc));
  
  integer file_output;
  integer counter = 0;
  reg [31:0]pre_pc=32'b1;
  
  initial begin
     file_output = $fopen("C:/Users/1234/Desktop/test/my_result/coe.txt");
     clk=0;
     rst=1;
     //wait 100ns for global reset to finish
     #10
     rst = 0;
     end
     
   always #2 clk=~clk;  
   always @(posedge clk)
    begin
    //&&pre_pc!=pc
      if(rst==0)
      begin
//      if(counter == 15000)
//        $fclose(file_output);
//      else begin
       pre_pc=pc;
       counter=counter+1;
      
       $fdisplay(file_output, "pc: %h", pc-32'h00400000);
       $fdisplay(file_output, "instr: %h", inst);
       $fdisplay(file_output,"regfile0: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[0]);
       $fdisplay(file_output,"regfile1: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[1]);
       $fdisplay(file_output,"regfile2: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[2]);
       $fdisplay(file_output,"regfile3: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[3]);
       $fdisplay(file_output,"regfile4: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[4]);
       $fdisplay(file_output,"regfile5: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[5]);
       $fdisplay(file_output,"regfile6: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[6]);
       $fdisplay(file_output,"regfile7: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[7]);
       $fdisplay(file_output,"regfile8: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[8]);
       $fdisplay(file_output,"regfile9: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[9]);
       $fdisplay(file_output,"regfile10: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[10]);
       $fdisplay(file_output,"regfile11: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[11]);
       $fdisplay(file_output,"regfile12: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[12]);
       $fdisplay(file_output,"regfile13: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[13]);
       $fdisplay(file_output,"regfile14: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[14]);
       $fdisplay(file_output,"regfile15: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[15]);
       $fdisplay(file_output,"regfile16: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[16]);
       $fdisplay(file_output,"regfile17: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[17]);
       $fdisplay(file_output,"regfile18: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[18]);
       $fdisplay(file_output,"regfile19: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[19]);
       $fdisplay(file_output,"regfile20: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[20]);
       $fdisplay(file_output,"regfile21: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[21]);
       $fdisplay(file_output,"regfile22: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[22]);
       $fdisplay(file_output,"regfile23: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[23]);
       $fdisplay(file_output,"regfile24: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[24]);
       $fdisplay(file_output,"regfile25: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[25]);
       $fdisplay(file_output,"regfile26: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[26]);
       $fdisplay(file_output,"regfile27: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[27]);
       $fdisplay(file_output,"regfile28: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[28]);
       $fdisplay(file_output,"regfile29: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[29]);
       $fdisplay(file_output,"regfile30: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[30]);
       $fdisplay(file_output,"regfile31: %h",cpu_tb.uut.sccpu.cpu_ref.array_reg[31]);
       //$fdisplay(file_output,"Rs: %h",cpu_tb.uut.sccpu.Rs);
       //$fdisplay(file_output,"PC_IN: %h",cpu_tb.uut.sccpu.PC_IN);
       //$fdisplay(file_output,"PC: %h",cpu_tb.uut.sccpu.PC);
       //$fdisplay(file_output,"mux: %b",cpu_tb.uut.sccpu.MUX_OUT[2:0]);
     //  $fdisplay(file_output,"mul_op: %b",cpu_tb.uut.sccpu.cu_uut.mul_op);
    //   $fdisplay(file_output,"hi_in: %h",cpu_tb.uut.sccpu.HI_IN);
       //$fdisplay(file_output,"lo_in: %h",cpu_tb.uut.sccpu.LO_IN);
      // $fdisplay(file_output,"hi_ena: %h",cpu_tb.uut.sccpu.HI_ENA);
      // $fdisplay(file_output,"lo_ena: %h",cpu_tb.uut.sccpu.LO_ENA);
      // $fdisplay(file_output,"Rs: %h",cpu_tb.uut.sccpu.Rs);
       //$fdisplay(file_output,"MUX_OUT[14:13]: %b",cpu_tb.uut.sccpu.MUX_OUT[14:13]);
       //$fdisplay(file_output,"divu_q: %h",cpu_tb.uut.sccpu.DIVU_Q);
       //$fdisplay(file_output,"divu_r: %h",cpu_tb.uut.sccpu.DIVU_R);
      // $fdisplay(file_output,"b: %h",cpu_tb.uut.sccpu.ALU_b);
       //$fdisplay(file_output,"a: %h",cpu_tb.uut.sccpu.ALU_r);
       //$fdisplay(file_output,"wdata: %h",cpu_tb.uut.sccpu.cpu_ref.wdata);
       //$fdisplay(file_output,"waddr: %h",cpu_tb.uut.sccpu.cpu_ref.waddr);
       end       
      end
//    end
endmodule
