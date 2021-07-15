`timescale 1ns / 1ps

module DIV(
    input [31:0]dividend,       //������               
    input [31:0]divisor,        //����   
    input start,                //������������      
    input clock,      
    input reset,   
    output [31:0]q,             //��      
    output [31:0]r,             //����         
    output reg busy            //������æ��־λ 
    );
    
    wire ready;
    reg[4:0] count;
    reg[31:0] reg_q;
    reg[31:0] reg_r;
    reg[31:0] reg_b;
    reg r_sign;
    
    wire [31:0] dividend_temp;
    wire [31:0] divisor_temp;
    wire [31:0] q_temp;
    wire [31:0] r_temp;
    
    assign dividend_temp=dividend[31]?(~dividend+1):dividend;
    assign divisor_temp=divisor[31]?(~divisor+1):divisor;
    
    wire[32:0] sub_add=r_sign?({reg_r,q_temp[31]}+{1'b0,reg_b}):({reg_r,q_temp[31]}-{1'b0,reg_b});
    assign r_temp=r_sign?reg_r+reg_b:reg_r;
    assign q_temp=reg_q;
    
    assign r=dividend[31]?(~r_temp+1):r_temp;
    assign q=(dividend[31]==divisor[31])?q_temp:(~q_temp+1);
    
    always @(posedge clock or posedge reset)
    begin
        if(reset)
        begin
            count<=5'b0;
            busy<=0;
        end
        else
        begin
            if(start)
            begin
                reg_r<=32'b0;
                r_sign<=0;
                reg_q<=dividend_temp;
                reg_b<=divisor_temp;
                count<=5'b0;
                busy<=1'b1;
            end
            else if(busy)
            begin
                reg_r<=sub_add[31:0];
                r_sign<=sub_add[32];
                reg_q<={reg_q[30:0],~sub_add[32]};
                count<=count+5'b1;
                if(count==5'd31)busy<=0;
            end
        end
    end 
endmodule