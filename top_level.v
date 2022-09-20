`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2022 11:22:18 AM
// Design Name: 
// Module Name: top_level
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


module top_level(
    input btnR,
    input btnL,
    input btnU,
    input clkin,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [15:0] led
    );
    
    //wires for lab6_clks
    wire clk;
    wire digsel;
    wire qsec;
    
    //wires for two's comp and neg logic 
    wire [6:0] twos_final;
    wire [7:0] inc_wire;
    
    wire [6:0] seg_wire;
    wire [6:0] seg2_wire;
    
    //wires for state machine outputs
    wire up, down;
    wire idle_wire;
    wire start_left_wire;
    wire both_fromL_wire;
    wire right_fromL_wire;
    wire start_right_wire;
    wire both_fromR_wire;
    wire left_fromR_wire;
    
    //counter output buses
    wire [15:0] sel_input;
    wire [7:0] time_counter_wire;
    wire [7:0] turkey_counter_wire;
    
    wire btnL_wire;
    wire btnR_wire;
    wire [3:0] ring_wire;
    wire [3:0] sel_wire;
    
    // flip flops for syncronization of buttons
    FDRE #(.INIT(1'b0) ) sync_L (.C(clk), .CE(1'b1), .Q(btnL_wire), .D(btnL));
    FDRE #(.INIT(1'b0) ) sync_R (.C(clk), .CE(1'b1), .Q(btnR_wire), .D(btnR));
    
    assign sel_input[15:12] = time_counter_wire[5:2];
    assign sel_input[11:7] = 5'b00000;
    assign sel_input[6:0] = twos_final; 
    assign led[9] = ~btnR;
    assign led[15] = ~btnL;
    assign led[8:0] = 9'b000000000;
    assign led[14:10] = 5'b00000; 
 
    // muxes for negative logic
    m2_1x8 mux1 (.in0(seg_wire), .in1(seg2_wire), .sel(ring_wire[2]), .o(seg));
    m2_1x8 mux3 (.in0(7'b1111111), .in1(7'b0111111), .sel(turkey_counter_wire[7]), .o(seg2_wire));
    
    //logic for two's complement
    incrementer inc_mod (.in_a(~turkey_counter_wire), .in_b(turkey_counter_wire[7]), .sum(inc_wire)); 
    m2_1x8 mux2 (.in0(turkey_counter_wire), .in1(inc_wire), .sel(turkey_counter_wire[7]), .o(twos_final));
    
    //logic for an
    assign an[0] = ~ring_wire[0];
    assign an[1] = ~ring_wire[1]; 
    assign an[2] = ~(ring_wire[2]);
    assign an[3] = ~(ring_wire[3] & (btnR | btnL));
    assign dp = 1'b1;
   
   
    // call all functions
    lab6_clks slowit (.clkin(clkin), .greset(btnU), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    time_counter tc (.clk(clk), .R(~btnR_wire & ~btnL_wire), .CE(qsec & (btnL | btnR)), .Q(time_counter_wire));
    
    turkey_counter turk (.clk(clk), .up(up), .R(btnU), .dw(down), .Q(turkey_counter_wire));
    
    state_machine sm (.clk(clk), .btnR(btnL_wire), .btnL(btnR_wire), .inc(up), .dec(down), .idle(idle_wire), .start_left(start_left_wire), .both_fromL(both_fromL_wire), .right_fromL(right_fromL_wire), .start_right(start_right_wire), .both_fromR(both_fromR_wire), .left_fromR(left_fromR_wire));
    
    ring_counter rc (.Advance(digsel), .clk(clk), .out(ring_wire));
    
    selector sel (.N(sel_input), .sel(ring_wire), .H(sel_wire));
    
    hex7seg hex (.n(sel_wire), .seg(seg_wire)); 
    
    
    
endmodule
