`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2022 01:40:45 PM
// Design Name: 
// Module Name: time_counter
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


module time_counter(
    input CE,
    input R,
    input clk,
    output [7:0] Q
    );
    
    wire utc_wire;
    countUD8L count1 (.clk(clk), .enable(CE & ~&Q[5:2]), .Q(Q), .R(R), .UTC(utc_wire));
    
    //wire [1:0] sel;
    
    //assign sel[0]= CE;
    //assign sel[1] = CE & utc_wire;
   
    //countUD4L count1 (.clk(clk), .enable(CE & ~utc_wire), .reset(R), .Q(Q), .UTC(utc_wire));
    //countUD4L count2 (.clk(clk), .enable(sel[1]), .reset(R), .Q(Q[7:4]));
    
endmodule
