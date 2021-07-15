# 54-single-cycle-cpu

<br>

### Introduction
A very simple <b>single cycle</b> CPU using <b>MIPS</b> architecture & <b>Harvard</b> architecture.

* <b>Num of Instruction</b> : 54
* **Instruction** :
  | No. | instruction | Format                  | OP 31-26 | RS 25-21 | RT 20-16 | RD 15-11 | SA 10-6 | FUNCT 5-0	| Hex code
  | --- | ----------- | ----------------------- | -------- | -------- | -------- | -------- | ------- | --------- | -----------
  | 1   | addi        | addi rt, rs, immediate  |  001000  |          |          |          |  00000  |  100000   | 20000000
  | 2   | addiu       | addiu rd, rs, immediate |  001001  |          |          |          |         |           | 24000000


* **Environment** :　Vivado 2016.2　Nexy4 DDR
* **compared with Mars4_5** : when testing on posedge , it delay one cycle. when testing on negedge ,the result is the same (not 100% sure).
* **run on target** : you can see PC on LED. Dividing frequency is advised.

　　　　　<img src="https://user-images.githubusercontent.com/58033867/125728314-ae55d25a-e392-4d7a-b12c-45515f59da99.png" width="300" height="300">


