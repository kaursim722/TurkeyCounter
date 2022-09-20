`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2022 11:21:14 AM
// Design Name: 
// Module Name: turkey_counter
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


module turkey_counter(
    input up,
    input dw,
    input clk,
    input R,
    output [7:0] Q,
    output [7:0] D,
    output DTC,
    output UTC,
    output Z
    );
    
    wire [1:0] utc_wire;
    wire [1:0] dtc_wire;
    wire [7:0] invert;
    wire [7:0] c;
    
    assign Z = &(~(Q[7:0]));
    assign UTC = utc_wire[1] & utc_wire[0];
    assign DTC = dtc_wire[1] & dtc_wire[0];
    
    countUD4L count1 (.clk(clk), .Up(up), .Dw(dw), .reset(R), .Q(Q[3:0]), .UTC(utc_wire[0]), .DTC(dtc_wire[0]));
    countUD4L count2 (.clk(clk), .Up(up & utc_wire[0] & ~dw), .reset(R), .Dw(dw & dtc_wire[0] & ~up), .UTC(utc_wire[1]), .DTC(dtc_wire[1]), .Q(Q[7:4]));
    
endmodule
