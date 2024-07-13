`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 21:53:17
// Design Name: 
// Module Name: Processor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Processor(main_clk,reset, out, register, ae, AR,CB,PC);

input main_clk;
reg [7:0] acc;
output reg [7:0]out;
output reg [7:0]register;
input reset,ae;
input [3:0] AR;
//wire slow_clk;

//clock_divider inst (main_clk, slow_clk);

reg [7:0] ext;
output reg CB;
reg [7:0] Register_file [15:0];
reg [7:0] ins_memory [15:0];
output reg [3:0] PC;
reg [7:0] IR;

integer i;
reg [7:0] a1,b1,p1;

always @(posedge main_clk) begin
        if (reset == 0)begin
        Register_file[4'b0000] = 2;
        Register_file[4'b0001] = 240;
        Register_file[4'b0010] = 154;
        Register_file[4'b0011] = 45;
        Register_file[4'b0100] = 42;
        Register_file[4'b0101] = 12;
        Register_file[4'b0110] = 15;
        Register_file[4'b0111] = 112;
        Register_file[4'b1000] = 123;
        Register_file[4'b1001] = 3;
        Register_file[4'b1010] = 197;
        Register_file[4'b1011] = 42;
        Register_file[4'b1100] = 14;
        Register_file[4'b1101] = 0;
        Register_file[4'b1110] = 256;
        Register_file[4'b1111] = 255;
        
        ins_memory[4'b0000] = 8'b00000000;
        ins_memory[4'b0001] = 8'b10101111;
        ins_memory[4'b0010] = 8'b00111100;
        ins_memory[4'b0011] = 8'b01001010;
        ins_memory[4'b0100] = 8'b10111010;
        ins_memory[4'b0101] = 8'b10010001;
        ins_memory[4'b0110] = 8'b01100001;
        ins_memory[4'b0111] = 8'b00010101;
        ins_memory[4'b1000] = 8'b00010110;
        ins_memory[4'b1001] = 8'b01111111;
        ins_memory[4'b1010] = 8'b10000000;
        ins_memory[4'b1011] = 8'b00000001;
        ins_memory[4'b1100] = 8'b00000110;
        ins_memory[4'b1101] = 8'b11111111;
        ins_memory[4'b1110] = 8'b00000001;
        ins_memory[4'b1111] = 8'b00000000;

//        ins_memory[4'b0000] = 8'b00000000;
//        ins_memory[4'b0001] = 8'b00000000;
//        ins_memory[4'b0010] = 8'b00000000;
//        ins_memory[4'b0011] = 8'b00000000;
//        ins_memory[4'b0100] = 8'b00000000;
//        ins_memory[4'b0101] = 8'b00000101;
//        ins_memory[4'b0110] = 8'b00000111;
//        ins_memory[4'b0111] = 8'b01011101;
//        ins_memory[4'b1000] = 8'b00000011;
//        ins_memory[4'b1001] = 8'b00100000;
//        ins_memory[4'b1010] = 8'b00000000;
//        ins_memory[4'b1011] = 8'b00000100;
//        ins_memory[4'b1100] = 8'b00000010;
//        ins_memory[4'b1101] = 8'b11111111;
//        ins_memory[4'b1110] = 8'b00000000;
//        ins_memory[4'b1111] = 8'b00000000;

//        ins_memory[4'b0000] = 8'b00000000;
//        ins_memory[4'b0001] = 8'b01011001;
//        ins_memory[4'b0010] = 8'b10111011;
//        ins_memory[4'b0011] = 8'b00000000;
//        ins_memory[4'b0100] = 8'b00000000;       
//        ins_memory[4'b0101] = 8'b00010000;
//        ins_memory[4'b0110] = 8'b10100001;
//        ins_memory[4'b0111] = 8'b00101100;
//        ins_memory[4'b1000] = 8'b01111101;
//        ins_memory[4'b1001] = 8'b10010001;
//        ins_memory[4'b1010] = 8'b10000000;
//        ins_memory[4'b1011] = 8'b01101001;
//        ins_memory[4'b1100] = 8'b11111111;
//        ins_memory[4'b1101] = 8'b00000000;
//        ins_memory[4'b1110] = 8'b00000001;
//        ins_memory[4'b1111] = 8'b00000000;
             
        
        acc = 2;
        ext = 0;
        CB = 0;
        PC = 4'b0101;
        end
        else begin
        IR = ins_memory[PC];
        case (IR[7:4])
            4'b0000 : case (IR[3:0])
                            4'b0000 : acc = acc;
                            4'b0001 : acc = acc << 1;
                            4'b0010 : acc = acc >> 1;
                            4'b0011 : acc = {acc[0],acc[7:1]};
                            4'b0100 : acc = {acc[6:0],acc[7]};
                            4'b0101 : if (acc[7] == 0) acc = acc >> 1;
                                      else acc = {1'b1, acc[7:1]};
                            4'b0110 : {CB, acc} = acc + 1'b1;
                            4'b0111 : {CB, acc} = acc - 1'b1;
                      endcase
            4'b0001 : {CB, acc} = acc + Register_file[IR[3:0]];
            4'b0010 : {CB, acc} = acc - Register_file[IR[3:0]];
            4'b0011 : {ext, acc} = acc * Register_file[IR[3:0]];           
            4'b0100 : begin
                        p1 = 0; a1 = Register_file[IR[3:0]]; b1 = acc;
                        for (i = 0; i < 8; i = i +1)begin
                            p1 = {p1[6:0], a1[7]};
                            a1[7:1] = a1[6:0];
                            p1 = p1 - b1;
                            if (p1[7] == 1)begin
                                a1[0] = 0;
                                p1 = p1 + b1;
                            end 
                            else a1[0] = 1;
                        end
                        acc = a1;
                        ext = p1;
                      end
            4'b0101 : acc = acc & Register_file[IR[3:0]];
            4'b0110 : acc = acc ^ Register_file[IR[3:0]];
            4'b0111 : CB = (acc == Register_file[IR[3:0]]);
            4'b1000 : if (CB == 1) PC = IR[3:0];
            4'b1001 : acc = Register_file[IR[3:0]]; 
            4'b1010 : Register_file[IR[3:0]] = acc;
            4'b1011 : PC = IR[3:0];
            4'b1111 : $finish;
        endcase
    PC = PC + 1'b1;
    end
end

always @(*)begin
    register = Register_file[AR];
    if (ae == 1) out = acc;
    else out = ext;
end

endmodule
