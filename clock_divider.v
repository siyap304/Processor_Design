`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 21:52:07
// Design Name: 
// Module Name: clock_divider
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

module clock_divider(main_clk,slow_clk);

input main_clk;
output slow_clk;

reg [31:0]counter;

always@(posedge main_clk)
begin
counter <= counter + 1;
end                     
assign slow_clk = counter[28];

endmodule

