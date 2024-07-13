# Processor_Design

The aim to design a processor which has a register file consisting of 16 registers each of 8 bit. The processor can execute the a set of instructions. 

Register_file is the file in which data is stored and ins_memory is the memory in which instructions are stored.

#### Executing intructions
The instructions that need 2 operands will take one of the operand from the Register file and another from the accumulator. The result will be transferred to Accumulator. 

#### EXT register
There is an 8-bit extended (EXT) register used only during multiplication and division operation. This register stores the higher order bits during multiplication and quotient during division. 

#### C/B register
The C/B register holds the carry and borrow during addition and subtraction, respectively.

#### Reset Signal
The reset signal resets the processor to the defined initial values when reset is 0 and performs the instructions when reset is 1.

#### IR and PC
Register IR is used to access the instruction which is being currently run and PC is the program counter which stores the address of the instruction to be run.

#### Control Signal - ae
The control signal ‘ae’ controls the output ‘out’ which is displayed on the FPGA board, out stores the value of accumulator when ae = 1 and stores the value of ext when ae = 0.

#### Register names 'resgiter'
The register named ‘register’ outputs the value of the Resgiter_file according to the control signal AR. ‘register’ stores the data value of the data stored at memory location given by AR.


#### 
Here is the video representaion of the processor implemented on BASYS3 board - [processor](https://drive.google.com/file/d/1fS46G-evnjZJvvhHRo4AQOHD2yyPIa_M/view?usp=sharing)

Here is the verilog file for the design - [verilog](https://drive.google.com/file/d/17sn1dGt2OUcFvrcrlaF2K8Nw1NFW_ZPb/view?usp=sharing)