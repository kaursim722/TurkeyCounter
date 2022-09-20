`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2022 02:42:09 PM
// Design Name: 
// Module Name: ring_counter
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


module ring_counter(
    input clk,
    input Advance,
    output [3:0] out
    );
    
    FDRE #(.INIT(1'b1) ) ring3 (.C(clk), .R(1'b0), .CE(Advance), .D(out[3]), .Q(out[0]));
    FDRE #(.INIT(1'b0) ) ring2 (.C(clk), .R(1'b0), .CE(Advance), .D(out[0]), .Q(out[1]));
    FDRE #(.INIT(1'b0) ) ring1 (.C(clk), .R(1'b0), .CE(Advance), .D(out[1]), .Q(out[2]));
    FDRE #(.INIT(1'b0) ) ring0 (.C(clk), .R(1'b0), .CE(Advance), .D(out[2]), .Q(out[3]));
    
endmodule