`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2022 01:43:56 PM
// Design Name: 
// Module Name: countUD4L
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


module countUD4L(
    input clk,
    input Up,
    input Dw,
    input enable,
    input reset,
    output [3:0] Q,
    output UTC,
    output DTC
    );
    
    wire [3:0] D, U;
    wire [3:0] out;
    
    assign UTC = Q[0] & Q[1] & Q[2] & Q[3];
    assign DTC = ~Q[0] & ~Q[1] & ~Q[2] & ~Q[3];
    assign enable = (Dw ^ Up);
    
    FDRE #(.INIT(1'b0) ) Q0_FF (.C(clk), .CE(enable), .Q(Q[0]), .D(out[0]));
    FDRE #(.INIT(1'b0) ) Q1_FF (.C(clk), .CE(enable), .Q(Q[1]), .D(out[1]));
    FDRE #(.INIT(1'b0) ) Q2_FF (.C(clk), .CE(enable), .Q(Q[2]), .D(out[2]));
    FDRE #(.INIT(1'b0) ) Q3_FF (.C(clk), .CE(enable), .Q(Q[3]), .D(out[3]));
    
    // increment
    assign U[0] = Q[0] ^ enable;
    assign U[1] = Q[1] ^ (Q[0] & enable);                  // Q[1] XOR Q[0]
    assign U[2] = Q[2] ^ (Q[1] & Q[0] & enable);           // Q[2] XOR (Q[1] AND Q[0])
    assign U[3] = Q[3] ^ (Q[2] & Q[1] & Q[0] & enable);    // Q[3] XOR (Q[1] AND Q[0] AND Q[3])
    
    //decrement
    assign D[0] = Q[0] ^ enable;
    assign D[1] = Q[1] ^ (~Q[0] & enable);                              // Q[1] XOR Q[0]
    assign D[2] = Q[2] ^ (~Q[1] & ~Q[0] & enable);                      // Q[2] XOR (Q[1] AND Q[0])
    assign D[3] = Q[3] ^ (~Q[2] & ~Q[1] & ~Q[0] & enable);              // Q[3] XOR (Q[1] AND Q[0] AND Q[3])
    
    assign out[0] = ((U[0] & Up & ~Dw) | (D[0] & ~Up & Dw));
    assign out[1] = ((U[1] & Up & ~Dw) | (D[1] & ~Up & Dw));
    assign out[2] = ((U[2] & Up & ~Dw) | (D[2] & ~Up & Dw));
    assign out[3] = ((U[3] & Up & ~Dw) | (D[3] & ~Up & Dw));
endmodule