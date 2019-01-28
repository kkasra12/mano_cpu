# mano_cpu
a simulation of Mano CPU in verilog

## Contents:
1. <b> main_file.v </b>: Is the cpu!!!<br>Its written in behavieral level using verilog language
2. <b> tb_minus.v </b>: Is a test bench that runs:
```
ORG 100
LDA SUB
CMA 
INC
ADD MIN
STA DIF
HLT
MIN, DEC 83
MIN, DEC -23
DIF, HEX 0
END
```
3. <b> tb_add.v </b>: Is a test bench that runs:
```
ORG 0
LDA A
ADD B
STA C
HLT
A, DEC 83
B, DEC -23
C, HEX 0
END
```

## NOTE:
1. There is a run_code signal:
   - if its Zero: CPU will listen to `code` and `address` signals and will write them on memory .
   - if its One: CPU will start executing codes at `pc` location.
2. All input and output signals are x in these test benchs(and its normal because we dont have any I/O), it means u should check the answer in memry list.
3. The initial value for <b>pc</b> must be set correctly for each test bench. <b>!IMPORTANT</b>
4. There is an output signal `test` and also an always block at line 72 that can be used for debuging and showing internal register values.  
