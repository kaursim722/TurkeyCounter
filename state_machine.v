`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2022 11:21:49 AM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
    input clk,
    input btnL,
    input btnR,
    input btnU,
    output dec,
    output inc,
    output idle,
    output start_left,
    output both_fromL,
    output right_fromL,
    output start_right,
    output both_fromR,
    output left_fromR
    );
    
    wire [6:0] D;
    wire [6:0] Q;
    
    assign idle = Q[0];
    assign start_right = Q[1];
    assign both_fromR = Q[2];
    assign left_fromR = Q[3];
    assign start_left = Q[4];
    assign both_fromL = Q[5];
    assign right_fromL = Q[6];
    
    assign inc = Q[6] & D[0];
    assign dec = Q[3] & D[0];
    
    assign D[0] = (Q[4] & ~btnL & ~btnR) | (Q[3] & ~btnL & ~btnR) | (Q[6] & ~btnL & ~btnR) | (Q[1] & ~btnL & ~btnR) | (Q[0] & ~btnL & ~btnR);
    assign D[1] = (Q[0] & ~btnL & btnR) | (Q[1] & ~btnL & btnR) | (Q[2] & ~btnL & btnR);
    assign D[2] = (Q[1] & btnL & btnR) | (Q[2] & btnL & btnR) | (Q[3] & btnL & btnR);
    assign D[3] = (Q[2] & btnL & ~btnR) | (Q[3] & btnL & ~btnR);
    assign D[4] = (Q[0] & btnL & ~btnR) | (Q[4] & btnL & ~btnR) | (Q[5] & btnL & ~btnR);
    assign D[5] = (Q[6] & btnL & btnR) | (Q[5] & btnL & btnR) | (Q[4] & btnL & btnR);
    assign D[6] = (Q[6] & ~btnL & btnR) | (Q[5] & ~btnL & btnR);
    
    FDRE #(.INIT(1'b1) ) state1 (.C(clk), .CE(1'b1), .Q(Q[0]), .D(D[0]));
    FDRE #(.INIT(1'b0) ) state2 (.C(clk), .CE(1'b1), .Q(Q[1]), .D(D[1]));
    FDRE #(.INIT(1'b0) ) state3 (.C(clk), .CE(1'b1), .Q(Q[2]), .D(D[2]));
    FDRE #(.INIT(1'b0) ) state4 (.C(clk), .CE(1'b1), .Q(Q[3]), .D(D[3]));
    FDRE #(.INIT(1'b0) ) state5 (.C(clk), .CE(1'b1), .Q(Q[4]), .D(D[4]));
    FDRE #(.INIT(1'b0) ) state6 (.C(clk), .CE(1'b1), .Q(Q[5]), .D(D[5]));
    FDRE #(.INIT(1'b0) ) state7 (.C(clk), .CE(1'b1), .Q(Q[6]), .D(D[6]));
    
endmodule
