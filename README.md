# 54-single-cycle-cpu

<br>

### Introduction
A very simple <b>single cycle</b> CPU using <b>MIPS</b> architecture & <b>Harvard</b> architecture.

* <b>Num of Instruction</b> : 54
* **Instruction** :  
  | No. | instruction | Format                  | OP <br>31-26 | RS<br> 25-21 | RT<br> 20-16 | RD<br> 15-11 | SA<br> 10-6 | FUNCT<br> 5-0	| Hex code
  | --- | ----------- | ----------------------- | -------- | -------- | -------- | -------- | ------- | --------- | -----------
  | 1   | addi        | addi rt, rs, immediate  |  001000  |          |          |          |  00000  |  100000   | 20000000
  | 2   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000
  | 3   | andi        | andi rt, rs, immediate  |  001100  |          |          |          |         |           | 30000000
  | 4   | ori		      | ori rt, rs, immediate	  |  001101  |          |          |          |         |           | 34000000
  | 5   | sltiu		    | sltiu rt, rs, immediate	|  001011  |          |          |          |         |           | 2C000000
  | 6   | lui		      | lui rt, immediate	      |  001111  |  00000   |          |          |         |           | 3C000000
  | 7   | xori        | xori rt, rs, immediate  |  001110  |          |          |   00000  |  00000  |   000000  | 38000000
  | 8   | slti        | slti rt, rs, immediate  |  001010  |          |          |   00000  |  00000  |   000000  | 28000000
  | 9   | addu	      | addu rd, rs, rt |  000000  |          |          |          |    00000     |    100001       | 00000021
  | 10  | and	     | and rd, rs, rt |  000000  |          |          |          |    00000 |  100100    | 00000024
  | 11  | beq		     | beq rs, rt, offset |  000100  |          |          |          |         |           | 10000000 
  | 12   | bne			  | bne rs, rt, offset |  000101  |          |          |          |         |           | 14000000
  | 13   | j			   | j target |  000010  |          |          |          |         |           | 08000000
  | 14   |jal		     | jal target |  000011  |          |          |          |         |           |0C000000
  | 15   | jr							     | jr rs	 |  000000  |          |          |          |         |      001000     | 00000009 
   | 16   | lw		     | lw rt, offset(base) |  100011  |          |          |          |         |           | 8C000000
  | 17   | xor		   | xor rd, rs, rt |  000000  |          |          |          |  00000   |  100110   | 00000026
  | 18   | nor		    | nor rd, rs, rt |  000000  |          |          |          |  00000  |  100111    | 00000027
  | 19   | or			    | or rd, rs, rt |  000000  |          |          |          |   00000   |   100101  | 00000025 
  | 20   | sll		     | sll rd, rt, sa |  000000  |  00000   |          |          |         |  	000000   | 00000000
  | 21  | sllv		   | sllv rd, rt, rs | 000000  |     00000     |          |          |         |    000100    | 00000004
  | 22   | sltu		    | sltu rd, rs, rt |  000000  |          |          |          |  00000  |  101011    | 0000002B
   | 23   | sra			   | sra rd, rt, sa |  000000  |00000     |          |          |         |  000011   | 00000003
  | 24 | srl								    | srl rd, rt, sa |  000000  |  00000   |          |          |         |  000010  | 00000002   
  | 25   | subu		    | sub rd, rs, rt |  000000  |          |          |          |  00000   |  100010    | 00000022
  | 26   | sw	|sw rt, offset(base)	|101011	|					                 |          |          |         |           | AC000000 
  | 27   | add	|add rd, rs, rt|	000000	|	|	||	00000|	100000|	00000020               
  | 28  | sub|	sub rd, rs, rt|	000000	||||			00000	|100010|	00000022      
  | 29   | slt|	slt rd, rs, rt|	000000||||				00000|	101010|	0000002A       
   | 30   | srlv	|srlv rd, rt, rs|	000000	||||			00000|	000110|	00000006       
  | 31   | srav	|srav rd, rt, rs	|000000	||||			00000	|000111	|00000007       
  | 32   |clz	|clz rd, rs|	011100	||||			00000	|100000	|70000020     
  | 33   | divu	|divu rs, rt|	000000	|||		00000|	00000	|011011|	0000001B      
  | 34   | eret	|eret	|010000|	10000|	00000|	00000|	00000|	011000|	42000018  
  | 35   | jalr	|jalr rs|	000000||		00000	||	|	001001|	00000008
  | 36   | lb	|lb rt, offset(base)|	100000	||||||					80000000      
  | 37   | lbu|	lbu rt, offset(base)|	100100	||||||		90000000     
  | 38   | lhu	|lhu rt, offset(base)|	100101		||||||				94000000      
  | 39   | sb	|sb rt, offset(base)	|101000		||||||	A0000000      
  | 40   | sh	|sh rt, offset(base)	|101001		||||||	A4000000      
  | 41   | lh	|lh rt, offset(base)	|100001		||||||				84000000      
  | 42   | mfc0	|mfc0 rt, rd	|010000|	00000	|	||	00000|	000000|	40000000      
  | 43   | mfhi	|mfhi rd|	000000|	00000|	|	00000	|	00000	|010000	|00000010       
  | 44   | mflo	|mflo rd|	000000|	00000||	00000	|	00000|	010010|	00000012      
  | 45   | mtc0	|mtc0 rt, rd|	010000|	00100|||			|00000	|000000	|40800000      
  | 46   | mthi	|mthi rd|	000000||		00000|	00000|	00000|	010001|	00000011     
  | 47   | mtlo	|mtlo rd |	000000| |		00000|	00000|	00000|	010011|	00000013     
  | 48   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000
  | 49   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000
| 50   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000
   | 51   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000
  | 52   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000
  | 53   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000
  | 54   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000  
  
* **Environment** :　Vivado 2016.2　Nexy4 DDR
* **compared with Mars4_5** : when testing on posedge , it delay one cycle. when testing on negedge ,the result is the same (not 100% sure).
* **run on target** : you can see PC on LED. Dividing frequency is advised.

　　　　　<img src="https://user-images.githubusercontent.com/58033867/125728314-ae55d25a-e392-4d7a-b12c-45515f59da99.png" width="300" height="300">


